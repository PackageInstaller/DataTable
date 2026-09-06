-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/PlayerReturnPlgeViewPresentor.lua

module("logic.extensions.playerreturn.view.PlayerReturnPlgeViewPresentor", package.seeall)

local PlayerReturnPlgeViewPresentor = class("PlayerReturnPlgeViewPresentor", ViewPresentor)

function PlayerReturnPlgeViewPresentor:ctor()
	PlayerReturnPlgeViewPresentor.super.ctor(self)
end

function PlayerReturnPlgeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PlayerReturnPlgeViewPresentor:dependWhatResources()
	return {
		"ui/views/playerreturn/playerreturnplgeview.prefab"
	}
end

function PlayerReturnPlgeViewPresentor:buildViews()
	return {
		PlayerReturnPlgeView.New()
	}
end

return PlayerReturnPlgeViewPresentor
