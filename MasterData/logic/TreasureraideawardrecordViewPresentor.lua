-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraideawardrecordViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasureraideawardrecordViewPresentor", package.seeall)

local TreasureraideawardrecordViewPresentor = class("TreasureraideawardrecordViewPresentor", ViewPresentor)

function TreasureraideawardrecordViewPresentor:ctor()
	TreasureraideawardrecordViewPresentor.super.ctor(self)
end

function TreasureraideawardrecordViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureraideawardrecordViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasureraideawardrecordview.prefab"
	}
end

function TreasureraideawardrecordViewPresentor:buildViews()
	return {
		TreasureraideawardrecordView.New()
	}
end

return TreasureraideawardrecordViewPresentor
