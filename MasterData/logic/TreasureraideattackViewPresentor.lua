-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraideattackViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasureraideattackViewPresentor", package.seeall)

local TreasureraideattackViewPresentor = class("TreasureraideattackViewPresentor", ViewPresentor)

function TreasureraideattackViewPresentor:ctor()
	TreasureraideattackViewPresentor.super.ctor(self)
end

function TreasureraideattackViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureraideattackViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasureraideattackview.prefab"
	}
end

function TreasureraideattackViewPresentor:buildViews()
	return {
		TreasureraideattackView.New()
	}
end

return TreasureraideattackViewPresentor
