-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PlotRewind\\PlotRewindUtils.lua

local PlotRewindUtils = {}
local ResAchieve = require("ClientData/ResAchieve")
local ResPlotRewindMainChapter = require("ClientData/ResPlotRewindMainChapter")
local UserData = require("Helper/UserData")
local ResPlotRewindChapter = require("ClientData/ResPlotRewindChapter")
local ResPlotRewindDetail = require("ClientData/ResPlotRewindDetail")

PlotRewindUtils.HasClickedString = "PlotRewindClicked"
PlotRewindUtils.ClickTimeString = "PlotRewindClickTime"

function PlotRewindUtils.CheckTimeUnlocked(data)
	local startTimeID = data.unlock_time_id
	local unlocked = true
	local unlockTime, countDownTime

	if startTimeID then
		local lastDays = data.activity_last_days

		unlockTime = ClientUtils.getTimeConfigTimestamp(startTimeID)

		if lastDays then
			unlockTime = unlockTime + lastDays * 24 * 3600
		end

		unlocked = unlockTime <= ClientUtils.getServerTime()
		countDownTime = unlockTime - ClientUtils.getServerTime()
	end

	return unlocked, unlockTime, countDownTime
end

function PlotRewindUtils.CheckNewSideLine(data)
	local unlocked, unlockTime, countDownTime = PlotRewindUtils.CheckTimeUnlocked(data)
	local clickTime = UserData.loadCommonData(CurAvatar.uid .. PlotRewindUtils.ClickTimeString)

	clickTime = clickTime and tonumber(clickTime)

	local hasNew = false

	if unlocked and (not clickTime or unlockTime and clickTime <= unlockTime) then
		hasNew = true
	end

	return hasNew, countDownTime
end

function PlotRewindUtils.CheckNewAllSiderLine()
	local state = false
	local allChapter = PlotRewindUtils.getAllMainChapter(UIConst.PLOT_REWIND_SIDE_LINE)
	local nearestUnlockCountDown

	for index, data in pairs(allChapter) do
		local hasUnlockedNew, countDownTime = PlotRewindUtils.CheckNewSideLine(data)

		if countDownTime and countDownTime > 0 and (not nearestUnlockCountDown or countDownTime < nearestUnlockCountDown) then
			nearestUnlockCountDown = countDownTime
		end

		if hasUnlockedNew then
			state = true
		end
	end

	return state, nearestUnlockCountDown
end

function PlotRewindUtils.getAllMainChapter(storyType)
	local data = {}

	for id, mainChapter in pairs(ResPlotRewindMainChapter) do
		if mainChapter.main_chapter_type == storyType then
			data[mainChapter.index] = mainChapter
		end
	end

	return data
end

function PlotRewindUtils.checkChapterProgress(chapterID)
	local unlocked = true
	local paragraphs = ResPlotRewindDetail[chapterID]

	if not paragraphs then
		-- block empty
	else
		for paragraphIndex, paragraph in pairs(paragraphs) do
			local conditionId = paragraph.unlock_condition

			if conditionId then
				local achieveGot = CurAvatar.achieveQualify[conditionId]

				if not achieveGot then
					unlocked = false

					break
				end
			end
		end
	end

	return unlocked
end

return PlotRewindUtils
