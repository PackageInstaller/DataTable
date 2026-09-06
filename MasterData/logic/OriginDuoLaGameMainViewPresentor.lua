-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originduolagame/view/OriginDuoLaGameMainViewPresentor.lua

module("logic.extensions.originduolagame.view.OriginDuoLaGameMainViewPresentor", package.seeall)

local OriginDuoLaGameMainViewPresentor = class("OriginDuoLaGameMainViewPresentor", ViewPresentor)

function OriginDuoLaGameMainViewPresentor:ctor()
	OriginDuoLaGameMainViewPresentor.super.ctor(self)
end

function OriginDuoLaGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDuoLaGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originduolagame/originduolagamemainview.prefab"
	}
end

function OriginDuoLaGameMainViewPresentor:buildViews()
	return {
		OriginDuoLaGameMainView.New()
	}
end

return OriginDuoLaGameMainViewPresentor
