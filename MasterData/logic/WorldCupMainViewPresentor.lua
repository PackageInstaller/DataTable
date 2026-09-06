-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupMainViewPresentor.lua

module("logic.extensions.worldcup.view.WorldCupMainViewPresentor", package.seeall)

local WorldCupMainViewPresentor = class("WorldCupMainViewPresentor", ViewPresentor)

function WorldCupMainViewPresentor:ctor()
	WorldCupMainViewPresentor.super.ctor(self)
end

function WorldCupMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WorldCupMainViewPresentor:dependWhatResources()
	return {
		"ui/views/worldcup/worldcupmainview.prefab"
	}
end

function WorldCupMainViewPresentor:buildViews()
	return {
		WorldCupMainView.New()
	}
end

return WorldCupMainViewPresentor
