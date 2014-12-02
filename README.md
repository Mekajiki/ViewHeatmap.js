ViewHeatmap.js
====
![Example of Heatmap](https://dl.dropbox.com/s/dq6z922nsfdkpi3/73775.png?dl=0)

Usage
----


### Prepare data
Each pageview of the target page has visitor's screen height and scroll positions as bellow;

```javascript
[
    {
      height: 640, // The screen height of the visitor's device
      positions: [ 0, 10, 50, 100, 150, 200, 180 ] //The scroll positions recorded periodically
    },
    {
      height: 1020,
      positions: [ 60, 30, 90, 140, 150, 200, 180 ]
    },
  ....
]
```

### Prepare screen capture
Then prepare screen capture of the target page on any url.

### Write code
```html
<canvas id="target"></canvas>
```

```javascript
new Heatmap(
  'target',
  'http://example.com/screen/capture/image',
  positionData
);
```

### Options
```javascript
new Heatmap(
  'target',
  screenCaptureUrl,
  positionData,
  {
    screenshotAlpha: 0.2, //Alpha of screenshot. [0, 1]
    heatmapAlpha: 0.2, //Alpha of heatmap. [0, 1]
    colorScheme: 'simple' //if 'simple' specified, render heatmap with simple transparent to red gradient.
  }
);
```


How to build
----
```sh
npm install --save
npm install -g grunt-cli ##if not yet
grunt
```

Example
----
After you run the grunt task once, open `example/index.html`
