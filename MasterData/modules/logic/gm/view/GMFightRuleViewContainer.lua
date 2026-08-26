-- chunkname: @modules/logic/gm/view/GMFightRuleViewContainer.lua

module("modules.logic.gm.view.GMFightRuleViewContainer", package.seeall)

local GMFightRuleViewContainer = class("GMFightRuleViewContainer", BaseViewContainer)

function GMFightRuleViewContainer:buildViews()
	local views = {}

	table.insert(views, GMFightRuleView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function GMFightRuleViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return GMFightRuleViewContainer
