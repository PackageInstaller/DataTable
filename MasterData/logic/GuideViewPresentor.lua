-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideViewPresentor.lua

module("logic.extensions.guide.view.GuideViewPresentor", package.seeall)

local GuideViewPresentor = class("GuideViewPresentor", ViewPresentor)

function GuideViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function GuideViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function GuideViewPresentor:loadViewResources()
	if not self._isLoadingRes then
		self._isLoadingRes = true

		GuideViewPresentor.super.loadViewResources(self)
	end
end

function GuideViewPresentor:destroy()
	self._isLoadingRes = nil

	GuideViewPresentor.super.destroy(self)
end

function GuideViewPresentor:_onViewResourcesLoaded(loader)
	self._isLoadingRes = nil

	GuideViewPresentor.super._onViewResourcesLoaded(self, loader)
end

return GuideViewPresentor
