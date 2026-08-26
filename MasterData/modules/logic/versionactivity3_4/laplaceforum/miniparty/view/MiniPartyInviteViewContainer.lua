-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/view/MiniPartyInviteViewContainer.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.view.MiniPartyInviteViewContainer", package.seeall)

local MiniPartyInviteViewContainer = class("MiniPartyInviteViewContainer", BaseViewContainer)

function MiniPartyInviteViewContainer:buildViews()
	local views = {}

	table.insert(views, MiniPartyInviteView.New())
	table.insert(views, MiniPartyInviteCheckView.New())
	table.insert(views, MiniPartyInviteCodeView.New())
	table.insert(views, MiniPartyInviteFriendView.New())

	return views
end

return MiniPartyInviteViewContainer
