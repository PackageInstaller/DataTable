-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/TreasureBuyViewPresentor.lua

module("logic.extensions.sevendays.view.TreasureBuyViewPresentor", package.seeall)

local TreasureBuyViewPresentor = class("TreasureBuyViewPresentor", ViewWithGuidePresentor)

function TreasureBuyViewPresentor:ctor()
	TreasureBuyViewPresentor.super.ctor(self)
end

function TreasureBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TreasureBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/sevendays/treasurebuyview.prefab"
	}
end

function TreasureBuyViewPresentor:buildViews()
	return {
		TreasureBuyView.New()
	}
end

return TreasureBuyViewPresentor
