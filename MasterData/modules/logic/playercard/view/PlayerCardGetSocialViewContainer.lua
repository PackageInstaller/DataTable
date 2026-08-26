-- chunkname: @modules/logic/playercard/view/PlayerCardGetSocialViewContainer.lua

module("modules.logic.playercard.view.PlayerCardGetSocialViewContainer", package.seeall)

local PlayerCardGetSocialViewContainer = class("PlayerCardGetSocialViewContainer", SocialViewContainer)

function PlayerCardGetSocialViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerCardGetSocialView.New())
	table.insert(views, TabViewGroup.New(2, "container/tabviews"))

	return views
end

return PlayerCardGetSocialViewContainer
