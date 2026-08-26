-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaRecordViewContainer.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaRecordViewContainer", package.seeall)

local AiZiLaRecordViewContainer = class("AiZiLaRecordViewContainer", BaseViewContainer)

function AiZiLaRecordViewContainer:buildViews()
	local views = {}

	self._equipView = AiZiLaRecordView.New()

	table.insert(views, self._equipView)
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function AiZiLaRecordViewContainer:onContainerClickModalMask()
	return
end

function AiZiLaRecordViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

return AiZiLaRecordViewContainer
