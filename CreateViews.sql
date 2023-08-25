create view PledgeView(PLEDGE ID, NAME, CREATOR, BLURB, SLUG, STATE, URL) as
select PPLEDGE ID, NAME, CREATOR, BLURB, SLUG, STATE, URL
from Database_Table;

create view DateView(PLEDGE_ID,DEADLINE, CREATED, LAUNCHED) as
select PLEDGE_ID,DEADLINE, CREATED, LAUNCHED
from Database_Table;

create view AmountPledgedOutOfGoalView(PLEDGE ID, PLEDGED, GOAL) as
select PLEDGE ID, PLEDGED, GOAL
from Database_Table;

create view CreatorInfoView(CREATOR, LOCATION) as
select CREATOR, LOCATION
from Database_Table;

create view CommunityStandingView(PLEDGE ID, REGULAR, STAFF_PICK, STARRED, SPOTLIGHT, PLEDGED PERCENTAGE) as
select PLEDGE ID, not(STAFF_PICK or STARRED or SPOTLIGHT) as REGULAR, STAFF_PICK, STARRED, SPOTLIGHT, PLEDGED/GOAL as PLEDGED PERCENTAGE
from Database_Table;

create view IndustryView(CATEGORY, PLEDGED PERCENTAGE) as
select from CATEGORY, PLEDGED PERCENTAGE
from Database_Table;