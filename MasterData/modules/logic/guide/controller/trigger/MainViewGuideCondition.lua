-- chunkname: @modules/logic/guide/controller/trigger/MainViewGuideCondition.lua

module("modules.logic.guide.controller.trigger.MainViewGuideCondition", package.seeall)

local MainViewGuideCondition = class("MainViewGuideCondition")
local rougeOpenMainViewGuideId = 19701

function MainViewGuideCondition.getCondition(guideId)
	return MainViewGuideCondition.guideConditions[guideId]
end

function MainViewGuideCondition._checkRougeOpen()
	local unlock = RougeOutsideModel.instance:isUnlock()
	local doingClickGuide = GuideModel.instance:isDoingClickGuide()

	return unlock and not doingClickGuide
end

MainViewGuideCondition.guideConditions = {
	[rougeOpenMainViewGuideId] = MainViewGuideCondition._checkRougeOpen
}

return MainViewGuideCondition
