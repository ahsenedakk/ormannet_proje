const express = require('express');
const axios = require('axios');
const cors = require('cors');  // CORS paketini ekliyoruz

const app = express();
const port = 3000;

app.use(cors());  // CORS desteğini kullanıyoruz

app.get('/api/parkAreas', async (req, res) => {
    try {
        console.log('Fetching park areas data from Overpass API...');
        const overpassUrl = `http://overpass-api.de/api/interpreter?data=
            [out:json];
            area[name="Türkiye"]->.a;
            (
              node["leisure"="park"](area.a);
              way["leisure"="park"](area.a);
              relation["leisure"="park"](area.a);
            );
            out body;
        `;

        const response = await axios.get(overpassUrl);
        console.log('Data fetched successfully.');
        res.json(response.data);
    } catch (error) {
        console.error('Error fetching data from Overpass API:', error.message);
        res.status(500).json({ error: error.message });
    }
});

app.listen(port, () => {
    console.log(`Server listening at http://localhost:${port}`);
});
