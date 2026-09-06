-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originxiuer/view/OriginXiuErLevelViewPresentor.lua

module("logic.extensions.originxiuer.view.OriginXiuErLevelViewPresentor", package.seeall)

local OriginXiuErLevelViewPresentor = class("OriginXiuErLevelViewPresentor", ViewPresentor)

function OriginXiuErLevelViewPresentor:ctor()
	OriginXiuErLevelViewPresentor.super.ctor(self)
end

function OriginXiuErLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginXiuErLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/originxiuer/originxiuerlevelview.prefab"
	}
end

function OriginXiuErLevelViewPresentor:buildViews()
	return {
		OriginXiuErLevelView.New()
	}
end

return OriginXiuErLevelViewPresentor
