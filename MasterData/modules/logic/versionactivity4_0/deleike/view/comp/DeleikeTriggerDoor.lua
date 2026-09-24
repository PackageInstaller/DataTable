-- chunkname: @modules/logic/versionactivity4_0/deleike/view/comp/DeleikeTriggerDoor.lua

module("modules.logic.versionactivity4_0.deleike.view.comp.DeleikeTriggerDoor", package.seeall)

local DeleikeTriggerDoor = class("DeleikeTriggerDoor", DeleikeTriggerBase)

function DeleikeTriggerDoor:init(go)
	DeleikeTriggerDoor.super.init(self, go)

	self.isDoor = true
	self.goUncut = gohelper.findChild(go, "uncut")
	self.gameId = DeleikeGameMgr.instance.gameId
end

function DeleikeTriggerDoor:addEventListeners()
	self.addEventCb(self, GuideController.instance, GuideEvent.FinishGuide, self.onGuideFinish, self)
end

function DeleikeTriggerDoor:onDestroy()
	GameUtil.setActiveUIBlock("DeleikeTriggerDoorLock", false, true)
end

function DeleikeTriggerDoor:onPicked()
	GameUtil.setActiveUIBlock("DeleikeTriggerDoorLock", true, false)
	AudioMgr.instance:trigger(AudioEnum4_0.Deleike.trigger_door)
end

function DeleikeTriggerDoor:onAnimFinish()
	GameUtil.setActiveUIBlock("DeleikeTriggerDoorLock", false, true)

	local isRunning = false

	if self.gameId == 1001 then
		isRunning = GuideModel.instance:isGuideRunning(40027)
	elseif self.gameId == 1002 then
		isRunning = GuideModel.instance:isGuideRunning(40030)
	end

	if isRunning then
		DeleikeController.instance:dispatchEvent(DeleikeEvent.ZTriggerFinishGame, self.gameId)
	else
		ViewMgr.instance:openView(ViewName.DeleikeGameResultView)
	end
end

function DeleikeTriggerDoor:onGuideFinish(guideId)
	if self.isCollected and (guideId == 40027 or guideId == 40030) then
		ViewMgr.instance:openView(ViewName.DeleikeGameResultView)
	end
end

return DeleikeTriggerDoor
