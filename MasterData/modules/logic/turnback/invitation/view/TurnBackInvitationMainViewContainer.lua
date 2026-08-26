-- chunkname: @modules/logic/turnback/invitation/view/TurnBackInvitationMainViewContainer.lua

module("modules.logic.turnback.invitation.view.TurnBackInvitationMainViewContainer", package.seeall)

local TurnBackInvitationMainViewContainer = class("TurnBackInvitationMainViewContainer", BaseViewContainer)

function TurnBackInvitationMainViewContainer:buildViews()
	local views = {}

	table.insert(views, TurnBackInvitationMainView.New())

	return views
end

return TurnBackInvitationMainViewContainer
