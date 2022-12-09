
SET FOREIGN_KEY_CHECKS=0;

drop table if exists Team;
drop table if exists League_Team;
drop table if exists All_Star_Team;
drop table if exists Roster;
drop table if exists player;
drop table if exists Season;
drop table if exists Staff;
drop table if exists Staff_Member;
drop table if exists Arena;
drop table if exists Game;
drop table if exists Drafts;
drop table if exists Playoffs;
drop table if exists Series;
drop table if exists IsInRoster;
drop table if exists IsOnStaff;

create table if not exists Team(
TeamName varchar(36) not null,
Conference enum("East", "West") not null,
Arena varchar(255)not null,
primary key (TeamName));

create table if not exists League_Team(
TeamName varchar(36) not null,
OwnerName varchar(36) not null,
Mascot varchar(36) not null,
HomeCity varchar(36) not null,
primary key (TeamName),
foreign key (TeamName) references Team (TeamName)
);

create table if not exists All_Star_Team(
TeamName varchar(36),
primary key (TeamName),
foreign key (TeamName) references Team (TeamName)
);

create table if not exists Roster(
Season smallint not null,
TeamName varchar(36) not null,
Wins smallint not null,
Losses smallint not null,
primary key (Season, TeamName),
foreign key (Season) references Season(StartingYear),
foreign key (TeamName) references Team (TeamName)
);

create table if not exists Player(
PlayerId mediumint not null auto_increment,
PlayerName varchar(255) not null, 
age tinyint not null,
Position Enum('PG', 'SG', 'SF', 'PF', 'C') not null, 
Salary decimal(12,2) not null, 
ContractLength tinyint not null, 
DraftSeason smallint not null,
DraftPosition tinyint not null,
primary key (PlayerId),
foreign key (DraftSeason) references Season(StartingYear));

create table if not exists Season(
StartingYear smallint not null, 
MVP mediumint, 
MIP mediumint, 
CoachYear varchar(50), 
DPY mediumint,
SixMan mediumint,
primary key (StartingYear),
foreign key(MVP) references Player(PlayerID),
foreign key(MIP) references Player(PlayerID),
foreign key(DPY) references Player(PlayerID),
foreign key(SixMan) references Player(PlayerID)
);

create table if not exists Staff(
StaffId mediumint not null auto_increment,
HireDate Date not null,
WinTotal smallint not null,
LossTotal smallint not null,
ContractLength tinyInt not null,
StaffType varchar(36),
TeamName varchar(36),
primary key (StaffId),
foreign key (TeamName) references Team (TeamName)
);

create table if not exists Staff_Member(
StaffMemberId mediumint not null auto_increment,
StaffMemberName varchar(36) not null,
JobTitle varchar(36) not null,
Salary decimal(12,2) not null,
primary key (StaffId),
foreign key (TeamName) references Team (TeamName)
);

create table if not exists Arena(
Address varchar(36) not null,
ArenaName varchar(36) not null,
Capacity mediumint not null,
primary key (Address)
);

create table if not exists Agent(
AgentId mediumint not null auto_increment,
AgentName varchar(36) not null,
YearsExp tinyint not null,
primary key (AgentId)
);

create table if not exists Game(
GameId mediumint not null auto_increment,
GameDate date not null,
HomeTeamWon bool not null,
HomeTeam varchar(36) not null,
AwayTeam varchar(36) not null,
primary key (GameId),
foreign key (HomeTeam) references Team (TeamName),
foreign key (AwayTeam) references Team (TeamName)
);

create table if not exists Drafts(
Season smallint not null,
LotteryDate date not null,
SelectionDate date not null,
Primary key (Season),
foreign key (Season) references Season (StartingYear)
);

create table if not exists Playoffs(
Season smallint not null,
WinningTeam varchar(36) not null,
Primary key (Season),
foreign key (Season) references Season (StartingYear)
);

create table if not exists Series(
RoundType enum ("First","Second","Conference Finals","Finals") not null,
Season smallint not null,
WinningTeam varchar(36) not null,
LosingTeam varchar(36) not null,
primary key (RoundType),
foreign key (WinningTeam) references Team (TeamName),
foreign key (LosingTeam) references Team (TeamName)
);

create table if not exists IsInRoster(
Season smallint not null,
TeamName varchar(36) not null,
PlayerId mediumint not null,
primary key (Season, TeamName, PlayerId),
foreign key (Season) references Season (StartingYear),
foreign key (TeamName) references Team (TeamName),
foreign key (PlayerId) references Player (PlayerId)
);

create table if not exists IsOnStaff(
StaffMemberId mediumint not null,
StaffId mediumint not null,
primary key (StaffMemberId, StaffId),
foreign key (StaffMemberId) references Staff_Member (StaffMemberId),
foreign key (StaffId) references Staff (StaffId)
);







SET FOREIGN_KEY_CHECKS=1;