-- chunkname: @modules/logic/assist/view/AssistRecordViewContainer.lua

module("modules.logic.assist.view.AssistRecordViewContainer", package.seeall)

local AssistRecordViewContainer = class("AssistRecordViewContainer", BaseViewContainer)

function AssistRecordViewContainer:buildViews()
	local views = {}

	table.insert(views, AssistRecordView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AssistRecordViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return AssistRecordViewContainer
