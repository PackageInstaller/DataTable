-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/view/LsqOrdealLevelViewPresentor.lua

module("logic.extensions.luoshiqiordeal.view.LsqOrdealLevelViewPresentor", package.seeall)

local LsqOrdealLevelViewPresentor = class("LsqOrdealLevelViewPresentor", ViewPresentor)

function LsqOrdealLevelViewPresentor:ctor()
	LsqOrdealLevelViewPresentor.super.ctor(self)
end

function LsqOrdealLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LsqOrdealLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/luoshiqiordeal/lsqordeallevelview.prefab"
	}
end

function LsqOrdealLevelViewPresentor:buildViews()
	return {
		LsqOrdealLevelView.New()
	}
end

return LsqOrdealLevelViewPresentor
