-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsScreenHalo.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsScreenHalo", package.seeall)

local StoryBgEffsScreenHalo = class("StoryBgEffsScreenHalo", StoryBgEffsBase)

function StoryBgEffsScreenHalo:ctor()
	StoryBgEffsScreenHalo.super.ctor(self)
end

function StoryBgEffsScreenHalo:init(bgCo)
	StoryBgEffsScreenHalo.super.init(self, bgCo)

	self._matPath = "ui/materials/dynamic/story_v3a9_screenhalo.mat"

	table.insert(self._resList, self._matPath)

	self._bgImgGo = StoryViewMgr.instance:getStoryFrontBgImgGo()
	self._bgFrontImg = self._bgImgGo:GetComponent(gohelper.Type_Image)
	self._effLoaded = false
	self._cfg = bgCo
end

function StoryBgEffsScreenHalo:start()
	StoryBgEffsScreenHalo.super.start(self)
	self:loadRes()
end

function StoryBgEffsScreenHalo:onLoadFinished()
	StoryBgEffsScreenHalo.super.onLoadFinished(self)

	self._effLoaded = true

	local mat = self._loader:getAssetItem(self._matPath):GetResource()

	self._mat = UnityEngine.Object.Instantiate(mat)

	self:playEffect()
end

function StoryBgEffsScreenHalo:reset(bgCo)
	StoryBgEffsScreenHalo.super.reset(self, bgCo)
	self:playEffect()
end

function StoryBgEffsScreenHalo:keep()
	StoryTool.enablePostProcess(true)

	if self._bgCo and self._bgCo.effType == StoryEnum.BgEffectType.ScreenHalo2 then
		self:setBackgroundViewLayer()
		PostProcessingMgr.instance:setUIPPValue("localBloomActive", true)
		PostProcessingMgr.instance:setUIPPValue("localMaskActive", true)
	end
end

function StoryBgEffsScreenHalo:playEffect()
	if not self._mat then
		return
	end

	if self._bgFrontImg then
		self._bgFrontImg.material = self._mat
	end

	self:keep()

	self.initValues = StoryTool.getMaterialSchemeInitValues(self._mat, self._bgCo.materialId)

	local scheme = StoryTool.getMaterialMergedScheme(self._bgCo.materialId)

	self.endValues = scheme and scheme.props

	local transTime = self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	local curve = scheme and scheme.curve

	self:fadeIn(transTime, curve)
end

function StoryBgEffsScreenHalo:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	if self.curvePlayer then
		self.curvePlayer:clearAnim()
	end
end

function StoryBgEffsScreenHalo:fadeIn(transTime, curve)
	self.startAnim(self, 0, 1, transTime, curve, self._setBlendVal, self.fadeInFinish, self)
end

function StoryBgEffsScreenHalo:fadeInFinish()
	self:_setBlendVal(1)
end

function StoryBgEffsScreenHalo:startAnim(startVal, endVal, transTime, curve, farmeCallback, finishCallback, callbackObj)
	self:killTween()

	if transTime and transTime > 0.1 then
		if curve then
			self.curvePlayer = self.curvePlayer or StoryCurvePlayer.New()

			self.curvePlayer:playAnim(startVal, endVal, transTime, curve, farmeCallback, finishCallback, callbackObj)
		else
			self.tweenId = ZProj.TweenHelper.DOTweenFloat(startVal, endVal, transTime, farmeCallback, finishCallback, callbackObj, nil, EaseType.Linear)
		end
	elseif finishCallback then
		finishCallback(callbackObj)
	end
end

function StoryBgEffsScreenHalo:_setBlendVal(val)
	if not self._mat then
		return
	end

	StoryTool.lerpMaterialSchemeValues(self._mat, self.initValues, self.endValues, val)
end

function StoryBgEffsScreenHalo:setBackgroundViewLayer()
	if self._hasSetLayer then
		return
	end

	self._hasSetLayer = true

	local parent = ViewMgr.instance:getUILayer("POPUP")

	gohelper.setLayer(parent, UnityLayer.UISecond, true)
end

function StoryBgEffsScreenHalo:resetBackgroundViewLayer()
	if not self._hasSetLayer then
		return
	end

	local parent = ViewMgr.instance:getUILayer("POPUP")

	gohelper.setLayer(parent, UnityLayer.UI, true)

	self._hasSetLayer = nil
end

function StoryBgEffsScreenHalo:destroy()
	self:killTween()

	self._mat = nil

	if self._bgFrontImg then
		self._bgFrontImg.material = nil
		self._bgFrontImg = nil
	end

	if self._effectGo then
		gohelper.destroy(self._effectGo)

		self._effectGo = nil
	end

	if self.curvePlayer then
		self.curvePlayer:destory()

		self.curvePlayer = nil
	end

	self:resetBackgroundViewLayer()
	StoryBgEffsScreenHalo.super.destroy(self)
end

return StoryBgEffsScreenHalo
