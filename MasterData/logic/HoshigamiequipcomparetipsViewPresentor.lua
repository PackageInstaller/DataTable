-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamiequipcomparetipsViewPresentor.lua

module("logic.extensions.hoshigami.view.HoshigamiequipcomparetipsViewPresentor", package.seeall)

local HoshigamiequipcomparetipsViewPresentor = class("HoshigamiequipcomparetipsViewPresentor", ViewPresentor)

function HoshigamiequipcomparetipsViewPresentor:ctor()
	HoshigamiequipcomparetipsViewPresentor.super.ctor(self)
end

function HoshigamiequipcomparetipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HoshigamiequipcomparetipsViewPresentor:dependWhatResources()
	return {
		"ui/views/hoshigami/hoshigamiequiptips.prefab"
	}
end

function HoshigamiequipcomparetipsViewPresentor:buildViews()
	return {
		HoshigamiequipcomparetipsView.New()
	}
end

function HoshigamiequipcomparetipsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HoshigamiequipcomparetipsViewPresentor
