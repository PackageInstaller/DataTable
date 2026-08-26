-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/titleappoint/view/TitleAppointmentViewContainer.lua

module("modules.logic.versionactivity3_4.laplaceforum.titleappoint.view.TitleAppointmentViewContainer", package.seeall)

local TitleAppointmentViewContainer = class("TitleAppointmentViewContainer", BaseViewContainer)

function TitleAppointmentViewContainer:buildViews()
	local views = {}

	table.insert(views, TitleAppointmentView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function TitleAppointmentViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return TitleAppointmentViewContainer
