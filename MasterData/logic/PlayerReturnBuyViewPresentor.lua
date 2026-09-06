-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/PlayerReturnBuyViewPresentor.lua

module("logic.extensions.playerreturn.view.PlayerReturnBuyViewPresentor", package.seeall)

local PlayerReturnBuyViewPresentor = class("PlayerReturnBuyViewPresentor", ViewWithGuidePresentor)

function PlayerReturnBuyViewPresentor:ctor()
	PlayerReturnBuyViewPresentor.super.ctor(self)
end

function PlayerReturnBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PlayerReturnBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/playerreturn/playerreturnbuyview.prefab"
	}
end

function PlayerReturnBuyViewPresentor:buildViews()
	return {
		PlayerReturnBuyView.New()
	}
end

return PlayerReturnBuyViewPresentor
