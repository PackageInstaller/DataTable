-- chunkname: @modules/logic/main/controller/work/MainParallelGuideWork.lua

module("modules.logic.main.controller.work.MainParallelGuideWork", package.seeall)

local MainParallelGuideWork = class("MainParallelGuideWork", BaseWork)

function MainParallelGuideWork:onStart(context)
	local forbidGuides = GuideController.instance:isForbidGuides()

	if forbidGuides then
		self:onDone(true)

		return
	end

	local doingMainViewGuide = self:_checkDoGuide()

	self:onDone(not doingMainViewGuide)
end

function MainParallelGuideWork:_checkDoGuide()
	local mainViewGuideId = tonumber(GuideModel.instance:getFlagValue(GuideModel.GuideFlag.MainViewGuideId))

	if mainViewGuideId and mainViewGuideId > 0 then
		local condition = MainViewGuideCondition.getCondition(mainViewGuideId)
		local conditionPass = condition == nil and true or condition()

		if conditionPass then
			GuideController.instance:dispatchEvent(GuideEvent.DoMainViewGuide, mainViewGuideId)

			return true
		end
	end

	return false
end

return MainParallelGuideWork
