-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/view/NewYearPrayMo.lua

module("logic.extensions.newyearpray.view.NewYearPrayMo", package.seeall)

local NewYearPrayMo = class("NewYearPrayMo")

function NewYearPrayMo:ctor(activityId)
	self._activityId = activityId
	self._leftActCount = 0
	self._progress = 0
	self._dataBitIdListOfHasGain = {}
	self._stepChoiceInfoList = {}
end

function NewYearPrayMo:getActivityId()
	return self._activityId
end

function NewYearPrayMo:deepcopy()
	return TableUtil.deepcopy(self)
end

function NewYearPrayMo:handlePM_NewYearPrayGetInfoRes(msg)
	self._leftActCount = msg.leftActCount
	self._progress = msg.progress

	table.clear(self._dataBitIdListOfHasGain)
	table.insertto(self._dataBitIdListOfHasGain, msg.progressPrizeGainedBitId)
end

function NewYearPrayMo:handlePM_NewYearPrayDoPrayRes(msg)
	self._leftActCount = msg.leftActCount
	self._progress = msg.progress

	for _, info in ipairs(msg.stepChoices) do
		self._stepChoiceInfoList[info.stepId] = GameUtil.pbToTable(info)
	end
end

function NewYearPrayMo:handlePM_NewYearPrayGainProgressPrizeRes(msg)
	table.insert(self._dataBitIdListOfHasGain, msg.dataBitId)
end

function NewYearPrayMo:getLeftActCount()
	return self._leftActCount
end

function NewYearPrayMo:getProgress()
	return self._progress
end

function NewYearPrayMo:getDataBitIdListOfHasGain()
	return self._dataBitIdListOfHasGain
end

function NewYearPrayMo:getScoreOfStep(stepId)
	local info = self._stepChoiceInfoList[stepId]

	return (info or nil) and info.score
end

return NewYearPrayMo
