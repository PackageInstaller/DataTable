-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/PlayerReturnSignViewPresentor.lua

module("logic.extensions.playerreturn.view.PlayerReturnSignViewPresentor", package.seeall)

local PlayerReturnSignViewPresentor = class("PlayerReturnSignViewPresentor", ViewPresentor)

function PlayerReturnSignViewPresentor:ctor()
	PlayerReturnSignViewPresentor.super.ctor(self)
end

function PlayerReturnSignViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PlayerReturnSignViewPresentor:dependWhatResources()
	return {
		"ui/views/playerreturn/playerreturnsignview.prefab"
	}
end

function PlayerReturnSignViewPresentor:buildViews()
	return {
		PlayerReturnSignView.New()
	}
end

return PlayerReturnSignViewPresentor
