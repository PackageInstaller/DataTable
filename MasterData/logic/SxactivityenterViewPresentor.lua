-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/SxactivityenterViewPresentor.lua

module("logic.extensions.sxgame.view.SxactivityenterViewPresentor", package.seeall)

local SxactivityenterViewPresentor = class("SxactivityenterViewPresentor", ViewPresentor)

function SxactivityenterViewPresentor:ctor()
	SxactivityenterViewPresentor.super.ctor(self)
end

function SxactivityenterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SxactivityenterViewPresentor:dependWhatResources()
	return {
		"ui/views/sxgame/sxactivityenterview.prefab"
	}
end

function SxactivityenterViewPresentor:buildViews()
	return {
		SxactivityenterView.New()
	}
end

return SxactivityenterViewPresentor
