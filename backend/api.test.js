const request = require("supertest");
const app = require("./index"); // Adjust the path to your app file

describe("GET /api/patients", () => {
  it("should return a JSON response", async () => {
    const response = await request(app).get("/api/patients");

    // Check that the response is in JSON format
    expect(response.headers["content-type"]).toEqual(
      expect.stringContaining("json")
    );

    // Optionally, check for specific properties in the response body
    expect(response.body).toBeDefined(); // Check that body is defined
    // You can add more assertions based on your expected data structure
  });
});

describe("GET /api/records", () => {
  it("should return a JSON response", async () => {
    const response = await request(app).get("/api/record");

    // Check that the response is in JSON format
    expect(response.headers["content-type"]).toEqual(
      expect.stringContaining("json")
    );

    // Optionally, check for specific properties in the response body
    expect(response.body).toBeDefined(); // Check that body is defined
    // You can add more assertions based on your expected data structure
  });
});

describe("POST /api/patients", () => {
  it("should return status code 201", async () => {
    const newPatient = {
      name: "Rickie Au",
      age: 24,
      gender: "Male",
      address: "937 Progress Ave",
      zipCode: "M1G 3T8",
      profilePicture:
        "https://static.wikia.nocookie.net/roblox/images/4/4b/Epic_Face_Icon.png",
    };

    const response = await request(app)
      .post("/api/patients")
      .send(newPatient) // Send the patient data
      .set("Accept", "application/json"); // Set the content type

    // Check that the status code is 201
    expect(response.status).toBe(201);
  });
});

describe("PUT /api/patients/:id", () => {
  it("should update patient details and return status code 200", async () => {
    const patientId = "67da66cfe3a30787910e6ce7"; // Example patient ID
    const updatedPatient = {
      name: "Rickie Au",
      age: 24,
      gender: "Male",
      address: "937 Progress Ave",
      zipCode: "M1G 3T8",
      profilePicture:
        "https://static.wikia.nocookie.net/roblox/images/4/4b/Epic_Face_Icon.png",
    };

    const response = await request(app)
      .put(`/api/patients/${patientId}`)
      .send(updatedPatient) // Send the updated patient data
      .set("Accept", "application/json"); // Set the content type

    // Check that the status code is 200
    expect(response.status).toBe(200);

    // Optionally, check for a success message or the updated patient data
    expect(response.headers["content-type"]).toEqual(
      expect.stringContaining("json")
    );
    expect(response.body).toBeDefined(); // Check that body is defined
  });
});



describe('POST /api/record', () => {
  it('should return status code 201', async () => {
    const newRecord = {
      //measurementDate: '2023-04-15',
      patient: '67dad778bd3287f88ee454fb', // Example patient ID
      datatype: 'blood oxygen level',
      readingValue: 95,
    };

    const response = await request(app)
      .post('/api/record')
      .send(newRecord) // Send the record data
      .set('Accept', 'application/json'); // Set the content type

    // Check that the status code is 201
    expect(response.status).toBe(201);
    
    // Optionally, check for a success message or the created record data
    expect(response.headers["content-type"]).toEqual(
        expect.stringContaining("json")
      );
      expect(response.body).toBeDefined(); // Check that body is defined
  });
});


describe('POST /api/record', () => {
    it('should return status code 400', async () => {
      const newRecord = {
        //measurementDate: '2023-04-15',
        patient: '67dad778bd3287f88ee454fb', // Example patient ID
        datatype: 'blood oxygen level',
        readingValue: -20,
      };
  
      const response = await request(app)
        .post('/api/record')
        .send(newRecord) // Send the record data
        .set('Accept', 'application/json'); // Set the content type
  
      // Check that the status code is 201
      expect(response.status).toBe(400);
      

      expect(response.text).toBe("value of blood oxygen level too low");
    });
  });
  