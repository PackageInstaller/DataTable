-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasurenew/view/TreasurenewautoViewPresentor.lua

module("logic.extensions.treasurenew.view.TreasurenewautoViewPresentor", package.seeall)

local TreasurenewautoViewPresentor = class("TreasurenewautoViewPresentor", ViewPresentor)

function TreasurenewautoViewPresentor:ctor()
	TreasurenewautoViewPresentor.super.ctor(self)
end

function TreasurenewautoViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function TreasurenewautoViewPresentor:dependWhatResources()
	return {
		"ui/views/treasurenew/treasurenewautoview.prefab"
	}
end

function TreasurenewautoViewPresentor:buildViews()
	return {
		TreasurenewautoView.New()
	}
end

return TreasurenewautoViewPresentor
