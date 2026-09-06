-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraideattackrecordViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasureraideattackrecordViewPresentor", package.seeall)

local TreasureraideattackrecordViewPresentor = class("TreasureraideattackrecordViewPresentor", ViewPresentor)

function TreasureraideattackrecordViewPresentor:ctor()
	TreasureraideattackrecordViewPresentor.super.ctor(self)
end

function TreasureraideattackrecordViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureraideattackrecordViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasureraideattackrecordview.prefab"
	}
end

function TreasureraideattackrecordViewPresentor:buildViews()
	return {
		TreasureraideattackrecordView.New()
	}
end

return TreasureraideattackrecordViewPresentor
