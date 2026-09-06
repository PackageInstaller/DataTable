-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/PlayerReturnLetterViewPresentor.lua

module("logic.extensions.playerreturn.view.PlayerReturnLetterViewPresentor", package.seeall)

local PlayerReturnLetterViewPresentor = class("PlayerReturnLetterViewPresentor", ViewPresentor)

function PlayerReturnLetterViewPresentor:ctor()
	PlayerReturnLetterViewPresentor.super.ctor(self)
end

function PlayerReturnLetterViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PlayerReturnLetterViewPresentor:dependWhatResources()
	return {
		"ui/views/playerreturn/playerreturnletterview.prefab",
		"effect/prefabs/ui/fx_ui_30tianhuigui/spine/fx_ui_xingfeng.prefab"
	}
end

function PlayerReturnLetterViewPresentor:buildViews()
	return {
		PlayerReturnLetterView.New()
	}
end

return PlayerReturnLetterViewPresentor
