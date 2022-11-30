
SET FOREIGN_KEY_CHECKS=0;

drop table if exists season;
drop table if exists player;
drop table if exists Team;
drop table if exists Roster;
drop table if exists Staff;

create table if not exists Season(
StartingYear integer not null, 
MVP mediumint, 
MIP mediumint, 
CoachYear varchar(50), 
DPY mediumint,
SixMan mediumint,
primary key (StartingYear),
foreign key(MVP) references Player(PlayerID),
foreign key(MIP) references Player(PlayerID),
foreign key(DPY) references Player(PlayerID),
foreign key(SixMan) references Player(PlayerID));

create table if not exists Player(
PlayerId mediumint not null auto_increment,
FirstName char(20),
LastName char(20), 
age date,
Position Enum('PG', 'SG', 'SF', 'PF', 'C'), 
Salary decimal(12,2), 
ContractLength integer, 
DraftSeason integer,
DraftPosition integer,
primary key (PlayerId),
foreign key (DraftSeason) references Season(StartingYear));

create table if not exists Team(
TeamName char(20) not null,
City char(20),
TeamOwner char(30), # consider breaking up into first and last name?
LogoImgPath char(100),
primary key (TeamName));

create table if not exists Roster(
RosterId integer not null auto_increment,
Season integer,
WinLossRecord decimal(4,2),
primary key (RosterId),
foreign key (Season) references Season(StartingYear));

create table if not exists Staff(
StaffId integer not null auto_increment,
StaffType enum('Front Office', 'Coaching', 'Marketing', 'Technology'), # Add more maybe?
HireDate Date,
WinTotal integer,
LossTotal integer,
ContractLength integer,
primary key (StaffId));

create table if not exists Staff_Member(
StaffMemberId mediumint not null auto_increment,
Firstname char(20),
LastName char(20),
JobTitle char(20), # if there aren't very many, consider enum?
Salary decimal(12, 



SET FOREIGN_KEY_CHECKS=1;