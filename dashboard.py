"""
Library Management System - Streamlit Dashboard
Author: Anisha M.

HOW TO RUN:
1. Make sure you have run library_system.sql in MySQL Workbench first
   (this creates the library_system database with sample data).
2. Install requirements:
       pip install streamlit mysql-connector-python pandas matplotlib
3. Run the dashboard from a terminal (NOT from IDLE):
       streamlit run dashboard.py
"""

import streamlit as st
import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import webbrowser
import threading

# ------------------------------------------------------------
# PAGE SETUP
# ------------------------------------------------------------
st.set_page_config(page_title="Library Management Dashboard", layout="wide")

st.title("📚 Library Management System Dashboard")
st.caption("Prepared by Anisha M.")

# ------------------------------------------------------------
# DATABASE CONNECTION (edit these details in the sidebar)
# ------------------------------------------------------------
st.sidebar.header("Database Connection")
db_host = st.sidebar.text_input("Host", "localhost")
db_user = st.sidebar.text_input("User", "root")
db_password = st.sidebar.text_input("Password", type="password")
db_name = st.sidebar.text_input("Database", "library_system")

def get_connection():
    return mysql.connector.connect(
        host=db_host,
        user=db_user,
        password=db_password,
        database=db_name
    )

def run_query(query):
    conn = get_connection()
    df = pd.read_sql(query, conn)
    conn.close()
    return df

# ------------------------------------------------------------
# TRY CONNECTING
# ------------------------------------------------------------
try:
    test_df = run_query("SELECT 1")
    connected = True
except Exception as e:
    connected = False
    st.error(f"Could not connect to the database. Please check your credentials in the sidebar.\n\nError: {e}")

if connected:

    # ----------------------------------------------------------------
    # 1. NUMBER OF BOOKS IN LIBRARY (with names and authors)
    # ----------------------------------------------------------------
    st.header("1. Books in the Library")

    books_df = run_query("SELECT book_id, title, author, genre, total_copies FROM books")
    st.metric("Total Books", len(books_df))
    st.dataframe(books_df, use_container_width=True)

    col1, col2 = st.columns(2)

    with col1:
        st.subheader("Books per Author (Top 10)")
        author_counts = books_df["author"].value_counts().head(10)
        st.bar_chart(author_counts)

    with col2:
        st.subheader("Books by Genre")
        genre_counts = books_df["genre"].value_counts()
        fig1, ax1 = plt.subplots()
        ax1.pie(genre_counts, labels=genre_counts.index, autopct="%1.1f%%", startangle=90)
        ax1.axis("equal")
        st.pyplot(fig1)

    st.divider()

    # ----------------------------------------------------------------
    # 2. MEMBERS
    # ----------------------------------------------------------------
    st.header("2. Members")

    members_df = run_query("SELECT member_id, member_name, city, join_date, membership_status FROM members")
    st.metric("Total Members", len(members_df))
    st.dataframe(members_df, use_container_width=True)

    st.subheader("Members per City")
    city_counts = members_df["city"].value_counts()
    st.bar_chart(city_counts)

    st.divider()

    # ----------------------------------------------------------------
    # 3. BOOKS RETURNED ON TIME
    # ----------------------------------------------------------------
    st.header("3. Books Returned On Time")

    on_time_query = """
        SELECT m.member_name, b.title, ir.issue_date, ir.due_date, ir.return_date
        FROM issue_records ir
        JOIN members m ON ir.member_id = m.member_id
        JOIN books b   ON ir.book_id   = b.book_id
        WHERE ir.return_date IS NOT NULL
          AND ir.return_date <= ir.due_date
    """
    on_time_df = run_query(on_time_query)
    st.metric("Books Returned On Time", len(on_time_df))
    st.dataframe(on_time_df, use_container_width=True)

    st.divider()

    # ----------------------------------------------------------------
    # 4. BOOKS TO BE RETURNED, WITH FINE
    # ----------------------------------------------------------------
    st.header("4. Books Pending Return (With Fine)")

    pending_query = """
        SELECT m.member_name, b.title, ir.due_date,
               DATEDIFF(CURDATE(), ir.due_date) AS days_overdue,
               DATEDIFF(CURDATE(), ir.due_date) * 5 AS fine_amount
        FROM issue_records ir
        JOIN members m ON ir.member_id = m.member_id
        JOIN books b   ON ir.book_id   = b.book_id
        WHERE ir.return_date IS NULL
          AND ir.due_date < CURDATE()
    """
    pending_df = run_query(pending_query)
    st.metric("Total Fine Pending (Rs)", int(pending_df["fine_amount"].sum()) if not pending_df.empty else 0)
    st.dataframe(pending_df, use_container_width=True)

    if not pending_df.empty:
        st.subheader("Fine Amount per Member")
        fine_by_member = pending_df.groupby("member_name")["fine_amount"].sum()
        st.bar_chart(fine_by_member)

    st.divider()

    # ----------------------------------------------------------------
    # 5. MEMBERSHIP RENEWED
    # ----------------------------------------------------------------
    st.header("5. Membership Status")

    renewed_query = """
        SELECT member_name, city, join_date, renewal_date
        FROM members
        WHERE membership_status = 'Renewed'
    """
    renewed_df = run_query(renewed_query)

    col3, col4 = st.columns(2)

    with col3:
        st.subheader("Renewed Members")
        st.metric("Total Renewed", len(renewed_df))
        st.dataframe(renewed_df, use_container_width=True)

    with col4:
        st.subheader("Membership Status Split")
        status_counts = members_df["membership_status"].value_counts()
        fig2, ax2 = plt.subplots()
        ax2.pie(status_counts, labels=status_counts.index, autopct="%1.1f%%", startangle=90,
                colors=["#2ca02c", "#1f77b4", "#d62728"])
        ax2.axis("equal")
        st.pyplot(fig2)

# ------------------------------------------------------------
# Auto-launch browser when run directly via `streamlit run`
# ------------------------------------------------------------
def open_browser():
    webbrowser.open("http://localhost:8501")

if __name__ == "__main__":
    threading.Timer(1.5, open_browser).start()
