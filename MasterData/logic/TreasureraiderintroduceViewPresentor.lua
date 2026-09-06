-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraiderintroduceViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasureraiderintroduceViewPresentor", package.seeall)

local TreasureraiderintroduceViewPresentor = class("TreasureraiderintroduceViewPresentor", ViewPresentor)

function TreasureraiderintroduceViewPresentor:ctor()
	TreasureraiderintroduceViewPresentor.super.ctor(self)
end

function TreasureraiderintroduceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureraiderintroduceViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasureraiderintroduceview.prefab"
	}
end

function TreasureraiderintroduceViewPresentor:buildViews()
	return {
		TreasureraiderintroduceView.New()
	}
end

return TreasureraiderintroduceViewPresentor
