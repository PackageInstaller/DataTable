-- chunkname: @modules/logic/fight/system/work/FightWorkClearBeforeSwitchPlane.lua

module("modules.logic.fight.system.work.FightWorkClearBeforeSwitchPlane", package.seeall)

local FightWorkClearBeforeSwitchPlane = class("FightWorkClearBeforeSwitchPlane", FightWorkItem)

function FightWorkClearBeforeSwitchPlane:onConstructor()
	self.SAFETIME = 5
end

function FightWorkClearBeforeSwitchPlane:onStart()
	local cur_scene = GameSceneMgr.instance:getCurScene()

	cur_scene.view:onSceneClose()
	FightGameMgr.sceneLevelMgr:setFrontVisible(true)

	if ViewMgr.instance:isOpen(ViewName.FightView) then
		self:com_registEvent(ViewMgr.instance, ViewEvent.DestroyViewFinish, self._onDestroyViewFinish)
		TaskDispatcher.runDelay(self.onDelayDone, self, 3)
	else
		self:clearData()
	end
end

function FightWorkClearBeforeSwitchPlane:onDelayDone()
	self:clearData()
end

function FightWorkClearBeforeSwitchPlane:_onDestroyViewFinish(viewName)
	if viewName ~= ViewName.FightView then
		return
	end

	self:clearData()
end

function FightWorkClearBeforeSwitchPlane:clearData()
	TaskDispatcher.cancelTask(self.onDelayDone, self)

	FightDataHelper.tempMgr.simplePolarizationLevel = nil

	StoryController.instance:closeStoryView()
	FightFloatMgr.instance:clearFloatItem()
	FightPreloadController.instance:releaseRoleCardAsset()
	FightController.instance:dispatchEvent(FightEvent.OnSwitchPlaneClearAsset)

	local cur_scene = GameSceneMgr.instance:getCurScene()

	FightGameMgr.entityMgr:delAllEntity()
	cur_scene.director:registRespBeginFight()
	FightGameMgr.bgmMgr:resumeBgm()
	FightSkillMgr.instance:dispose()
	FightSystem.instance:dispose()
	FightNameMgr.instance:onRestartStage()
	FightAudioMgr.instance:dispose()

	FightRoundSequence.roundTempData = {}

	cur_scene.camera:enablePostProcessSmooth(false)
	cur_scene.camera:resetParam()
	cur_scene.camera:setSceneCameraOffset()

	FightModel.instance._curRoundId = 1

	FightModel.instance:onSwitchPlane()
	FightController.instance:dispatchEvent(FightEvent.OnSwitchPlaneClearAssetDone)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), false)
	self:onDone(true)
end

function FightWorkClearBeforeSwitchPlane:clearWork()
	TaskDispatcher.cancelTask(self.onDelayDone, self)
end

return FightWorkClearBeforeSwitchPlane
