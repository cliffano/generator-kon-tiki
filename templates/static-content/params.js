"use strict"
import fs from 'fs';

const sitemap = JSON.parse(fs.readFileSync('./data/sitemap.json'));
const links = JSON.parse(fs.readFileSync('./data/links.json'));

const params = {
    sitemap: sitemap,
    links: links
};

export {
    params as params
};