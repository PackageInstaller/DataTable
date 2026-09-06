-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraiderrankViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasureraiderrankViewPresentor", package.seeall)

local TreasureraiderrankViewPresentor = class("TreasureraiderrankViewPresentor", ViewPresentor)

function TreasureraiderrankViewPresentor:ctor()
	TreasureraiderrankViewPresentor.super.ctor(self)
end

function TreasureraiderrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureraiderrankViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasureraiderrankview.prefab"
	}
end

function TreasureraiderrankViewPresentor:buildViews()
	return {
		TreasureraiderrankView.New()
	}
end

return TreasureraiderrankViewPresentor
