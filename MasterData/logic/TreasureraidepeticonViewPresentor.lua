-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraidepeticonViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasureraidepeticonViewPresentor", package.seeall)

local TreasureraidepeticonViewPresentor = class("TreasureraidepeticonViewPresentor", ViewPresentor)

function TreasureraidepeticonViewPresentor:ctor()
	TreasureraidepeticonViewPresentor.super.ctor(self)
end

function TreasureraidepeticonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureraidepeticonViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasureraidepeticonview.prefab"
	}
end

function TreasureraidepeticonViewPresentor:buildViews()
	return {
		TreasureraidepeticonView.New()
	}
end

return TreasureraidepeticonViewPresentor
