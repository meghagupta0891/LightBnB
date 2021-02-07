const properties = require('./json/properties.json');
const users = require('./json/users.json');
const { Pool } = require('pg');

const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});

/// Users

/**
 * Get a single user from the database given their email.
 * @param {String} email The email of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithEmail = function(email) {
  return pool.query(`
  SELECT * FROM users where email = ${email}
  `)
  .then(res => res.rows);
}
exports.getUserWithEmail = getUserWithEmail;

/**
 * Get a single user from the database given their id.
 * @param {string} id The id of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithId = function(id) {
  return pool.query(`
  SELECT * FROM users where id = ${id}
  `)
  .then(res => res.rows);
}
exports.getUserWithId = getUserWithId;


/**
 * Add a new user to the database.
 * @param {{name: string, password: string, email: string}} user
 * @return {Promise<{}>} A promise to the user.
 */
const addUser =  function(user) {
  return pool.query(`
  INSERT into users (name,email,password) values (user.name,user.email,user.password)
  `)
  .then(res => res.rows);
}
exports.addUser = addUser;

/// Reservations

/**
 * Get all reservations for a single user.
 * @param {string} guest_id The id of the user.
 * @return {Promise<[{}]>} A promise to the reservations.
 */
const getAllReservations = function(guest_id, limit = 10) {
  return pool.query(`
  SELECT * FROM users where reservations = $1
  LIMIT $2
  `,[guest_id,limit])
  .then(res => res.rows);
}
exports.getAllReservations = getAllReservations;

/// Properties

/**
 * Get all properties.
 * @param {{}} options An object containing query options.
 * @param {*} limit The number of results to return.
 * @return {Promise<[{}]>}  A promise to the properties.
 */
const getAllProperties = function(options, limit = 10) {
    const queryParams = [];
    let queryString = `
    SELECT properties.*, avg(property_reviews.rating) as average_rating
    FROM properties
    JOIN property_reviews ON properties.id = property_id
    `;
    let keys = Object.keys(obj);
    let last = keys[keys.length-1];
    Object.keys(options).forEach(function(option, i) {
      if(i == 0)
        queryString += `WHERE `;
      queryParams.push(`%${options[option]}%`);
      if (option == "city") {     
        queryString += `city LIKE $${queryParams.length} `;
      }
      else if(option == "owner_id") {
        queryParams.push(`%${options.owner_id}%`);
        queryString += `owner_id = $${queryParams.length} `;
      }
      else if(option == "minimum_price_per_night") {
        queryString += `cost_per_night >= $${queryParams.length}`;
      }
      else if(option == "maximum_price_per_night") {
        queryString += `cost_per_night <= $${queryParams.length} `;
      }
      else if(option == "minimum_rating") {
        queryString += `average_rating >= $${queryParams.length} `;
      }
      if(i != last) {
        queryString += `AND`;
      }
    });
    queryParams.push(limit);
    queryString += `
    GROUP BY properties.id
    ORDER BY cost_per_night
    LIMIT $${queryParams.length};
    `;
    return pool.query(queryString, queryParams)
    .then(res => res.rows); 
}
exports.getAllProperties = getAllProperties;


/**
 * Add a property to the database
 * @param {{}} property An object containing all of the property details.
 * @return {Promise<{}>} A promise to the property.
 */
const addProperty = function(property) {
  const propertyId = Object.keys(properties).length + 1;
  property.id = propertyId;
  properties[propertyId] = property;
  return Promise.resolve(property);
}
exports.addProperty = addProperty;
