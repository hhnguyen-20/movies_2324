# app.py
from flask import Flask, render_template
from db import query

app = Flask(__name__)

@app.route("/")
def index():
    # Movies by genre (top genres)
    sql_bar = """
        SELECT genre AS category, COUNT(*) AS total_count
        FROM Genres
        GROUP BY genre
        ORDER BY total_count DESC
        LIMIT 20;
    """

    # Movies per year (time series)
    sql_line = """
        SELECT startYear AS year, COUNT(*) AS total_count
        FROM Movies
        WHERE startYear IS NOT NULL
        GROUP BY startYear
        ORDER BY startYear;
    """

    data_bar = query(sql_bar)
    
    data_line = query(sql_line)

    return render_template(
        "dashboard.html",
        data_bar=data_bar,
        data_line=data_line
    )

if __name__ == "__main__":
    app.run(debug=True)
