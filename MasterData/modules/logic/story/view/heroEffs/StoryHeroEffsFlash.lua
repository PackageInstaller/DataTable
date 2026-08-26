-- chunkname: @modules/logic/story/view/heroEffs/StoryHeroEffsFlash.lua

module("modules.logic.story.view.heroEffs.StoryHeroEffsFlash", package.seeall)

local StoryHeroEffsFlash = class("StoryHeroEffsFlash", StoryHeroEffsBase)

function StoryHeroEffsFlash:ctor()
	StoryHeroEffsFlash.super.ctor(self)
end

function StoryHeroEffsFlash:init(go, prefname)
	StoryHeroEffsFlash.super.init(self)

	self._heroGo = go
	self._lightFlash = gohelper.onceAddComponent(go, typeof(ZProj.RoleLightFlash))
	self._lightFlashPrefPath = string.format("ui/viewres/story/lightparam/%s.prefab", prefname)

	table.insert(self._resList, self._lightFlashPrefPath)
end

function StoryHeroEffsFlash:start(callback, callbackObj)
	StoryHeroEffsFlash.super.start(self)
	self:loadRes()
end

function StoryHeroEffsFlash:onLoadFinished()
	StoryHeroEffsFlash.super.onLoadFinished(self)
	StoryTool.enablePostProcess(true)

	local lightAssetItem = self._loader:getAssetItem(self._lightFlashPrefPath)

	self._copyGo = gohelper.clone(lightAssetItem:GetResource(), self._heroGo.transform.parent.gameObject)

	local targetLightFlash = self._copyGo:GetComponent(typeof(ZProj.RoleLightFlash))

	gohelper.setActive(self._copyGo, false)

	self._lightFlash.fireColor = targetLightFlash.fireColor
	self._lightFlash.minBrightness = targetLightFlash.minBrightness
	self._lightFlash.maxBrightness = targetLightFlash.maxBrightness
	self._lightFlash.minInterval = targetLightFlash.minInterval
	self._lightFlash.maxInterval = targetLightFlash.maxInterval
	self._lightFlash.minTransitionDuration = targetLightFlash.minTransitionDuration
	self._lightFlash.maxTransitionDuration = targetLightFlash.maxTransitionDuration
	self._lightFlash.transitionCurve = targetLightFlash.transitionCurve
end

function StoryHeroEffsFlash:destroy()
	gohelper.removeComponent(self._heroGo, typeof(ZProj.RoleLightFlash))

	if self._copyGo then
		gohelper.destroy(self._copyGo)

		self._copyGo = nil
	end

	StoryHeroEffsFlash.super.destroy(self)
end

return StoryHeroEffsFlash
