-- Delete all view for q2

SET SEARCH_PATH TO Olympics;

DROP VIEW IF EXISTS AthletePerformanceAge CASCADE;
DROP VIEW IF EXISTS AthletePerformanceHeight CASCADE;
DROP VIEW IF EXISTS AthletePerformanceWeight CASCADE;
DROP VIEW IF EXISTS AthletePerformanceAquaticsAge CASCADE;
DROP VIEW IF EXISTS AthletePerformanceTableTennisAge CASCADE;
DROP VIEW IF EXISTS AthletePerformanceVolleyballAge CASCADE;
DROP VIEW IF EXISTS AthletePerformanceAquaticsWeight CASCADE;
DROP VIEW IF EXISTS AthletePerformanceTableTennisWeight CASCADE;
DROP VIEW IF EXISTS AthletePerformanceVolleyballWeight CASCADE;
DROP VIEW IF EXISTS AthletePerformanceAquaticsHeight CASCADE;
DROP VIEW IF EXISTS AthletePerformanceTableTennisHeight CASCADE;
DROP VIEW IF EXISTS AthletePerformanceVolleyballHeight CASCADE;
