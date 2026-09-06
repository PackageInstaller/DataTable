-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattleshopViewPresentor.lua

module("logic.extensions.glorybattle.view.GlorybattleshopViewPresentor", package.seeall)

local GlorybattleshopViewPresentor = class("GlorybattleshopViewPresentor", ViewPresentor)

function GlorybattleshopViewPresentor:ctor()
	GlorybattleshopViewPresentor.super.ctor(self)
end

function GlorybattleshopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GlorybattleshopViewPresentor:dependWhatResources()
	return {
		"ui/views/glorybattle/glorybattleshopview.prefab"
	}
end

function GlorybattleshopViewPresentor:buildViews()
	return {
		GlorybattleshopView.New()
	}
end

return GlorybattleshopViewPresentor
