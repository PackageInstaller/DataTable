-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/PlayerReturnViewPresentor.lua

module("logic.extensions.playerreturn.view.PlayerReturnViewPresentor", package.seeall)

local PlayerReturnViewPresentor = class("PlayerReturnViewPresentor", ViewPresentor)

function PlayerReturnViewPresentor:ctor()
	PlayerReturnViewPresentor.super.ctor(self)
end

function PlayerReturnViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PlayerReturnViewPresentor:dependWhatResources()
	return {
		"ui/views/playerreturn/playerreturnview.prefab"
	}
end

function PlayerReturnViewPresentor:buildViews()
	return {
		PlayerReturnView.New()
	}
end

return PlayerReturnViewPresentor
