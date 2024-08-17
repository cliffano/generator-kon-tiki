"use strict"
import fs from 'fs';

const sitemap = JSON.parse(fs.readFileSync('./data/sitemap.json'));

const params = {
    sitemap: sitemap,
    redirect_url:'{{redirect_url}}'
};

export {
    params as params
};