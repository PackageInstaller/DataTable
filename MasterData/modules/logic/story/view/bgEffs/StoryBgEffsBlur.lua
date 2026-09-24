-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsBlur.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsBlur", package.seeall)

local StoryBgEffsBlur = class("StoryBgEffsBlur", StoryBgEffsBase)
local BLUR_MAT_PATH = "ui/materials/dynamic/uibackgoundblur.mat"
local BLUR_ZONE_MAT_PATH = "ui/materials/dynamic/uibackgoundblur_zone.mat"

function StoryBgEffsBlur:ctor()
	StoryBgEffsBlur.super.ctor(self)
end

function StoryBgEffsBlur:init(bgCo)
	StoryBgEffsBlur.super.init(self, bgCo)
	table.insert(self._resList, BLUR_MAT_PATH)
	table.insert(self._resList, BLUR_ZONE_MAT_PATH)
end

function StoryBgEffsBlur:onLoadFinished()
	StoryBgEffsBlur.super.onLoadFinished(self)
	StoryTool.enablePostProcess(true)
	PostProcessingMgr.instance:setUIBlurActive(0)
	PostProcessingMgr.instance:setFreezeVisble(false)

	local blurItem = self._loader:getAssetItem(BLUR_MAT_PATH)
	local blurZoneItem = self._loader:getAssetItem(BLUR_ZONE_MAT_PATH)

	self._blurMat = blurItem and blurItem:GetResource(BLUR_MAT_PATH) or nil
	self._blurZoneMat = blurZoneItem and blurZoneItem:GetResource(BLUR_ZONE_MAT_PATH) or nil

	local imagebg = StoryViewMgr.instance:getStoryBgImage()
	local imagebgtop = StoryViewMgr.instance:getStoryBgImageTop()

	if imagebg and self._blurMat then
		imagebg.material = self._blurMat
	end

	if imagebgtop and self._blurZoneMat then
		imagebgtop.material = self._blurZoneMat
	end

	local bgBlur = StoryViewMgr.instance:getStoryBgBlurComp()

	if bgBlur then
		if not bgBlur.enabled then
			bgBlur.enabled = true
			bgBlur.blurWeight = 0
		end

		local values = {
			0,
			0.8,
			0.9,
			1,
			0.6
		}
		local index = self._bgCo.effDegree + 1

		if not values[index] then
			local targetValue = 0

			if index == 5 then
				bgBlur.blurFactor = 1
				bgBlur.blurIterations = 2
				bgBlur.reduteRate = 2
			elseif targetValue > 0 then
				bgBlur.blurFactor = 0
				bgBlur.blurIterations = 3
				bgBlur.reduteRate = 8
			end

			local transTime = self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

			if transTime > 0.1 then
				self._tweenId = ZProj.TweenHelper.DOTweenFloat(bgBlur.blurWeight, targetValue, transTime, self._tweenUpdate, self._tweenFinished, self, nil, EaseType.Linear)
			else
				self:_tweenUpdate(targetValue)
			end
		end
	end
end

function StoryBgEffsBlur:_tweenUpdate(value)
	local bgBlur = StoryViewMgr.instance:getStoryBgBlurComp()

	if not bgBlur then
		self:_tweenFinished()

		return
	end

	bgBlur.blurWeight = value
end

function StoryBgEffsBlur:_tweenFinished()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function StoryBgEffsBlur:reset(bgCo)
	StoryBgEffsBlur.super.reset(self, bgCo)
	self:_killTween()
	self:onLoadFinished()
end

function StoryBgEffsBlur:_killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function StoryBgEffsBlur:destroy()
	self:_killTween()

	local bgBlur = StoryViewMgr.instance:getStoryBgBlurComp()

	if bgBlur then
		bgBlur.blurWeight = 0
		bgBlur.enabled = false
		bgBlur.zoneImage = nil
	end

	local blurGo = StoryViewMgr.instance:getStoryBgBlurGo()

	if blurGo then
		gohelper.setActive(blurGo, false)
	end

	local customImg = StoryViewMgr.instance:getStoryBgCustomImage()

	if customImg then
		customImg.vecInSide = Vector4.zero
	end

	local imagebg = StoryViewMgr.instance:getStoryBgImage()

	if imagebg and self._blurMat and imagebg.material == self._blurMat then
		imagebg.material = nil
	end

	local imagebgtop = StoryViewMgr.instance:getStoryBgImageTop()

	if imagebgtop and self._blurZoneMat and imagebgtop.material == self._blurZoneMat then
		imagebgtop.material = nil
	end

	self._blurMat = nil
	self._blurZoneMat = nil

	StoryBgEffsBlur.super.destroy(self)
end

return StoryBgEffsBlur
