#!/bin/zsh

quarto render syllabus.qmd 
quarto render syllabus.qmd --to gfm -o README.md