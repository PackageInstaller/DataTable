-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/PlayerReturnShopViewPresentor.lua

module("logic.extensions.sevendays.view.PlayerReturnShopViewPresentor", package.seeall)

local PlayerReturnShopViewPresentor = class("PlayerReturnShopViewPresentor", ViewWithGuidePresentor)

function PlayerReturnShopViewPresentor:ctor()
	PlayerReturnShopViewPresentor.super.ctor(self)
end

function PlayerReturnShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PlayerReturnShopViewPresentor:dependWhatResources()
	return {
		"ui/views/playerreturn/playerreturnshopview.prefab"
	}
end

function PlayerReturnShopViewPresentor:buildViews()
	return {
		PlayerReturnShopView.New()
	}
end

return PlayerReturnShopViewPresentor
