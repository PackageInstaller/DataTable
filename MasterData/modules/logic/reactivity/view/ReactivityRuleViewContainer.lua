-- chunkname: @modules/logic/reactivity/view/ReactivityRuleViewContainer.lua

module("modules.logic.reactivity.view.ReactivityRuleViewContainer", package.seeall)

local ReactivityRuleViewContainer = class("ReactivityRuleViewContainer", BaseViewContainer)

function ReactivityRuleViewContainer:buildViews()
	local views = {}
	local listParam = ListScrollParam.New()

	listParam.scrollGOPath = "object/#scroll_rule"
	listParam.prefabType = ScrollEnum.ScrollPrefabFromView
	listParam.prefabUrl = "object/#scroll_rule/Viewport/Content/#ruleitem"
	listParam.cellClass = ReactivityRuleItem
	listParam.scrollDir = ScrollEnum.ScrollDirV
	listParam.lineCount = 3
	listParam.cellWidth = 490
	listParam.cellHeight = 172
	listParam.cellSpaceH = 0
	listParam.cellSpaceV = 0
	listParam.startSpace = 10

	table.insert(views, LuaListScrollView.New(ReactivityRuleModel.instance, listParam))
	table.insert(views, ReactivityRuleView.New())

	return views
end

function ReactivityRuleViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return ReactivityRuleViewContainer
