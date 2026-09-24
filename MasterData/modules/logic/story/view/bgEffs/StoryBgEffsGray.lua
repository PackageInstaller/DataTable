-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsGray.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsGray", package.seeall)

local StoryBgEffsGray = class("StoryBgEffsGray", StoryBgEffsBase)

function StoryBgEffsGray:ctor()
	StoryBgEffsGray.super.ctor(self)
end

function StoryBgEffsGray:init(bgCo)
	StoryBgEffsGray.super.init(self, bgCo)

	self._prefabPath = ResUrl.getStoryBgEffect("v1a9_saturation")
end

function StoryBgEffsGray:onStartEffect()
	self:_apply()
end

function StoryBgEffsGray:_apply()
	self:_killTween()
	PostProcessingMgr.instance:setUIPPValue("saturation", 0.5)
	PostProcessingMgr.instance:setUIPPValue("Saturation", 0.5)

	if self._bgCo.effDegree == 0 then
		table.insert(self._resList, self._prefabPath)
		self:loadRes()
	else
		if not self._effGo then
			return
		end

		local matPropsCtrl = self._effGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		if not matPropsCtrl then
			return
		end

		StoryTool.enablePostProcess(true)

		if self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			self:_updateValue(0)
		else
			local value = matPropsCtrl.float_01

			self._tweenId = ZProj.TweenHelper.DOTweenFloat(value, 0, self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._updateValue, self._tweenFinished, self)
		end
	end
end

function StoryBgEffsGray:onLoadFinished()
	StoryBgEffsGray.super.onLoadFinished(self)

	local prefAssetItem = self._loader:getAssetItem(self._prefabPath)

	if not prefAssetItem then
		return
	end

	local imagebg = StoryViewMgr.instance:getStoryBgImage()
	local imagebgtop = StoryViewMgr.instance:getStoryBgImageTop()
	local imagebgGo = StoryViewMgr.instance:getStoryFrontBgImgGo()
	local oldBgGo = StoryViewMgr.instance:getStoryOldBgGo()

	if self._effGo and oldBgGo then
		local oldImagebg = StoryViewMgr.instance:getStoryOldBgImage()
		local oldImagebgtop = StoryViewMgr.instance:getStoryOldBgImageTop()

		if oldImagebg and oldImagebgtop then
			self._oldEffGo = self._oldEffGo or gohelper.clone(self._effGo, oldBgGo)

			local oldCtrl = self._oldEffGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

			if oldCtrl then
				oldImagebg.material = oldCtrl.mas[0]
				oldImagebgtop.material = oldCtrl.mas[0]
			end
		end
	end

	if imagebgGo then
		if self._effGo then
			gohelper.destroy(self._effGo)
		end

		self._effGo = gohelper.clone(prefAssetItem:GetResource(), imagebgGo)

		local matPropsCtrl = self._effGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		if matPropsCtrl and imagebg and imagebgtop then
			imagebg.material = matPropsCtrl.mas[0]
			imagebgtop.material = matPropsCtrl.mas[0]

			StoryTool.enablePostProcess(true)

			if self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				self:_updateValue(1)
			else
				self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._updateValue, self._tweenFinished, self)
			end
		end
	end
end

function StoryBgEffsGray:_updateValue(value)
	if not self._effGo then
		return
	end

	local matPropsCtrl = self._effGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	if not matPropsCtrl then
		return
	end

	matPropsCtrl.float_01 = value
end

function StoryBgEffsGray:_tweenFinished()
	self:_killTween()
end

function StoryBgEffsGray:_killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function StoryBgEffsGray:reset(bgCo)
	StoryBgEffsGray.super.reset(self, bgCo)
	self:_apply()
end

function StoryBgEffsGray:destroy()
	self:_killTween()
	self:_updateValue(0)

	if self._oldEffGo then
		gohelper.destroy(self._oldEffGo)

		self._oldEffGo = nil
	end

	if self._effGo then
		gohelper.destroy(self._effGo)

		self._effGo = nil
	end

	StoryBgEffsGray.super.destroy(self)
end

return StoryBgEffsGray
