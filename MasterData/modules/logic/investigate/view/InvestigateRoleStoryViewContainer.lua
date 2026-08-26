-- chunkname: @modules/logic/investigate/view/InvestigateRoleStoryViewContainer.lua

module("modules.logic.investigate.view.InvestigateRoleStoryViewContainer", package.seeall)

local InvestigateRoleStoryViewContainer = class("InvestigateRoleStoryViewContainer", BaseViewContainer)

function InvestigateRoleStoryViewContainer:buildViews()
	local views = {}

	table.insert(views, InvestigateRoleStoryView.New())

	return views
end

return InvestigateRoleStoryViewContainer
