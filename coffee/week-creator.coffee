class window.WeekCreator
	constructor: (config, dayHighlighter, eventLoader) ->
		@config: config
		@dayHighlighter: dayHighlighter
		@eventLoader: eventLoader
		
	create: (weekStart) ->
		# Clonse the week template and set it's id to it's start date
		week: $("#templates .week").clone().attr "id", @config.weekIdPrefix + weekStart.customFormat(@config.dateFormat)
		week.css 'opacity', 0.3

		# Set the id of each day to that day's date 
		$("td", week).attr "id", (index) =>
			@config.dayIdPrefix + weekStart.addDays(index).customFormat(@config.dateFormat);
		
		# Set the day label for each day, e.g. '12'
		$(".day-label", week).each (index, day_label) =>
			dayDate: weekStart.addDays index
			dayNumber: dayDate.customFormat "#D#"

			# If this is the first day in the month then add a month label, e.g. 'February'
			$(day_label).html dayNumber
			if dayNumber == "1"
				monthLabel: $("#templates .month-label").clone().html dayDate.customFormat("#MMMM#")
				$(day_label).after monthLabel
				$(day_label).parent().addClass "start-month"
			
			# if the this is todays date then highlight it
			if dayDate.customFormat(@config.dateFormat) == new Date().customFormat(@config.dateFormat)
				@dayHighlighter.highlightDay $(day_label).parent()
			
		return week
