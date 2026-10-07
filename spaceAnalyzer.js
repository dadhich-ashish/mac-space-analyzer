import fs from 'fs';
import path from 'path';

export class SpaceAnalyzer {
  constructor(maxDepth = Infinity) {
    this.maxDepth = maxDepth;
  }

  formatSize(bytes) {
    const units = ['B', 'KB', 'MB', 'GB', 'TB'];
    let size = bytes;
    let unitIndex = 0;
    
    while (size >= 1024 && unitIndex < units.length - 1) {
      size /= 1024;
      unitIndex++;
    }
    
    return `${size.toFixed(2)} ${units[unitIndex]}`;
  }

  getDirectorySize(dirPath, currentDepth = 0) {
    try {
      let totalSize = 0;
      const children = [];

      if (currentDepth >= this.maxDepth) {
        return { size: 0, children: [] };
      }

      const entries = fs.readdirSync(dirPath, { withFileTypes: true });

      for (const entry of entries) {
        try {
          const fullPath = path.join(dirPath, entry.name);
          
          if (entry.isDirectory()) {
            const result = this.getDirectorySize(fullPath, currentDepth + 1);
            children.push({
              name: entry.name,
              size: result.size,
              type: 'directory',
              children: result.children
            });
            totalSize += result.size;
          } else if (entry.isFile()) {
            const stats = fs.statSync(fullPath);
            totalSize += stats.size;
            children.push({
              name: entry.name,
              size: stats.size,
              type: 'file'
            });
          }
        } catch (err) {
          // Skip permission errors
          continue;
        }
      }

      // Sort by size (largest first)
      children.sort((a, b) => b.size - a.size);

      return { size: totalSize, children };
    } catch (err) {
      console.error(`Error reading directory ${dirPath}:`, err.message);
      return { size: 0, children: [] };
    }
  }

  displayTree(node, prefix = '', isLast = true) {
    const connector = isLast ? '└── ' : '├── ';
    const extension = isLast ? '    ' : '│   ';
    
    console.log(`${prefix}${connector}${node.name} (${this.formatSize(node.size)})`);

    if (node.children && node.children.length > 0) {
      const children = node.children.slice(0, 10); // Limit to top 10 for readability
      
      children.forEach((child, index) => {
        const isLastChild = index === children.length - 1;
        this.displayTree(child, prefix + extension, isLastChild);
      });

      if (node.children.length > 10) {
        console.log(`${prefix}${extension}... and ${node.children.length - 10} more items`);
      }
    }
  }

  analyze(dirPath) {
    try {
      const stats = fs.statSync(dirPath);
      
      if (!stats.isDirectory()) {
        console.error('Path is not a directory');
        return null;
      }

      console.log(`\n📊 Analyzing: ${dirPath}\n`);
      const result = this.getDirectorySize(dirPath);
      
      const rootNode = {
        name: path.basename(dirPath) || dirPath,
        size: result.size,
        children: result.children
      };

      this.displayTree(rootNode);
      console.log(`\n📈 Total Size: ${this.formatSize(result.size)}\n`);
      
      return result;
    } catch (err) {
      console.error(`Error analyzing directory: ${err.message}`);
      return null;
    }
  }
}
