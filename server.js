import express from 'express';
import { SpaceAnalyzer } from './spaceAnalyzer.js';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const app = express();
const PORT = 3000;

app.use(express.static(__dirname));
app.use(express.json());

const analyzer = new SpaceAnalyzer(4);

app.get('/api/analyze', (req, res) => {
  const targetPath = req.query.path ? path.resolve(req.query.path) : process.env.HOME;
  
  try {
    const result = analyzer.getDirectorySize(targetPath);
    res.json({
      name: path.basename(targetPath) || targetPath,
      path: targetPath,
      size: result.size,
      children: result.children
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(PORT, () => {
  console.log(`🚀 Space Analyzer running at http://localhost:${PORT}`);
});
