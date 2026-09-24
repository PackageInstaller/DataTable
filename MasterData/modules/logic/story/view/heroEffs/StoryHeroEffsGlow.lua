-- chunkname: @modules/logic/story/view/heroEffs/StoryHeroEffsGlow.lua

module("modules.logic.story.view.heroEffs.StoryHeroEffsGlow", package.seeall)

local StoryHeroEffsGlow = class("StoryHeroEffsGlow", StoryHeroEffsBase)
local glowMatPath = "ui/materials/dynamic/spine_skeleton_graphic_perspective.mat"
local glowMaskBeginColor = Color.New(0.3, 0.3, 0.3, 1)
local glowMaskColor = Color.New(0.6, 0.6, 0.6, 1)
local glowQuickBloomG = 0.16
local glowBlurFactor = 0
local glowFadeInDuration = 0.5
local glowFadeOutDuration = 0.5

function StoryHeroEffsGlow:ctor()
	StoryHeroEffsGlow.super.ctor(self)
end

function StoryHeroEffsGlow:init(go)
	StoryHeroEffsGlow.super.init(self)

	self._heroGo = go
	self._skeletonGraphic = self._heroGo:GetComponent(GuiSpine.TypeSkeletonGraphic)

	table.insert(self._resList, glowMatPath)
end

function StoryHeroEffsGlow:start()
	StoryHeroEffsGlow.super.start(self)
	self:loadRes()
end

function StoryHeroEffsGlow:onLoadFinished()
	StoryHeroEffsGlow.super.onLoadFinished(self)

	if not self._skeletonGraphic then
		return
	end

	local glowMat = self._loader:getAssetItem(glowMatPath):GetResource(glowMatPath)

	self._glowMat = UnityEngine.Material.Instantiate(glowMat)

	self._glowMat:SetColor("_MaskColor", glowMaskBeginColor)
	self._glowMat:SetFloat("_QuickBloomG", glowQuickBloomG)
	self._glowMat:SetFloat("_BlurFactor", glowBlurFactor)

	self._originMat = self._skeletonGraphic.material
	self._skeletonGraphic.material = self._glowMat

	StoryTool.enablePostProcess(true)
	PostProcessingMgr.instance:setUIPPValue("localBloomActive", true)
	self:_setGlowOn(true)

	if self._fadeInDone then
		self:_onFadeUpdate(1)

		return
	end

	self._fadeInTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, glowFadeInDuration, self._onFadeUpdate, self._onFadeInFinished, self, nil, EaseType.Linear)
end

function StoryHeroEffsGlow:_onFadeInFinished()
	self._fadeInDone = true
	self._fadeInTweenId = nil
end

function StoryHeroEffsGlow:_onFadeUpdate(value)
	if self._glowMat and not gohelper.isNil(self._glowMat) then
		local r = glowMaskBeginColor.r + (glowMaskColor.r - glowMaskBeginColor.r) * value
		local g = glowMaskBeginColor.g + (glowMaskColor.g - glowMaskBeginColor.g) * value
		local b = glowMaskBeginColor.b + (glowMaskColor.b - glowMaskBeginColor.b) * value

		self._glowMat:SetColor("_MaskColor", Color.New(r, g, b, 1))
	end
end

function StoryHeroEffsGlow:_onFadeOutUpdate(value)
	if self._skeletonGraphic and not gohelper.isNil(self._skeletonGraphic) then
		local mat = self._skeletonGraphic.materialForRendering

		if mat then
			mat:SetFloat("_BloomFactor", value * 0.2)
		end
	end
end

function StoryHeroEffsGlow:startFadeOut(fadeOutDuration)
	fadeOutDuration = fadeOutDuration or glowFadeOutDuration

	if self._fadeInTweenId then
		ZProj.TweenHelper.KillById(self._fadeInTweenId)

		self._fadeInTweenId = nil
	end

	local mat = self._skeletonGraphic.materialForRendering

	if mat then
		mat:SetFloat("_BloomFactor", 0.2)
	end

	self._fadeOutTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, fadeOutDuration, self._onFadeOutUpdate, self._onFadeOutFinished, self, nil, EaseType.Linear)
end

function StoryHeroEffsGlow:_onFadeOutFinished()
	PostProcessingMgr.instance:setUIPPValue("localBloomActive", false)
	self:_setGlowOn(false)

	self._fadeOutTweenId = nil
end

function StoryHeroEffsGlow:_setGlowOn(on)
	if self._glowOn == on then
		return
	end

	self._glowOn = on

	if on then
		StoryController.instance:registerCallback(StoryEvent.RefreshStep, self._refreshDialogLayer, self)
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	else
		StoryController.instance:unregisterCallback(StoryEvent.RefreshStep, self._refreshDialogLayer, self)
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)

		self._topViewOpened = nil
	end

	self:_refreshDialogLayer()
end

function StoryHeroEffsGlow:_onOpenView(viewName)
	if StoryModel.instance:isSetTopView(viewName) then
		self._topViewOpened = true

		self:_refreshDialogLayer()
	end
end

function StoryHeroEffsGlow:_onCloseView(viewName)
	if StoryModel.instance:isSetTopView(viewName) then
		self._topViewOpened = nil

		self:_refreshDialogLayer()
	end
end

function StoryHeroEffsGlow:_isSoftLightStep()
	local stepCo = StoryStepModel.instance:getStepListById(StoryModel.instance:getCurStepId())

	if stepCo then
		::label_13_0::

		local var_13_0 = stepCo.conversation

		if stepCo.conversation then
			local effType = stepCo.conversation.effType

			return effType == StoryEnum.ConversationEffectType.SoftLight or effType == StoryEnum.ConversationEffectType.SoftLightDarkBg
		end
	end
end

function StoryHeroEffsGlow:_refreshDialogLayer()
	local var_14_0 = self._glowOn and (not self._topViewOpened and not self:_isSoftLightStep() or false)
	local wantTop = true

	goto label_14_0

	::label_14_0::

	if wantTop then
		if self._dialogTopOn then
			return
		end

		local viewGo = StoryViewMgr.instance:getStoryView()

		if not viewGo or viewGo.layer == UnityLayer.UITop then
			return
		end

		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)

		self._dialogTopOn = true
	else
		if not self._dialogTopOn then
			return
		end

		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)

		self._dialogTopOn = false
	end
end

function StoryHeroEffsGlow:destroy()
	if self._fadeInTweenId then
		ZProj.TweenHelper.KillById(self._fadeInTweenId)

		self._fadeInTweenId = nil
	end

	self:_doDestroy()
end

function StoryHeroEffsGlow:_doDestroy()
	if self._fadeOutTweenId then
		ZProj.TweenHelper.KillById(self._fadeOutTweenId)

		self._fadeOutTweenId = nil
	end

	self:_setGlowOn(false)

	if self._skeletonGraphic and not gohelper.isNil(self._skeletonGraphic) and self._originMat then
		self._skeletonGraphic.material = self._originMat
		self._originMat = nil
	end

	if self._glowMat then
		UnityEngine.Object.Destroy(self._glowMat)

		self._glowMat = nil
	end

	StoryHeroEffsGlow.super.destroy(self)
end

return StoryHeroEffsGlow
