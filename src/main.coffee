class Heatmap
  constructor: (targetId, screenshotUrl, @positionData, opts = {}) ->
    @target = document.getElementById(targetId)

    @screenshotOpacity =
      if opts.screenshotAlpha is undefined
        0.6
      else
        opts.screenshotAlpha

    @heatmapOpacity =
      if opts.heatmapAlpha is undefined
        0.6
      else
        opts.heatmapAlpha

    @calculateColor =
      if opts.colorScheme == 'simple'
        @simpleRedGradient
      else
        @fiveColorGradient

    background = new Image()
    background.src = screenshotUrl

    background.onload = () =>
      @width = background.width
      @height = background.height
      @target.width = @width
      @target.height = @height
      @target.style.width = @width + 'px'
      @target.style.height = @height + 'px'

      context = @target.getContext('2d')
      context.globalAlpha = @screenshotOpacity
      context.drawImage background, 0, 0

      @plus = [0..parseInt(@height)].map -> 0
      @minus = [0..parseInt(@height)].map -> 0
      for data in @positionData
        for position in data.positions
          ++@plus[position]
          ++@minus[position + data.height]

      views = 0
      maxViews = 0
      viewsArray = []
      for i in [0..parseInt(@height)]
        views += @plus[i]
        views -= @minus[i]
        viewsArray[i] = views
        maxViews = Math.max(maxViews, views)

      context.globalAlpha = 1.0
      for i in [0..parseInt(@height)]
        value = viewsArray[i] / maxViews
        context.beginPath()
        context.moveTo 0, i
        context.lineTo @width, i
        context.lineWidth = 1
        context.strokeStyle = @calculateColor value
        context.stroke()

  fiveColorGradient: (value) ->
    h = (1.0 - value) * 240
    return "hsla(#{h}, 100%, 50%, #{@heatmapOpacity})"

  simpleRedGradient: (value) ->
    return "rgba(255, 0, 0, #{value * @heatmapOpacity})"

window.Heatmap = Heatmap
