	var cellwidth = 20,
		cellheight = 10
		fillwidth = cellwidth - 1,
		fillheight = cellheight - 1,
		margin = {top: 120, right: 20, bottom: 20, left: 150};
		
	var width = 1000 - margin.right - margin.left,
	  height = 1100 - margin.top - margin.bottom;

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
		.rangeBands([0, x_elements.length * (cellwidth)]);

	var xAxis = d3.svg.axis()
		.scale(xScale)
		.tickFormat(function (d) {
			return d;
		})
		.orient("top");

	var yScale = d3.scale.ordinal()
		.domain(y_elements)
		.rangeBands([0, y_elements.length * cellheight]);

	var yAxis = d3.svg.axis()
		.scale(yScale)
		.tickFormat(function (d) {
			return d;
		})
		.orient("left");

	var colorScale = d3.scale.threshold()
		.domain([0.75, 0.80, 0.85, 0.90, 0.95, 1])
		.range(["#ffcccc", "#ff9999", "#ff6666", "#ff1a1a", "#cc0000", "#b30000", "#800000"]);

	var svg = d3.select('div#heatmap')
		.append("svg")
		.attr("width", width + margin.left + margin.right)
		.attr("height", height + margin.top + margin.bottom)
		.append("g")
		.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

	var cells = svg.selectAll('rect')
		.data(data)
		.enter().append('g').append('rect')
		.attr('class', 'cell')
		.attr('width', fillwidth)
		.attr('height', fillheight)
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
	// Adding axis labels
	svg.append("text")
		.attr({
			'class': 'label',
			'font-size': 18,
			'x': -65,
			'y': height - 965
		})
		.text('Jurisdiction');

	svg.append("text")
		.attr({
			'class': 'label',
			'font-size': 18,
			'x': 150,
			'y': height - 1008
		})
		.text('Year');

	//Append a defs (for definition) element to your SV
	var defs = svg.append("defs");

	//Append a linearGradient element to the defs and give it a unique id
	var linearGradient = defs.append("linearGradient")
		.attr("id", "linear-gradient");

	//Draw the rectangle and fill with gradient
	svg.append("rect")
		.attr("width", 200)
		.attr("height", 15)
		.attr({
			'x': 55,
			'y': height - 1060
			})
		.style("fill", "url(#linear-gradient)");

	//Append multiple color stops by using D3's data/enter step
	linearGradient.selectAll("stop")
		.data(colorScale.range())
		.enter().append("stop")
		.attr("offset", function(d,i) { return i/(colorScale.range().length-1); })
		.attr("stop-color", function(d) { return d; })
   
   // Adding legend label
	svg.append("text")
		.attr({
			'class': 'label',
			'font-size': 16,
			'x': 30,
			'y': height - 1070
		})
		.text('Percentage of defendants convicted through guilty pleas');
	
	//Set scale for x-axis
	var xScale = d3.scale.linear()
		 .range([0, 200])
		 .domain([.6,1]);

	//Define x-axis
	var xAxis = d3.svg.axis()
		  .orient("bottom")
		  .ticks(6)  //Set rough # of ticks
		  .scale(xScale);

	//Set up X axis
	svg.append("g")
		.attr("class", "axis")  //Assign "axis" class
		.attr("transform", "translate(55,-85)")
		.call(xAxis);

	// Adding footnotes
	svg.append("text")
		.attr({
			'class': 'label',
			'font-size': 16,
			'x': -65,
			'y': height - 365
		})
		.text('Data Source: Federal Justice Statistics Resource Center (FJSRC), Bureau of Justice Statistics - https://www.bjs.gov/fjsrc/');

	svg.append("text")
		.attr({
			'class': 'label',
			'font-size': 16,
			'x': -65,
			'y': height - 345
		})
		.text('Original D3 heatmap: https://bl.ocks.org/Bl3f/cdb5ad854b376765fa99');
	
	svg.append("text")
		.attr({
			'class': 'label',
			'font-size': 16,
			'x': -65,
			'y': height - 325
		})
		.text('Original D3 legend https://www.visualcinnamon.com/2016/05/smooth-color-legend-d3-svg-gradient.html');});
		