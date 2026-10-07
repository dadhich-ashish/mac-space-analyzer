#!/usr/bin/env node

import { SpaceAnalyzer } from './spaceAnalyzer.js';
import path from 'path';

const args = process.argv.slice(2);
const targetPath = args[0] ? path.resolve(args[0]) : process.env.HOME;
const maxDepth = parseInt(args[1]) || 3;

const analyzer = new SpaceAnalyzer(maxDepth);
analyzer.analyze(targetPath);
