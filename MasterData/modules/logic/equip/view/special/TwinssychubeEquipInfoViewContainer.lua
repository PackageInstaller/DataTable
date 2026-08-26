-- chunkname: @modules/logic/equip/view/special/TwinssychubeEquipInfoViewContainer.lua

module("modules.logic.equip.view.special.TwinssychubeEquipInfoViewContainer", package.seeall)

local TwinssychubeEquipInfoViewContainer = class("TwinssychubeEquipInfoViewContainer", BaseViewContainer)

function TwinssychubeEquipInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, TwinssychubeEquipInfoView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function TwinssychubeEquipInfoViewContainer:buildTabViews(tabContainerId)
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

return TwinssychubeEquipInfoViewContainer
