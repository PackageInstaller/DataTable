-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsBgDistress.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsBgDistress", package.seeall)

local StoryBgEffsBgDistress = class("StoryBgEffsBgDistress", StoryBgEffsBase)

function StoryBgEffsBgDistress:ctor()
	StoryBgEffsBgDistress.super.ctor(self)
end

function StoryBgEffsBgDistress:init(bgCo)
	StoryBgEffsBgDistress.super.init(self, bgCo)

	self._distressPrefabPath = "ui/viewres/story/bg/storybg_vignette.prefab"

	table.insert(self._resList, self._distressPrefabPath)

	self._effLoaded = false
end

function StoryBgEffsBgDistress:start(callback, callbackObj)
	StoryBgEffsBgDistress.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:loadRes()
end

local distressEffDegree = {
	0,
	0.6,
	0.8,
	1
}

function StoryBgEffsBgDistress:onLoadFinished()
	StoryBgEffsBgDistress.super.onLoadFinished(self)

	self._effLoaded = true

	StoryTool.enablePostProcess(true)

	local frontGo = StoryViewMgr.instance:getStoryFrontBgGo()
	local prefAssetItem = self._loader:getAssetItem(self._distressPrefabPath)

	self._distressGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

	gohelper.setAsFirstSibling(self._distressGo)

	self._img = self._distressGo:GetComponent(gohelper.Type_Image)
	self._imgBg = gohelper.findChildImage(frontGo, "#simage_bgimg")
	self._imgBg.material = self._img.material

	self:_setDistressUpdate(0)
	self:_killTween()

	if self._bgCo.effDegree < 1 then
		return
	end

	local endValue = distressEffDegree[self._bgCo.effDegree + 1]
	local transTime = self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	self._distressTweenId = ZProj.TweenHelper.DOTweenFloat(0, endValue, transTime, self._setDistressUpdate, self._onBgEffDistressFinished, self)
end

function StoryBgEffsBgDistress:reset(bgCo)
	StoryBgEffsBgDistress.super.reset(self, bgCo)
	self:_killTween()

	if not self._effLoaded then
		return
	end

	local startValue = self._img.material:GetFloat("_TotalFator")
	local endValue = distressEffDegree[bgCo.effDegree + 1]
	local transTime = self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	self._distressTweenId = ZProj.TweenHelper.DOTweenFloat(startValue, endValue, transTime, self._setDistressUpdate, self._onBgEffDistressFinished, self)
end

function StoryBgEffsBgDistress:_setDistressUpdate(value)
	if not self._img or not self._img.material then
		return
	end

	self._img.material:SetFloat("_TotalFator", value)
	self._imgBg.material:SetFloat("_TotalFator", value)
end

function StoryBgEffsBgDistress:_onBgEffDistressFinished()
	self:_killTween()

	local value = self._img.material:GetFloat("_TotalFator")

	if value <= 0.05 and self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)

		self._finishedCallback = nil
		self._finishedCallbackObj = nil
	end
end

function StoryBgEffsBgDistress:_killTween()
	if self._distressTweenId then
		ZProj.TweenHelper.KillById(self._distressTweenId)

		self._distressTweenId = nil
	end
end

function StoryBgEffsBgDistress:destroy()
	StoryBgEffsBgDistress.super.destroy(self)

	if self._distressGo then
		gohelper.destroy(self._distressGo)

		self._distressGo = nil
	end

	self:_setDistressUpdate(0)
	self:_killTween()

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

return StoryBgEffsBgDistress
