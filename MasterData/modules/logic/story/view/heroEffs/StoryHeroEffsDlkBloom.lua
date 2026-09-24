-- chunkname: @modules/logic/story/view/heroEffs/StoryHeroEffsDlkBloom.lua

module("modules.logic.story.view.heroEffs.StoryHeroEffsDlkBloom", package.seeall)

local StoryHeroEffsDlkBloom = class("StoryHeroEffsDlkBloom", StoryHeroEffsBase)

function StoryHeroEffsDlkBloom:init(live2d)
	self._live2d = live2d
	self._cubctrl = self._live2d and self._live2d._cubismController
end

function StoryHeroEffsDlkBloom:start()
	return
end

function StoryHeroEffsDlkBloom:showDLKBloom(bloomVal)
	self.bloomVal = bloomVal or 0.9

	StoryTool.enablePostProcess(true)
	PostProcessingMgr.instance:setUIPPValue("localBloomActive", true)
	TaskDispatcher.runDelay(self.fadeIn, self, 0.2)
	self:_setViewTop(true)
end

function StoryHeroEffsDlkBloom:fadeIn()
	if self.curBloomG == self.bloomVal then
		return
	end

	local cubctrl = self._cubctrl

	if gohelper.isNil(cubctrl) then
		return
	end

	if self._fadeTweenId then
		ZProj.TweenHelper.KillById(self._fadeTweenId)

		self._fadeTweenId = nil
	end

	if not self.curBloomG then
		local startVal = 0

		self._fadeTweenId = ZProj.TweenHelper.DOTweenFloat(startVal, self.bloomVal, 0.6, self.setBloomGVal, self._fadeInFinished, self, nil, EaseType.InOutSine)
	end
end

function StoryHeroEffsDlkBloom:onFadeOut()
	TaskDispatcher.runDelay(self.fadeOut, self, 0.2)
end

function StoryHeroEffsDlkBloom:fadeOut()
	local cubctrl = self._cubctrl

	if gohelper.isNil(cubctrl) then
		return
	end

	if self._fadeTweenId then
		ZProj.TweenHelper.KillById(self._fadeTweenId)

		self._fadeTweenId = nil
	end

	if not self.curBloomG then
		local startVal = 0

		self._fadeTweenId = ZProj.TweenHelper.DOTweenFloat(startVal, 0, 0.65, self.setBloomGVal, self._fadeOutFinished, self, nil, EaseType.Linear)
	end
end

function StoryHeroEffsDlkBloom:setBloomGVal(value)
	local cubctrl = self._cubctrl

	if gohelper.isNil(cubctrl) then
		return
	end

	self.curBloomG = tonumber(value)

	for i = 0, cubctrl.InstancedMaterials.Length - 1 do
		cubctrl.InstancedMaterials[i]:SetFloat("_QuickBloomG", value)
	end
end

function StoryHeroEffsDlkBloom:_fadeInFinished()
	self:setBloomGVal(self.bloomVal)
end

function StoryHeroEffsDlkBloom:_fadeOutFinished()
	self:setBloomGVal(0)
end

function StoryHeroEffsDlkBloom:_setViewTop(set)
	if set then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	else
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	end
end

function StoryHeroEffsDlkBloom:destroy()
	self:_setViewTop(false)

	if self._fadeTweenId then
		ZProj.TweenHelper.KillById(self._fadeTweenId)

		self._fadeTweenId = nil
	end

	TaskDispatcher.cancelTask(self.fadeIn, self)
	TaskDispatcher.cancelTask(self.fadeOut, self)
	StoryHeroEffsDlkBloom.super.destroy(self)
end

return StoryHeroEffsDlkBloom
