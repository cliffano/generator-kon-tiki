<img align="right" src="https://raw.github.com/cliffano/generator-kon-tiki/main/avatar.jpg" alt="Avatar"/>

[![Build Status](https://github.com/cliffano/generator-kon-tiki/workflows/CI/badge.svg)](https://github.com/cliffano/generator-kon-tiki/actions?query=workflow%3ACI)
[![Security Status](https://snyk.io/test/github/cliffano/generator-kon-tiki/badge.svg)](https://snyk.io/test/github/cliffano/generator-kon-tiki)

Generator-Kon-Tiki
------------------

Generator-Kon-Tiki is a Kon-Tiki static web site projects generator using [Plop](https://plopjs.com/).

It provides the following components:

| Component | Description |
|-----------|-------------|
| static-redirect | Generate a redirect Kon-Tiki static web site project. |
| static-content | Generate a Kon-Tiki static web site project. |

All components are built using [Knut Haugland](https://github.com/cliffano/knut-haugland).

Usage
-----

Generate redirect Kon-Tiki static web site project:

    make generate-static-redirect

Generate Kon-Tiki static web site project:

    make generate-static-content

Both components will prompt you the following inputs:

| Prompt | Description |
|--------|-------------|
| Project ID | Used for Python package name and CLI command. |
| Project Name | Used in documentation or comments. |
| Project Description | Used in documentation or comments. |
| Author Name | The name of the project author. |
| Author Email | The email of the project author. |
| Author URL | The author's website URL. |
| GitHub ID | The GitHub ID of the project repo. |

And static-redirect will prompt you the following additional input:

| Prompt | Description |
|--------|-------------|
| Redirect URL | The URL to redirect to. |

Move to the generated project directory:

    cd stage/<component>/

Colophon
--------

Related Projects:

* [Knut Haugland](https://github.com/cliffano/knut-haugland) - Makefile for creating Kon-Tiki static web sites
