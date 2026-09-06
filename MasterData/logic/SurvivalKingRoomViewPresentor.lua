-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingRoomViewPresentor.lua

module("logic.extensions.survivalking.view.SurvivalKingRoomViewPresentor", package.seeall)

local SurvivalKingRoomViewPresentor = class("SurvivalKingRoomViewPresentor", ViewPresentor)

function SurvivalKingRoomViewPresentor:ctor()
	SurvivalKingRoomViewPresentor.super.ctor(self)
end

function SurvivalKingRoomViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SurvivalKingRoomViewPresentor:dependWhatResources()
	return {
		"ui/views/survivalking/survivalkingroomview.prefab"
	}
end

function SurvivalKingRoomViewPresentor:buildViews()
	return {
		SurvivalKingRoomView.New()
	}
end

return SurvivalKingRoomViewPresentor
