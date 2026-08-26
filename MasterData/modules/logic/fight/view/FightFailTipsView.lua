-- chunkname: @modules/logic/fight/view/FightFailTipsView.lua

module("modules.logic.fight.view.FightFailTipsView", package.seeall)

local FightFailTipsView = class("FightFailTipsView", BaseView)
local EffectPath = "m_s63_zjmzd/m_s63_zjmzd"

function FightFailTipsView:onInitView()
	self._simagetipbg = gohelper.findChildSingleImage(self.viewGO, "#simage_tipbg")
	self._simagetipbg1 = gohelper.findChildSingleImage(self.viewGO, "#go_outofround/ani/#simage_tipbg")
	self._simagetipbg2 = gohelper.findChildSingleImage(self.viewGO, "#go_fail/#simage_tipbg")
	self._gooutofround = gohelper.findChild(self.viewGO, "#go_outofround")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightFailTipsView:addEvents()
	return
end

function FightFailTipsView:removeEvents()
	return
end

function FightFailTipsView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Summon.Play_UI_CallFor_Open)
	self._simagetipbg:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))
	self._simagetipbg1:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))
	self._simagetipbg2:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))

	local fightResult = self.viewParam.fight_result

	gohelper.setActive(self._gofail, fightResult ~= FightEnum.FightResult.OutOfRoundFail)
	gohelper.setActive(self._gooutofround, fightResult == FightEnum.FightResult.OutOfRoundFail)
	TaskDispatcher.runDelay(self._waitForFailAnimFinish, self, 2)
end

function FightFailTipsView:_waitForFailAnimFinish()
	FightController.instance:GuideFlowPauseAndContinue("OnGuideFightEndPause_sp", FightEvent.OnGuideFightEndPause_sp, FightEvent.OnGuideFightEndContinue_sp, self._onGuideContinue, self)
end

function FightFailTipsView:_onGuideContinue()
	if self.viewParam.show_scene_dissolve_effect then
		local cur_scene_id = FightGameMgr.sceneLevelMgr.sceneId

		if cur_scene_id and cur_scene_id == 11501 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_effects_fight_backtime)
			self:_showDissolveEffect()
		else
			self:_restartSpAndCloseView()
		end
	else
		self:closeThis()
	end
end

function FightFailTipsView:_restartSpAndCloseView()
	self:_requestRestart()
	self:closeThis()
end

function FightFailTipsView:_showDissolveEffect()
	if GameSceneMgr.instance:useDefaultScene() then
		self:_removeEntity()
		self:_requestRestart()
		self:_onFinish()

		return
	end

	gohelper.setActive(self.viewGO, false)

	self._loader = MultiAbLoader.New()

	self._loader:addPath(FightHelper.getCameraAniPath(EffectPath))
	self._loader:startLoad(self._onLoaded, self)
	TaskDispatcher.runDelay(self.closeThis, self, 10)
end

function FightFailTipsView:_onLoaded()
	TaskDispatcher.cancelTask(self.closeThis, self, 10)
	UnityEngine.Shader.EnableKeyword("_USEPOP_ON")

	self.scene_animation = FightGameMgr.sceneLevelMgr:getSceneGo().transform:GetComponent(typeof(UnityEngine.Animation))

	self.scene_animation:Play("m_s63_ani")

	local _animatorInst = self._loader:getFirstAssetItem():GetResource(ResUrl.getCameraAnim(EffectPath))

	self._animComp = CameraMgr.instance:getCameraRootAnimator()
	self._animComp.enabled = true
	self._animComp.runtimeAnimatorController = nil
	self._animComp.runtimeAnimatorController = _animatorInst
	self._animComp.speed = FightModel.instance:getSpeed()

	self._animComp:Play("popcam")

	local time_len = self.scene_animation.clip.length

	TaskDispatcher.runDelay(self._onFinish, self, time_len)
	TaskDispatcher.runDelay(self._removeEntity, self, time_len - 2.5)
	TaskDispatcher.runDelay(self._requestRestart, self, time_len - 1.5)
end

function FightFailTipsView:_requestRestart()
	FightController.instance:dispatchEvent(FightEvent.OnEndFightForGuide)
	FightSystem.instance:dispose()
	FightGameMgr.entityMgr:delAllEntity()
	DungeonFightController.instance.restartSpStage()
end

function FightFailTipsView:_removeEntity()
	FightGameMgr.entityMgr:delAllEntity()
end

function FightFailTipsView:_onFinish()
	UnityEngine.Shader.DisableKeyword("_USEPOP_ON")
	self:closeThis()
end

function FightFailTipsView:onClose()
	if self.viewParam.callback then
		self.viewParam.callback()

		self.viewParam.callback = nil
	end

	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.cancelTask(self._onFinish, self)
	TaskDispatcher.cancelTask(self._removeEntity, self)
	TaskDispatcher.cancelTask(self._requestRestart, self)
	TaskDispatcher.cancelTask(self._waitForFailAnimFinish, self)

	if self._loader then
		self._loader:dispose()
	end

	UnityEngine.Shader.DisableKeyword("_USEPOP_ON")
end

function FightFailTipsView:onDestroyView()
	self._simagetipbg:UnLoadImage()
	self._simagetipbg1:UnLoadImage()
	self._simagetipbg2:UnLoadImage()
end

return FightFailTipsView
