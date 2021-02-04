INSERT INTO users (
  name, email, password)
VALUES
  ('Eva Stanley Examples', 'sebastianguerra_fakeaf@ymail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
  ('Mandy Bobandy', 'bobandynorandy@aol.lol', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
  ('Dominic Parks', 'dominicapika@lika.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u');

-- PROPERTIES
INSERT INTO properties (
  owner_id, title, description, thumbnail_photo_url, cover_photo_url, cost_per_night, parking_spaces, number_of_bathrooms, number_of_bedrooms)
VALUES
  ('1', 'Beach Hut', 'desc', 'https://www.ugaescapes.com/junglebeach/wp-content/uploads/sites/5/2017/07/Beach-Cabin-exterior-1.jpg', 'http://static.asiawebdirect.com/m/phuket/portals/phuket-com/homepage/yourguide/romantic/beaches/pagePropertiesImage/phuket-romantic-beaches.jpg', '150', '2', '1', '2'),

  ('1', 'Beachier Hut', 'desc', 'https://www.ugaescapes.com/junglebeach/wp-content/uploads/sites/5/2017/07/Beach-Cabin-exterior-1.jpg', 'http://static.asiawebdirect.com/m/phuket/portals/phuket-com/homepage/yourguide/romantic/beaches/pagePropertiesImage/phuket-romantic-beaches.jpg','150', '2', '2', '3' ),

  ('1', 'Beachiest Hut', 'desc', 'https://www.ugaescapes.com/junglebeach/wp-content/uploads/sites/5/2017/07/Beach-Cabin-exterior-1.jpg', 'http://static.asiawebdirect.com/m/phuket/portals/phuket-com/homepage/yourguide/romantic/beaches/pagePropertiesImage/phuket-romantic-beaches.jpg','150', '2', '3', '4' );

--RESERVATIONS
  INSERT INTO reservations (
    start_date, end_date, property_id, guest_id)
  VALUES
    ('2018-09-11', '2018-09-26', '4', '1'),
    ('2019-01-04', '2019-02-01', '5', '1'),
    ('2020-11-01', '2021-10-14', '6', '2'),
    ('2021-10-01', '2021-10-14', '5', '3');

  INSERT INTO property_reviews
    (guest_id, property_id, reservation_id, rating, message)
  VALUES
    ('2', '5', '9', '4', 'message'),
    ('1', '6', '11', '4', 'message'),
    ('3', '4', '12', '5', 'message');