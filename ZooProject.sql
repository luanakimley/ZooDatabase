/* Zoo Database Project - Luana Kimley SD1b */
DROP DATABASE IF EXISTS zoo;
CREATE DATABASE IF NOT EXISTS zoo;
USE zoo;
DROP TABLE IF EXISTS zookeeper_allocation, feeding_schedule_animal_food, feeding_schedule, animal_breed_food, food, animal, zoo_region, zoo_region_manager, zookeeper, animal_breed;

CREATE TABLE animal_breed ( 
breed_id VARCHAR(4) NOT NULL,
breed_name VARCHAR(30),
breed_origin VARCHAR(20),
PRIMARY KEY (breed_id)
);

CREATE TABLE zookeeper (
zookeeper_id VARCHAR(6) NOT NULL,
zookeeper_name VARCHAR(25),
zookeeper_address VARCHAR(40),
zookeeper_tel VARCHAR(15),
PRIMARY KEY (zookeeper_id)
);


CREATE TABLE zoo_region_manager ( 
zoo_region_manager_id VARCHAR(6) NOT NULL,
zookeeper_id VARCHAR(6) NOT NULL,
region_manager_start_date DATE,
PRIMARY KEY (zoo_region_manager_id),
FOREIGN KEY (zookeeper_id) REFERENCES zookeeper(zookeeper_id),
UNIQUE (zookeeper_id)
);

CREATE TABLE zoo_region ( 
region_id VARCHAR(6) NOT NULL,
region_name VARCHAR(20),
region_description VARCHAR(200),
zoo_region_manager_id VARCHAR(6) NOT NULL,
PRIMARY KEY (region_id),
FOREIGN KEY (zoo_region_manager_id) REFERENCES zoo_region_manager(zoo_region_manager_id),
UNIQUE (zoo_region_manager_id)
);

CREATE TABLE animal ( 
animal_id VARCHAR(7) NOT NULL,
animal_name VARCHAR(20),
animal_dob DATE,
animal_gender VARCHAR(10),
breed_id VARCHAR(4) NOT NULL,
region_id VARCHAR(6) NOT NULL,
PRIMARY KEY (animal_id),
FOREIGN KEY (breed_id) REFERENCES animal_breed(breed_id),
FOREIGN KEY (region_id) REFERENCES zoo_region(region_id)
);

CREATE TABLE food ( 
food_id VARCHAR(6) NOT NULL,
food_name VARCHAR(20),
food_type VARCHAR(10),
PRIMARY KEY (food_id)
);

CREATE TABLE animal_breed_food (
breed_id VARCHAR(4) NOT NULL,
food_id VARCHAR(6) NOT NULL,
PRIMARY KEY (breed_id, food_id),
FOREIGN KEY (breed_id) REFERENCES animal_breed(breed_id),
FOREIGN KEY (food_id) REFERENCES food(food_id)
);

CREATE TABLE feeding_schedule (
feeding_id VARCHAR(6) NOT NULL, 
feeding_day VARCHAR(10),
feeding_time TIME,
PRIMARY KEY (feeding_id)
);

CREATE TABLE feeding_schedule_animal_food (
schedule_animal_food_id VARCHAR(6) NOT NULL,
feeding_id VARCHAR(6), 
animal_id VARCHAR(7),
food_id VARCHAR(6),
PRIMARY KEY (schedule_animal_food_id),
FOREIGN KEY (feeding_id) REFERENCES feeding_schedule(feeding_id),
FOREIGN KEY (animal_id) REFERENCES animal(animal_id),
FOREIGN KEY (food_id) REFERENCES food(food_id)
);

CREATE TABLE zookeeper_allocation (
schedule_animal_food_id VARCHAR(6) NOT NULL, 
zookeeper_id VARCHAR(6) NOT NULL,
PRIMARY KEY (schedule_animal_food_id, zookeeper_id),
FOREIGN KEY (schedule_animal_food_id) REFERENCES feeding_schedule_animal_food(schedule_animal_food_id),
FOREIGN KEY (zookeeper_id) REFERENCES zookeeper(zookeeper_id)
);


INSERT INTO animal_breed VALUES 
('BDLP', 'Bottlenose Dolphin', 'Atlantic Ocean'),
('BTGR', 'Bengal Tiger', 'India'),
('CAML', 'Camels', 'Middle East'),
('ELPT', 'Sumatran Elephant', 'Indonesia'),
('FLMG', 'Greater Flamingo', 'Africa'),
('GPND', 'Giant Panda', 'China'),
('GRFF', 'Giraffe', 'Africa'),
('KOAL', 'Koalas', 'Australia'),
('LION', 'African Lion', 'Africa'),
('LPRD', 'African Leopards', 'Africa'),
('ORGU', 'Orangutan', 'Indonesia'),
('PHPO', 'Pygmy Hippo',	'Africa'),
('PLRB', 'Polar Bear', 'Arctic'),
('SMKY', 'Snow Monkey', 'Japan'),
('WTGR', 'White Tiger', 'India');

INSERT INTO zookeeper VALUES
('ZOO001', 'Jane Murphy', '56 High St', '0839201928'),
('ZOO002', 'John King', '89 Dublin Rd', '0828371419'),
('ZOO003', 'Sarah Byrnes', '10 Low St', '0816283943'),
('ZOO004', 'Kevin OÕConnor', '8 Black Rd', '0845271824'),
('ZOO005', 'Ethan McGowan', '12 OÕConnell St', '0832741959'),
('ZOO006', 'Mary McArdle', '102 High Rd', '0819247592'),
('ZOO007', 'Trisha Nolan', '37 Dublin St', '0864583628'),
('ZOO008', 'Donal McBride', '11 Abbey St', '0812748637'),
('ZOO009', 'Conor Fannon', '87 Circular Avenue', '0847865976'),
('ZOO010', 'Cleena OÕNeal', '21 Kildare St', '0858772623'),
('ZOO011', 'Owen Neil', '143 Henry Square', '0819273869'),
('ZOO012', 'Sarah Daley', '7 High St', '085878392'),
('ZOO013', 'Tighe McFee', '100 Low Rd', '0838471942'),
('ZOO014', 'Fergus Beirne', '123 Merrion Square', '0849852762'),
('ZOO015', 'Chelle Roy', '2 Westland St', '0817384698'),
('ZOO016', 'Mary Brown', '99 High St', '0817263849'),
('ZOO017', 'Bob Reily',	'6 Rocky Rd', '0841923874'),
('ZOO018', 'Poppy Hughes', '87 Dublin St',	'0872937502'),
('ZOO019', 'Teddy Poppins', '6 Low Rd',	'0812748219'),
('ZOO020', 'Pat Byrnes', '20 Kildare St', '0838481929'),
('ZOO021', 'Niall McArdle',	'18 Merrion Square', '0836479171'),
('ZOO022', 'Lily OÕConnell', '10 Circular Avenue', '0818270721'),
('ZOO023', 'Grace Parker', '7 Dublin Rd', '0856726470'),
('ZOO024', 'Michelle Stark', '56 Black Rd', '0818739827'),
('ZOO025', 'Felicia Reily', '62 Abbey St', '0817374646');

INSERT INTO zoo_region_manager VALUES
('ZRM001', 'ZOO007', '2015-11-01'),
('ZRM002', 'ZOO020', '2019-09-15'),
('ZRM003', 'ZOO005', '2015-06-01'),
('ZRM004', 'ZOO016', '2017-08-09'),
('ZRM005', 'ZOO012', '2017-12-01'),
('ZRM006', 'ZOO024', '2018-03-01'),
('ZRM007', 'ZOO002', '2020-05-17'),
('ZRM008', 'ZOO019', '2020-07-05'),
('ZRM009', 'ZOO015', '2012-08-13'),
('ZRM010', 'ZOO010', '2014-12-10'),
('ZRM011', 'ZOO022', '2015-10-03');


INSERT INTO zoo_region VALUES
('R-BFRS', 'Bamboo forest',	'The bamboo forest is wet, it has abundant rainfall and 4 seasons. There are many bamboos in it, hence the name.', 'ZRM010'),
('R-DSRT', 'Desert', 'A desert is a region of land full of sand that is very dry because it receives low amounts of precipitation.', 'ZRM011'),
('R-EFRS', 'Eucalypt forest', 'Eucalypt forests evolved from rainforest ancestors, adapting to an environment in which drought, nutrient-poor soils and fire were increasingly common.', 'ZRM004'),
('R-MDFL', 'Mudflats', 'Mudflats or mud flats, also known as tidal flats, are coastal wetlands that form in intertidal areas where sediments have been deposited by tides or rivers. It is a mixture of sand and mud.', 'ZRM003'),
('R-SFRS', 'Subtropical forest', 'Subtropical forests are similar to tropical forests, but the difference is they have hot summers with abundant rainfall and also cold winters with moderate rainfall.', 'ZRM006'),
('R-SVNA', 'Savanna', 'The savanna is a mixed woodland-grassland ecosystem characterised by the trees being sufficiently widely spaced so that the canopy does not close.', 'ZRM009'),
('R-SWMP', 'Swamps', 'A swamp is an area of land permanently saturated, or filled, with water. Many swamps are even covered by water. They are also dominated by trees.', 'ZRM008'),
('R-SWTK', 'Saltwater tank', 'An aquarium that keeps marine plants and animals in a contained environment, it is filled with saltwater.', 'ZRM001'),
('R-TFRS', 'Tropical rainforest', 'The tropical rainforest is hot and moist, it has abundant rainfall. It is packed with trees.', 'ZRM007'),
('R-TNDR', 'Tundra', 'The tundra region is a treeless region, it is covered with snow and is cold, windy, and dry.', 'ZRM002'),
('R-VTRN', 'Veterinary', 'A place dedicated for the animalsÕ health. Animals are diagnosed, treated, and researched here.', 'ZRM005');

INSERT INTO animal VALUES
('BDLP-01', 'Dolphy', '2012-08-17', 'M', 'BDLP', 'R-SWTK'),
('BDLP-02',	'Coral', '2013-09-09', 'F', 'BDLP', 'R-SWTK'),
('BTGR-01', 'Tiggy', '2020-12-03', 'M', 'BTGR', 'R-TFRS'),
('BTGR-02', 'Stripes', '2016-07-02', 'F', 'BTGR', 'R-TFRS'),
('CAML-01', 'Cammy', '2006-05-19', 'F', 'CAML', 'R-DSRT'),
('CAML-02', 'Melly', '2010-10-10', 'M',	'CAML', 'R-DSRT'),
('ELPT-01', 'Elphy', '2005-01-07', 'F', 'ELPT', 'R-TFRS'),
('ELPT-02', 'Dumbo', '2000-02-08', 'M', 'ELPT', 'R-TFRS'),
('FLMG-01',	'Pinky', '2002-09-08', 'F', 'FLMG', 'R-MDFL'),
('FLMG-02', 'Troop', '2010-06-30', 'M', 'FLMG', 'R-MDFL'),
('FLMG-03', 'Flame', '2007-02-14', 'F', 'FLMG', 'R-MDFL'),
('GPND-01', 'Bao', '2014-01-02', 'M', 'GPND', 'R-BFRS'),
('GRFF-01', 'Gigi', '2010-04-24', 'F', 'GRFF', 'R-SVNA'),
('GRFF-02', 'Rafi', '2008-11-18', 'M', 'GRFF', 'R-SVNA'),
('KOAL-01', 'Coin', '2017-02-28', 'F', 'KOAL', 'R-EFRS'),
('LION-01', 'Nayla', '2019-08-27', 'F', 'LION', 'R-SVNA'),
('LION-02', 'Dexter', '2018-03-09', 'M', 'LION', 'R-SVNA'),
('LPRD-01',	'Spots', '2017-05-07', 'M',	'LPRD',	'R-DSRT'),
('ORGU-01',	'Ori', '2010-05-18', 'M', 'ORGU', 'R-TFRS'),
('ORGU-02',	'Molly', '2012-03-10', 'F', 'ORGU', 'R-TFRS'),
('PHPO-01',	'Berry', '2013-05-06', 'F', 'PHPO', 'R-SWMP'),
('PLRB-01', 'Ice', '2019-02-07', 'M', 'PLRB', 'R-TNDR'),
('SMKY-01',	'Larry', '2010-04-10', 'M', 'SMKY',	'R-SFRS'),
('SMKY-02',	'Maya',	'2014-12-08', 'F',	'SMKY',	'R-SFRS'),
('WTGR-01', 'Snow', '2018-10-22', 'M', 'WTGR', 'R-TFRS');

INSERT INTO food VALUES
('F-BFLO', 'Buffalo', 'Meat'),
('F-DRIN', 'Durian', 'Fruit'),
('F-SEAL', 'Seal', 'Meat'),
('F-FISH', 'Fish', 'Meat'),
('F-BMBO', 'Bamboo', 'Plant'),
('F-SHRM', 'Shrimp', 'Meat'),
('F-GRSS', 'Grass', 'Plant'),
('F-EUCL', 'Eucalypt', 'Plant'),
('F-LVES', 'Leaves', 'Plant'),
('F-BBON', 'Baboons', 'Meat'),
('F-PIGS', 'Pigs', 'Meat'),
('F-BNNA', 'Bananas', 'Fruit'),
('F-INSC', 'Insects', 'Meat'),
('F-MNGO', 'Mango', 'Fruit');

INSERT INTO animal_breed_food VALUES
('BDLP', 'F-FISH'),
('BDLP', 'F-SHRM'),
('BTGR', 'F-BFLO'),
('BTGR', 'F-PIGS'),
('CAML', 'F-GRSS'),
('ELPT', 'F-MNGO'),
('ELPT', 'F-GRSS'),
('FLMG', 'F-SHRM'),
('GPND', 'F-BMBO'),
('GRFF', 'F-LVES'),
('KOAL', 'F-EUCL'),
('LION', 'F-BFLO'),
('LION', 'F-BBON'),
('LPRD', 'F-BBON'),
('LPRD', 'F-PIGS'),
('ORGU', 'F-DRIN'),
('ORGU', 'F-BNNA'),
('ORGU', 'F-MNGO'),
('PHPO', 'F-GRSS'),
('PHPO', 'F-BNNA'),
('PLRB', 'F-SEAL'),
('PLRB', 'F-FISH'),
('SMKY', 'F-BNNA'),
('SMKY', 'F-INSC'),
('WTGR', 'F-PIGS'),
('WTGR', 'F-BFLO');

INSERT INTO feeding_schedule VALUES
('MON-01', 'Monday', '09:15'),
('MON-02', 'Monday', '12:00'),
('MON-03', 'Monday', '17:00'),
('TUE-01', 'Tuesday', '10:00'),
('TUE-02', 'Tuesday', '15:30'),
('TUE-03', 'Tuesday', '18:00'),
('WED-01', 'Wednesday', '08:15'),
('WED-02', 'Wednesday', '12:00'),
('WED-03', 'Wednesday', '18:30'),
('THU-01', 'Thursday', '09:00'),
('THU-02', 'Thursday', '13:00'),
('THU-03', 'Thursday', '17:30'),
('FRI-01', 'Friday', '11:15'),
('FRI-02', 'Friday', '17:30'),
('SAT-01', 'Saturday', '12:30'),
('SAT-02', 'Saturday', '18:00'),
('SUN-01', 'Sunday', '11:00'),
('SUN-02', 'Sunday', '17:00');

INSERT INTO feeding_schedule_animal_food VALUES
('SAF-01', 'MON-01', 'LION-01', 'F-BFLO'),
('SAF-02', 'MON-01', 'LION-02', 'F-BFLO'),
('SAF-03', 'MON-02', 'BTGR-01', 'F-PIGS'),
('SAF-04', 'MON-02', 'BTGR-02', 'F-PIGS'),
('SAF-05', 'MON-02', 'WTGR-01', 'F-PIGS'),
('SAF-06', 'MON-03', 'BDLP-01', 'F-FISH'),
('SAF-07', 'MON-03', 'BDLP-02', 'F-FISH'),
('SAF-08', 'TUE-01', 'CAML-01', 'F-GRSS'),
('SAF-09', 'TUE-01', 'CAML-02', 'F-GRSS'),
('SAF-10', 'TUE-01', 'SMKY-01', 'F-BNNA'),
('SAF-11', 'TUE-01', 'SMKY-02', 'F-BNNA'),
('SAF-12', 'TUE-02', 'FLMG-01', 'F-SHRM'),
('SAF-13', 'TUE-02', 'FLMG-02', 'F-SHRM'),
('SAF-14', 'TUE-02', 'FLMG-03', 'F-SHRM'),
('SAF-15', 'TUE-02', 'GPND-01', 'F-BMBO'),
('SAF-16', 'TUE-03', 'ORGU-01', 'F-DRIN'),
('SAF-17', 'TUE-03', 'ORGU-02', 'F-DRIN'),
('SAF-18', 'TUE-03', 'LPRD-01', 'F-BBON'),
('SAF-19', 'WED-01', 'ELPT-01', 'F-MNGO'),
('SAF-20', 'WED-01', 'ELPT-02', 'F-MNGO'),
('SAF-21', 'WED-01', 'PHPO-01', 'F-GRSS'),
('SAF-22', 'WED-02', 'BDLP-01', 'F-SHRM'),
('SAF-23', 'WED-02', 'BDLP-02', 'F-SHRM'),
('SAF-24', 'WED-03', 'PLRB-01', 'F-SEAL'),
('SAF-25', 'THU-01', 'FLMG-01', 'F-SHRM'),
('SAF-26', 'THU-01', 'FLMG-02', 'F-SHRM'),
('SAF-27', 'THU-01', 'FLMG-03', 'F-SHRM'),
('SAF-28', 'THU-02', 'GPND-01', 'F-BMBO'),
('SAF-29', 'THU-02', 'GRFF-01', 'F-LVES'),
('SAF-30', 'THU-02', 'GRFF-02', 'F-LVES'),
('SAF-31', 'THU-03', 'KOAL-01', 'F-EUCL'),
('SAF-32', 'THU-03', 'ORGU-01', 'F-BNNA'),
('SAF-33', 'THU-03', 'ORGU-02', 'F-BNNA'),
('SAF-34', 'THU-03', 'LION-01', 'F-BBON'),
('SAF-35', 'THU-03', 'LION-02', 'F-BBON'),
('SAF-36', 'FRI-01', 'PLRB-01', 'F-FISH'),
('SAF-37', 'FRI-01', 'BTGR-01', 'F-BFLO'),
('SAF-38', 'FRI-01', 'BTGR-02', 'F-BFLO'),
('SAF-39', 'FRI-01', 'WTGR-01', 'F-BFLO'),
('SAF-40', 'FRI-02', 'SMKY-01', 'F-INSC'),
('SAF-41', 'FRI-02', 'SMKY-02', 'F-INSC'),
('SAF-42', 'SAT-01', 'LPRD-01', 'F-PIGS'),
('SAF-43', 'SAT-01', 'ORGU-01', 'F-MNGO'),
('SAF-44', 'SAT-01', 'ORGU-02', 'F-MNGO'),
('SAF-45', 'SAT-02', 'PHPO-01', 'F-BNNA'),
('SAF-46', 'SUN-01', 'ELPT-01', 'F-GRSS'),
('SAF-47', 'SUN-01', 'ELPT-02', 'F-GRSS'),
('SAF-48', 'SUN-02', 'KOAL-01', 'F-EUCL');

INSERT INTO zookeeper_allocation VALUES
('SAF-01', 'ZOO015'),
('SAF-02', 'ZOO015'),
('SAF-02', 'ZOO016'),
('SAF-03', 'ZOO003'),
('SAF-04', 'ZOO004'),
('SAF-05', 'ZOO006'),
('SAF-06', 'ZOO007'),
('SAF-07', 'ZOO008'),
('SAF-08', 'ZOO022'),
('SAF-09', 'ZOO009'),
('SAF-10', 'ZOO011'),
('SAF-11', 'ZOO024'),
('SAF-12', 'ZOO005'),
('SAF-13', 'ZOO013'),
('SAF-14', 'ZOO014'),
('SAF-15', 'ZOO010'),
('SAF-16', 'ZOO002'),
('SAF-17', 'ZOO017'),
('SAF-18', 'ZOO018'),
('SAF-19', 'ZOO021'),
('SAF-20', 'ZOO023'),
('SAF-21', 'ZOO019'),
('SAF-22', 'ZOO025'),
('SAF-23', 'ZOO007'),
('SAF-24', 'ZOO020'),
('SAF-25', 'ZOO001'),
('SAF-26', 'ZOO005'),
('SAF-27', 'ZOO003'),
('SAF-28', 'ZOO004'),
('SAF-29', 'ZOO001'),
('SAF-30', 'ZOO006'),
('SAF-31', 'ZOO016'),
('SAF-32', 'ZOO011'),
('SAF-33', 'ZOO013'),
('SAF-34', 'ZOO014'),
('SAF-35', 'ZOO017'),
('SAF-36', 'ZOO018'),
('SAF-37', 'ZOO021'),
('SAF-38', 'ZOO023'),
('SAF-39', 'ZOO002'),
('SAF-40', 'ZOO024'),
('SAF-41', 'ZOO025'),
('SAF-42', 'ZOO022'),
('SAF-43', 'ZOO001'),
('SAF-44', 'ZOO003'),
('SAF-45', 'ZOO019'),
('SAF-46', 'ZOO004'),
('SAF-47', 'ZOO006'),
('SAF-48', 'ZOO013');

/* Queries */
/* 1. Show all animal name, food name, and zookeeper name for all feeding schedule on Monday */
SELECT fs.feeding_day, fs.feeding_time, a.animal_name, f.food_name, z.zookeeper_name 
FROM animal a, food f, zookeeper z, feeding_schedule fs, feeding_schedule_animal_food saf, zookeeper_allocation za
WHERE saf.feeding_id = fs.feeding_id AND a.animal_id = saf.animal_id AND saf.food_id = f.food_id 
AND za.schedule_animal_food_id = saf.schedule_animal_food_id AND za.zookeeper_id = z.zookeeper_id 
AND fs.feeding_day = 'Monday';

/* 2. Show animal breeds with more than one animal in the zoo */
SELECT b.breed_name, COUNT(a.breed_id) AS animal_count 
FROM animal_breed b JOIN animal a USING(breed_id) 
GROUP BY a.breed_id 
HAVING COUNT(a.breed_id) > 1;

/* 3. Ori is sick and need to move to the veterinary for a while */
UPDATE animal SET region_id='R-VTRN' WHERE animal_name='Ori';

/* 4. Since Ori is sick, he needs an additional feeding schedule on Monday at 09:15, with bananas as his food. A zookeeper will also be allocated to that feeding schedule for Ori. */
INSERT INTO feeding_schedule_animal_food VALUES ('SAF-49', 
(SELECT feeding_id FROM feeding_schedule WHERE feeding_day='Monday' AND feeding_time='09:15'), 
(SELECT animal_id FROM animal WHERE animal_name='Ori'), 
(SELECT food_id FROM food WHERE food_name='Bananas'));
INSERT INTO zookeeper_allocation VALUES ('SAF-49', 'ZOO012');

/* 5. Show animal with its breed which are older than 10 years old in order */
SELECT a.animal_name, b.breed_name, TIMESTAMPDIFF(YEAR, animal_dob, CURDATE()) AS animal_age 
FROM animal a JOIN animal_breed b USING(breed_id)
WHERE TIMESTAMPDIFF(YEAR, animal_dob, CURDATE()) > 10
ORDER BY TIMESTAMPDIFF(YEAR, animal_dob, CURDATE());


/* 6. Show all the dolphin's feeding day, time, and food */
SELECT a.animal_name, b.breed_name, fs.feeding_day, fs.feeding_time
FROM animal a, animal_breed b, feeding_schedule fs, feeding_schedule_animal_food saf
WHERE saf.animal_id = a.animal_id AND a.breed_id = b.breed_id AND saf.feeding_id = fs.feeding_id
AND b.breed_name LIKE '%Dolphin%';

/* 7. Zookeeper start date is now added to the zookeeper data */
ALTER TABLE zookeeper ADD zookeeper_start_date DATE;

/* 8. Mary McArdle's start date is 1st March 2012 */
UPDATE zookeeper SET zookeeper_start_date='2012-03-01' WHERE zookeeper_name='Mary McArdle';

/* 9. Show all zoo region manager name, region name, and region manager start date in order of date from the most recent*/
SELECT z.zookeeper_name, r.region_name, zrm.region_manager_start_date
FROM zookeeper z, zoo_region r, zoo_region_manager zrm
WHERE z.zookeeper_id = zrm.zookeeper_id AND r.zoo_region_manager_id = zrm.zoo_region_manager_id
ORDER BY zrm.region_manager_start_date DESC;

/* 10. Zookeeper start date is removed from zookeeper data */
ALTER TABLE zookeeper DROP COLUMN zookeeper_start_date;

/* 11. Show all animal name, breed, food name, and zookeeper name for all feeding schedule at 12 */
SELECT a.animal_name, b.breed_name, f.food_name, z.zookeeper_name, fs.feeding_day, fs.feeding_time
FROM animal a, animal_breed b, food f, zookeeper z, feeding_schedule fs, feeding_schedule_animal_food saf, zookeeper_allocation za
WHERE saf.feeding_id = fs.feeding_id AND a.animal_id = saf.animal_id AND saf.food_id = f.food_id 
AND za.schedule_animal_food_id = saf.schedule_animal_food_id AND za.zookeeper_id = z.zookeeper_id 
AND a.breed_id = b.breed_id AND fs.feeding_time LIKE '12%';

/* 12. Donal McBride the zookeeper moved address to 12 Rocky Rd */
UPDATE zookeeper SET zookeeper_address='12 Rocky Rd' WHERE zookeeper_name='Donal McBride';

/* 13. Ori has recovered so he is moved from the veterinary */
UPDATE animal SET region_id='R-TFRS' WHERE animal_name='Ori';

/* 14. Ori's feeding schedule on Monday at 09:15 is no longer required */
DELETE FROM zookeeper_allocation
WHERE schedule_animal_food_id IN (SELECT schedule_animal_food_id FROM feeding_schedule_animal_food WHERE animal_id=(SELECT animal_id FROM animal WHERE animal_name='Ori')
AND feeding_id=(SELECT feeding_id FROM feeding_schedule WHERE feeding_day='Monday' AND feeding_time='09:15') AND food_id=(SELECT food_id FROM food WHERE food_name='Bananas'));

DELETE FROM feeding_schedule_animal_food 
WHERE animal_id=(SELECT animal_id FROM animal WHERE animal_name='Ori')
AND feeding_id=(SELECT feeding_id FROM feeding_schedule WHERE feeding_day='Monday' AND feeding_time='09:15') AND food_id=(SELECT food_id FROM food WHERE food_name='Bananas');

/* 15. The zoo is opening a new baby zoo section so they need a list of all animals 3 years old or younger  */
SELECT a.animal_name, b.breed_name, TIMESTAMPDIFF(YEAR, animal_dob, CURDATE()) AS animal_age 
FROM animal a JOIN animal_breed b USING(breed_id)
WHERE TIMESTAMPDIFF(YEAR, animal_dob, CURDATE()) <= 3;

/* 16. Show the average age of each animal breed (rounded to 2 decimal places) in the zoo, in order */
SELECT b.breed_name, FORMAT(AVG(TIMESTAMPDIFF(YEAR, animal_dob, CURDATE())), 2) AS average_animal_breed_age 
FROM animal a JOIN animal_breed b USING(breed_id)
GROUP BY b.breed_id
ORDER BY AVG(TIMESTAMPDIFF(YEAR, animal_dob, CURDATE()));

/* 17 Change zookeeper_tel column to zookeeper_phonenumber to make it clearer */
ALTER TABLE zookeeper CHANGE zookeeper_tel zookeeper_phonenumber VARCHAR(15);

/* 18. Show the oldest animal for each breed in the zoo */
SELECT a.animal_name, b.breed_name, MAX(TIMESTAMPDIFF(YEAR, animal_dob, CURDATE())) AS animal_age 
FROM animal a JOIN animal_breed b USING(breed_id)
GROUP BY breed_id;

/* 19. Show all flamingos' food name and zookeeper name for all feeding schedules */
SELECT fs.feeding_day, a.animal_name, b.breed_name, f.food_name, z.zookeeper_name 
FROM animal a, food f, zookeeper z, feeding_schedule fs, feeding_schedule_animal_food saf, zookeeper_allocation za, animal_breed b
WHERE saf.feeding_id = fs.feeding_id AND a.animal_id = saf.animal_id AND saf.food_id = f.food_id 
AND za.schedule_animal_food_id = saf.schedule_animal_food_id AND za.zookeeper_id = z.zookeeper_id AND b.breed_id = a.breed_id
AND b.breed_name LIKE "%Flamingo%";

/* 20. Show count of the feeding schedule of each zookeeper */
SELECT z.zookeeper_name, COUNT(za.zookeeper_id) AS feeding_schedule_count
FROM zookeeper z, zookeeper_allocation za
WHERE z.zookeeper_id = za.zookeeper_id
GROUP BY z.zookeeper_id;