-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamieprefabquipcomparetipsViewPresentor.lua

module("logic.extensions.hoshigami.view.HoshigamieprefabquipcomparetipsViewPresentor", package.seeall)

local HoshigamieprefabquipcomparetipsViewPresentor = class("HoshigamieprefabquipcomparetipsViewPresentor", ViewPresentor)

function HoshigamieprefabquipcomparetipsViewPresentor:ctor()
	HoshigamieprefabquipcomparetipsViewPresentor.super.ctor(self)
end

function HoshigamieprefabquipcomparetipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HoshigamieprefabquipcomparetipsViewPresentor:dependWhatResources()
	return {
		"ui/views/hoshigami/hoshigamiequiptips.prefab"
	}
end

function HoshigamieprefabquipcomparetipsViewPresentor:buildViews()
	return {
		HoshigamieprefabquipcomparetipsView.New()
	}
end

function HoshigamieprefabquipcomparetipsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HoshigamieprefabquipcomparetipsViewPresentor
