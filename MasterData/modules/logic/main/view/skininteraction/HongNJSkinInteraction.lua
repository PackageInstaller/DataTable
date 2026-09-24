-- chunkname: @modules/logic/main/view/skininteraction/HongNJSkinInteraction.lua

module("modules.logic.main.view.skininteraction.HongNJSkinInteraction", package.seeall)

local HongNJSkinInteraction = class("HongNJSkinInteraction", CommonSkinInteraction)
local featherHideTime = 8
local heroId = 3155
local voiceId = 1315575
local FeatherSoundId = {
	startId = 1315586,
	endId = 1315589,
	clickId = 1315588
}

function HongNJSkinInteraction:_onInit()
	HongNJSkinInteraction.super._onInit(self)

	if not self._effectLoader then
		self._animationControllerName = "315503_tlzchnj_jt"
		self._effectUrl = string.format("ui/animations/dynamic/%s.controller", self._animationControllerName)
		self._featherUrl = "ui/viewres/story/v4a0/stroy_sphongnujian_dunpai.prefab"
		self._effectLoader = MultiAbLoader.New()

		self._effectLoader:addPath(self._effectUrl)
		self._effectLoader:addPath(self._featherUrl)
		self._effectLoader:startLoad(self._loadEffectFinished, self)
	end

	MainController.instance:registerCallback(MainEvent.HeroShowInScene, self._onHeroShowInScene, self)
end

function HongNJSkinInteraction:_onStopVoice()
	HongNJSkinInteraction.super._onStopVoice(self)

	if self._clickFeatherGo then
		TaskDispatcher.cancelTask(self._hideFeather, self)
		gohelper.setActive(self._clickFeatherGo, false)
	end
end

function HongNJSkinInteraction:_loadEffectFinished(effectLoader)
	return
end

function HongNJSkinInteraction:_onHeroShowInScene(showInScene)
	if showInScene then
		return
	end

	if self._effectLoader.isLoading then
		logNormal("HongNJSkinInteraction effectLoader is loading")

		return
	end

	if not self._featherGo then
		local path = self._featherUrl
		local assetItem = self._effectLoader:getAssetItem(path)
		local prefab = assetItem and assetItem:GetResource(path)

		if not prefab then
			logError("HongNJSkinInteraction feather prefab is nil")

			return
		end

		self._featherGo = gohelper.clone(prefab, self._view.viewGO)
		self._clickFeatherGo = self._featherGo

		local clickGo = gohelper.findChild(self._featherGo, "#click")

		self._clickMaskableGraphic = clickGo:GetComponent(typeof(UnityEngine.UI.MaskableGraphic))
		self._click = SLFramework.UGUI.UIClickListener.Get(clickGo)

		self._click:AddClickListener(self._onFeatherClick, self)

		self._featherAnimator = ZProj.ProjAnimatorPlayer.Get(self._featherGo)
	end

	self._clickMaskableGraphic.raycastTarget = true

	gohelper.setActive(self._featherGo, true)
	gohelper.setActive(self._clickFeatherGo, true)
	self._featherAnimator:Play("open")
	TaskDispatcher.cancelTask(self._hideFeather, self)
	TaskDispatcher.runDelay(self._hideFeather, self, featherHideTime)
	AudioMgr.instance:trigger(FeatherSoundId.startId)
end

function HongNJSkinInteraction:_hideFeather()
	TaskDispatcher.cancelTask(self._hideFeather, self)

	self._clickMaskableGraphic.raycastTarget = false

	self._featherAnimator:Play("close", self._onHideClick, self)
	AudioMgr.instance:trigger(FeatherSoundId.endId)
end

function HongNJSkinInteraction:_onHideClick()
	gohelper.setActive(self._clickFeatherGo, false)
end

function HongNJSkinInteraction:_onFeatherClick()
	UIBlockMgrExtend.setNeedCircleMv(false)

	local time = 1.6

	UIBlockHelper.instance:startBlock("HongNJSkinInteractionCameraAnim", time)
	TaskDispatcher.cancelTask(self._hideFeather, self)

	self._clickMaskableGraphic.raycastTarget = false

	self._featherAnimator:Play("click")
	self:_playCameraAnim("315503_tlzchnj_jt_jh00")
	CharacterVoiceController.instance:dispatchEvent(CharacterVoiceEvent.HongNJSkinInteractionStart)
	CharacterVoiceController.instance:dispatchEvent(CharacterVoiceEvent.PlayMainViewAnim, "mainview_out")
	AudioMgr.instance:trigger(FeatherSoundId.clickId)
	TaskDispatcher.runDelay(self._clickHandler, self, time)
end

function HongNJSkinInteraction:_clickHandler()
	UIBlockMgrExtend.setNeedCircleMv(true)
	MainController.instance:dispatchEvent(MainEvent.SetHeroInScene, true)

	local config = lua_character_voice.configDict[heroId][voiceId]

	self:playVoice(config)
end

function HongNJSkinInteraction:_playCameraAnim(animName)
	if not self._effectLoader then
		return
	end

	local path = self._effectUrl
	local assetItem = self._effectLoader:getAssetItem(path)
	local animatorInst = assetItem and assetItem:GetResource(path)

	if animatorInst then
		local animator = CameraMgr.instance:getCameraRootAnimator()

		animator.runtimeAnimatorController = animatorInst
		animator.enabled = true

		animator:Play(animName, 0, 0)
	else
		logError("HongNJSkinInteraction:_playCameraAnim animatorInst is nil", path)
	end
end

function HongNJSkinInteraction:_onDestroy()
	HongNJSkinInteraction.super._onDestroy(self)
	TaskDispatcher.cancelTask(self._hideFeather, self)
	TaskDispatcher.cancelTask(self._clickHandler, self)

	if self._click then
		self._click:RemoveClickListener()

		self._click = nil
	end

	if self._featherGo then
		gohelper.destroy(self._featherGo)

		self._featherGo = nil
	end

	if self._effectLoader then
		self._effectLoader:dispose()

		self._effectLoader = nil
	end

	MainController.instance:unregisterCallback(MainEvent.HeroShowInScene, self._onHeroShowInScene, self)
	self:_resetCameraPos(self._animationControllerName)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

return HongNJSkinInteraction
