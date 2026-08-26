-- chunkname: @modules/logic/notice/controller/NoticeHelper.lua

module("modules.logic.notice.controller.NoticeHelper", package.seeall)

local NoticeHelper = class("NoticeHelper")

function NoticeHelper._initTypeHandle()
	if NoticeHelper.timeTypeHandleDict then
		return
	end

	NoticeHelper.timeTypeHandleDict = {
		[NoticeEnum.FindTimeType.MD_HM] = NoticeHelper._matchTime_MD_HM,
		[NoticeEnum.FindTimeType.YMD_HMS] = NoticeHelper._matchTime_YMD_HMS,
		[NoticeEnum.FindTimeType.YMD_HM] = NoticeHelper._matchTime_YMD_HM,
		[NoticeEnum.FindTimeType.MDH] = NoticeHelper._matchTime_MDH,
		[NoticeEnum.FindTimeType.YMD_W_HM] = NoticeHelper._matchTime_YMD_W_HM
	}
end

function NoticeHelper.getTimeMatchIndex(content)
	NoticeHelper._initTypeHandle()

	for type, formatList in ipairs(NoticeEnum.TimeFormatType) do
		local handle = NoticeHelper.timeTypeHandleDict[type]
		local index = handle(content, formatList, false)

		if index then
			return type, index
		end
	end
end

function NoticeHelper.getTimeMatchIndexAndTimeTable(content)
	NoticeHelper._initTypeHandle()

	for type, formatList in ipairs(NoticeEnum.TimeFormatType) do
		local handle = NoticeHelper.timeTypeHandleDict[type]
		local index, timeTable = handle(content, formatList, true)

		if index then
			return type, index, timeTable
		end
	end
end

function NoticeHelper._matchTime_YMD_HMS(content, formatList, needTimeTable)
	for index, format in ipairs(formatList) do
		local _, _, year, month, day, hour, minute, second = string.find(content, format)

		if year and month and day and hour and minute and second then
			if needTimeTable then
				local timeTable = {
					year = year,
					month = month,
					day = day,
					hour = hour,
					min = minute,
					sec = second
				}

				return index, timeTable
			else
				return index
			end
		end
	end
end

function NoticeHelper._matchTime_MD_HM(content, formatList, needTimeTable)
	for index, format in ipairs(formatList) do
		local _, _, month, day, hour, minute = string.find(content, format)

		if month and day and hour and minute then
			if needTimeTable then
				local time = TimeUtil.timestampToTable(os.time())
				local timeTable = {
					sec = 0,
					year = time.year,
					month = month,
					day = day,
					hour = hour,
					min = minute
				}

				return index, timeTable
			else
				return index
			end
		end
	end
end

function NoticeHelper._matchTime_YMD_HM(content, formatList, needTimeTable)
	for index, format in ipairs(formatList) do
		local _, _, year, month, day, hour, minute = string.find(content, format)

		if year and month and day and hour and minute then
			if needTimeTable then
				local timeTable = {
					sec = 0,
					year = year,
					month = month,
					day = day,
					hour = hour,
					min = minute
				}

				return index, timeTable
			else
				return index
			end
		end
	end
end

function NoticeHelper._matchTime_MDH(content, formatList, needTimeTable)
	for index, format in ipairs(formatList) do
		local _, _, month, day, hour = string.find(content, format)

		if month and day and hour then
			if needTimeTable then
				local time = TimeUtil.timestampToTable(os.time())
				local timeTable = {
					min = 0,
					sec = 0,
					year = time.year,
					month = month,
					day = day,
					hour = hour
				}

				return index, timeTable
			else
				return index
			end
		end
	end
end

function NoticeHelper._matchTime_YMD_W_HM(content, formatList, needTimeTable)
	for index, format in ipairs(formatList) do
		local _, _, year, month, day, week, hour, minute = string.find(content, format)

		if year and month and day and hour and minute then
			if needTimeTable then
				local timeTable = {
					sec = 0,
					year = year,
					month = month,
					day = day,
					hour = hour,
					min = minute
				}

				return index, timeTable
			else
				return index
			end
		end
	end
end

function NoticeHelper.buildTimeByType(type, index, timeTable)
	local formatList = NoticeEnum.TimeFormat[type]

	formatList = formatList or NoticeEnum.TimeFormat[NoticeEnum.FindTimeType.YMD_HMS]

	local format = formatList[index]

	format = format or formatList[1]

	return NoticeHelper.buildTimeByFormat(format, timeTable)
end

function NoticeHelper.buildTimeByFormat(format, timeTable)
	format = string.gsub(format, NoticeEnum.Time.Year, timeTable.year)
	format = string.gsub(format, NoticeEnum.Time.Month, timeTable.month)
	format = string.gsub(format, NoticeEnum.Time.Day, timeTable.day)
	format = string.gsub(format, NoticeEnum.Time.Hour, string.format("%02d", timeTable.hour))
	format = string.gsub(format, NoticeEnum.Time.Minute, string.format("%02d", timeTable.min))
	format = string.gsub(format, NoticeEnum.Time.Second, string.format("%02d", timeTable.sec))

	local weekDay = TimeUtil.convertWday(timeTable.wday)

	format = string.gsub(format, NoticeEnum.Time.Week, NoticeEnum.WeekDayToChar[weekDay])

	return format
end

return NoticeHelper
