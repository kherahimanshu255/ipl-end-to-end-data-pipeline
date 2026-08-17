Batsman Runs = SUM('ipl_analytics deliveries'[batsman_runs])

Strike Rate = 
VAR LegalBalls = 
    CALCULATE(
        COUNT('ipl_analytics deliveries'[ball]),
        'ipl_analytics deliveries'[extras_type] <> "wides" || ISBLANK('ipl_analytics deliveries'[extras_type])
    )
VAR RunsScored = SUM('ipl_analytics deliveries'[batsman_runs])
RETURN
DIVIDE(RunsScored, LegalBalls, 0) * 100

Total Match Runs = SUM('ipl_analytics deliveries'[batsman_runs]) + SUM('ipl_analytics deliveries'[extra_runs])

Total Matches = COUNTROWS('ipl_analytics matches')

Total Runs = SUM('ipl_analytics deliveries'[batsman_runs]) + SUM('ipl_analytics deliveries'[extra_runs])

Total Wickets = 
CALCULATE(
    COUNTROWS('ipl_analytics deliveries'),
    NOT(ISBLANK('ipl_analytics deliveries'[dismissal_kind])),
    NOT('ipl_analytics deliveries'[dismissal_kind] IN {"", "0", "NA", "nan", "None"})
)