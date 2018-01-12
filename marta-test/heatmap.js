	var itemSize = 10,
		cellSize = itemSize - 1,
		margin = {top: 120, right: 20, bottom: 20, left: 150};
		
	var width = 1000 - margin.right - margin.left,
	  height = 1000 - margin.top - margin.bottom;

	var formatDate = d3.time.format("%Y-%m-%d");
	
	d3.csv('guiltyplea.csv', function ( response ) {

		var data = response.map(function( item ) {
			var newItem = {};
			newItem.country = item.x;
			newItem.product = item.y;
			newItem.value = item.value;

			return newItem;
	})

	var x_elements = d3.set(data.map(function( item ) { return item.product; } )).values(),
		y_elements = d3.set(data.map(function( item ) { return item.country; } )).values();

	var xScale = d3.scale.ordinal()
		.domain(x_elements)
		.rangeBands([0, x_elements.length * (itemSize + 10)]);

	var xAxis = d3.svg.axis()
		.scale(xScale)
		.tickFormat(function (d) {
			return d;
		})
		.orient("top");

	var yScale = d3.scale.ordinal()
		.domain(y_elements)
		.rangeBands([0, y_elements.length * itemSize]);

	var yAxis = d3.svg.axis()
		.scale(yScale)
		.tickFormat(function (d) {
			return d;
		})
		.orient("left");

	var colorScale = d3.scale.threshold()
		.domain([0.75, 0.85, 0.95, 1])
		.range(["#ffcccc", "#ff9999", "#ff1a1a", "#cc0000", "#800000"]);

	var svg = d3.select('.heatmap')
		.append("svg")
		.attr("width", width + margin.left + margin.right)
		.attr("height", height + margin.top + margin.bottom)
		.append("g")
		.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

	var cells = svg.selectAll('rect')
		.data(data)
		.enter().append('g').append('rect')
		.attr('class', 'cell')
		.attr('width', 20)
		.attr('height', 9)
		.attr('y', function(d) { return yScale(d.country); })
		.attr('x', function(d) { return xScale(d.product); })
		.attr('fill', function(d) { return colorScale(d.value); });

	svg.append("g")
		.attr("class", "y axis")
		.call(yAxis)
		.selectAll('text')
		.attr('font-weight', 'normal');

	svg.append("g")
		.attr("class", "x axis")
		.call(xAxis)
		.selectAll('text')
		.attr('font-weight', 'normal')
		.style("text-anchor", "start")
		.attr("dx", ".8em")
		.attr("dy", ".5em")
		.attr("transform", function (d) {
			return "rotate(-65)";
		});
	});