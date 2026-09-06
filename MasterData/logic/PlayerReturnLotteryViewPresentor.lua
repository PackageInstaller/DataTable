-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/PlayerReturnLotteryViewPresentor.lua

module("logic.extensions.playerreturn.view.PlayerReturnLotteryViewPresentor", package.seeall)

local PlayerReturnLotteryViewPresentor = class("PlayerReturnLotteryViewPresentor", ViewPresentor)

function PlayerReturnLotteryViewPresentor:ctor()
	PlayerReturnLotteryViewPresentor.super.ctor(self)
end

function PlayerReturnLotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PlayerReturnLotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/playerreturn/playerreturnlotteryview.prefab"
	}
end

function PlayerReturnLotteryViewPresentor:buildViews()
	return {
		PlayerReturnLotteryView.New()
	}
end

return PlayerReturnLotteryViewPresentor
