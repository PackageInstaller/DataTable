-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraideresourcedescViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasureraideresourcedescViewPresentor", package.seeall)

local TreasureraideresourcedescViewPresentor = class("TreasureraideresourcedescViewPresentor", ViewPresentor)

function TreasureraideresourcedescViewPresentor:ctor()
	TreasureraideresourcedescViewPresentor.super.ctor(self)
end

function TreasureraideresourcedescViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureraideresourcedescViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasureraideresourcedescview.prefab"
	}
end

function TreasureraideresourcedescViewPresentor:buildViews()
	return {
		TreasureraideresourcedescView.New()
	}
end

return TreasureraideresourcedescViewPresentor
