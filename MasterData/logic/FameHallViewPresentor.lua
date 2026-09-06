-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/view/FameHallViewPresentor.lua

module("logic.extensions.famehall.view.FameHallViewPresentor", package.seeall)

local FameHallViewPresentor = class("FameHallViewPresentor", ViewPresentor)

function FameHallViewPresentor:ctor()
	FameHallViewPresentor.super.ctor(self)
end

function FameHallViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FameHallViewPresentor:dependWhatResources()
	return {
		"ui/views/famehall/famehallview.prefab"
	}
end

function FameHallViewPresentor:buildViews()
	return {
		FameHallView.New()
	}
end

return FameHallViewPresentor
