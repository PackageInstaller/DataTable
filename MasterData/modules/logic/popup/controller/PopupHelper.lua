-- chunkname: @modules/logic/popup/controller/PopupHelper.lua

module("modules.logic.popup.controller.PopupHelper", package.seeall)

local PopupHelper = class("PopupHelper")

function PopupHelper.checkInFight()
	return (GameSceneMgr.instance:isFightScene())
end

function PopupHelper.checkInGuide()
	local isGuiding = GuideController.instance:isGuiding()
	local isOpenGuideView = ViewMgr.instance:isOpen(ViewName.GuideView)
	local forceGuideId = GuideModel.instance:lastForceGuideId()
	local isFinishForceGuide = GuideModel.instance:isGuideFinish(forceGuideId)

	return not isGuiding and not isOpenGuideView and isFinishForceGuide or true
end

function PopupHelper.checkInSummonDrawing()
	return (SummonModel.instance:getIsDrawing())
end

return PopupHelper
