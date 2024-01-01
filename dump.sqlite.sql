-- TABLE
CREATE TABLE 'AppleStore' ('' INTEGER,'id' INTEGER,'track_name' TEXT,'size_bytes' INTEGER,'currency' TEXT,'price' REAL,'rating_count_tot' INTEGER,'rating_count_ver' INTEGER,'user_rating' REAL,'user_rating_ver' REAL,'ver' TEXT,'cont_rating' TEXT,'prime_genre' TEXT,'sup_devices_num' INTEGER,'ipadSc_urls_num' INTEGER,'lang_num' INTEGER,'vpp_lic' INTEGER);
CREATE TABLE 'appleStore_description1' ('id' INTEGER,'track_name' TEXT,'size_bytes' INTEGER,'app_desc' TEXT);
CREATE TABLE 'appleStore_description2' ('id' INTEGER,'track_name' TEXT,'size_bytes' INTEGER,'app_desc' TEXT);
CREATE TABLE 'appleStore_description3' ('id' INTEGER,'track_name' TEXT,'size_bytes' INTEGER,'app_desc' TEXT);
CREATE TABLE 'appleStore_description4' ('id' INTEGER,'track_name' TEXT,'size_bytes' INTEGER,'app_desc' TEXT);
CREATE TABLE appleStore_description_combined(
  id INT,
  track_name TEXT,
  size_bytes INT,
  app_desc TEXT
);
CREATE TABLE demo (ID integer primary key, Name varchar(20), Hint text );
 
-- INDEX
 
-- TRIGGER
 
-- VIEW
 
