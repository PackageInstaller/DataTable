-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originduolagame/view/OriginDuoLaGameClgViewPresentor.lua

module("logic.extensions.originduolagame.view.OriginDuoLaGameClgViewPresentor", package.seeall)

local OriginDuoLaGameClgViewPresentor = class("OriginDuoLaGameClgViewPresentor", ViewPresentor)

function OriginDuoLaGameClgViewPresentor:ctor()
	OriginDuoLaGameClgViewPresentor.super.ctor(self)
end

function OriginDuoLaGameClgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDuoLaGameClgViewPresentor:dependWhatResources()
	return {
		"ui/views/originduolagame/originduolagameclgview.prefab"
	}
end

function OriginDuoLaGameClgViewPresentor:buildViews()
	return {
		OriginDuoLaGameClgView.New()
	}
end

return OriginDuoLaGameClgViewPresentor
