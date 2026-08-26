-- chunkname: @modules/logic/fight/system/work/FightWorkClearBeforeRestart.lua

module("modules.logic.fight.system.work.FightWorkClearBeforeRestart", package.seeall)

local FightWorkClearBeforeRestart = class("FightWorkClearBeforeRestart", FightWorkItem)

function FightWorkClearBeforeRestart:onConstructor()
	self.SAFETIME = 30
end

function FightWorkClearBeforeRestart:onStart()
	self:com_registEvent(ViewMgr.instance, ViewEvent.DestroyViewFinish, self._onDestroyViewFinish)

	local cur_scene = GameSceneMgr.instance:getCurScene()

	cur_scene.view:onSceneClose()
	FightGameMgr.sceneLevelMgr:setFrontVisible(true)
end

function FightWorkClearBeforeRestart:_onDestroyViewFinish(viewName)
	if viewName == ViewName.FightView then
		FightDataHelper.tempMgr.simplePolarizationLevel = nil

		StoryController.instance:closeStoryView()
		FightFloatMgr.instance:clearFloatItem()
		FightPreloadController.instance:releaseRoleCardAsset()
		FightController.instance:dispatchEvent(FightEvent.OnEndFightForGuide)
		FightController.instance:dispatchEvent(FightEvent.OnRestartStageBefore)

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

		FightModel.instance:onRestart()
		FightController.instance:dispatchEvent(FightEvent.OnRestartFightDisposeDone)
		gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), false)
		self:onDone(true)
	end
end

return FightWorkClearBeforeRestart
