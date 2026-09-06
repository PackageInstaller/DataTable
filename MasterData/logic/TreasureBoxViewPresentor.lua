-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/TreasureBoxViewPresentor.lua

module("logic.extensions.sevendays.view.TreasureBoxViewPresentor", package.seeall)

local TreasureBoxViewPresentor = class("TreasureBoxViewPresentor", ViewWithGuidePresentor)

function TreasureBoxViewPresentor:ctor()
	TreasureBoxViewPresentor.super.ctor(self)
end

function TreasureBoxViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureBoxViewPresentor:dependWhatResources()
	return {
		"ui/views/sevendays/treasureboxview.prefab"
	}
end

function TreasureBoxViewPresentor:buildViews()
	return {
		TreasureBoxView.New()
	}
end

return TreasureBoxViewPresentor
