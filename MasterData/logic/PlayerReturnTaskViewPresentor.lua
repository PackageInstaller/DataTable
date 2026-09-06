-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/PlayerReturnTaskViewPresentor.lua

module("logic.extensions.playerreturn.view.PlayerReturnTaskViewPresentor", package.seeall)

local PlayerReturnTaskViewPresentor = class("PlayerReturnTaskViewPresentor", ViewWithGuidePresentor)

function PlayerReturnTaskViewPresentor:ctor()
	PlayerReturnTaskViewPresentor.super.ctor(self)
end

function PlayerReturnTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PlayerReturnTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/playerreturn/playerreturntaskview.prefab"
	}
end

function PlayerReturnTaskViewPresentor:buildViews()
	return {
		PlayerReturnTaskView.New()
	}
end

return PlayerReturnTaskViewPresentor
