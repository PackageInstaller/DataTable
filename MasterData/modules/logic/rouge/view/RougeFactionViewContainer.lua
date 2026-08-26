-- chunkname: @modules/logic/rouge/view/RougeFactionViewContainer.lua

module("modules.logic.rouge.view.RougeFactionViewContainer", package.seeall)

local RougeFactionViewContainer = class("RougeFactionViewContainer", BaseViewContainer)
local kTabContainerId_NavigateButtonsView = 1

function RougeFactionViewContainer:buildViews()
	local listScrollParam = ListScrollParam.New()

	listScrollParam.scrollDir = ScrollEnum.ScrollDirH
	listScrollParam.lineCount = 1
	listScrollParam.cellWidth = 412
	listScrollParam.cellHeight = 852
	listScrollParam.cellSpaceH = 0
	listScrollParam.cellSpaceV = 0
	listScrollParam.startSpace = 109
	self._listScrollParam = listScrollParam
	self._rougeFactionView = RougeFactionView.New()

	return {
		self._rougeFactionView,
		TabViewGroup.New(kTabContainerId_NavigateButtonsView, "#go_lefttop")
	}
end

local kViewhelpId = HelpEnum.HelpId.RougeFactionViewHelp

function RougeFactionViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == kTabContainerId_NavigateButtonsView then
		return {
			NavigateButtonsView.New({
				true,
				false,
				true
			}, kViewhelpId)
		}
	end
end

function RougeFactionViewContainer:getScrollRect()
	return self._rougeFactionView._scrollViewLimitScrollCmp
end

function RougeFactionViewContainer:onContainerInit()
	local scrollRect = self:getScrollRect()

	self._scrollViewGo = scrollRect.gameObject
	self._scrollContentTrans = scrollRect.content
	self._scrollContentGo = self._scrollContentTrans.gameObject
end

function RougeFactionViewContainer:getScrollViewGo()
	return self._scrollViewGo
end

function RougeFactionViewContainer:getScrollContentTranform()
	return self._scrollContentTrans
end

function RougeFactionViewContainer:getScrollContentGo()
	return self._scrollContentGo
end

function RougeFactionViewContainer:getListScrollParam()
	return self._listScrollParam
end

function RougeFactionViewContainer:getListScrollParam_cellSize()
	local listScrollParam = self._listScrollParam

	return listScrollParam.cellWidth, listScrollParam.cellHeight
end

function RougeFactionViewContainer:rebuildLayout()
	ZProj.UGUIHelper.RebuildLayout(self:getScrollContentTranform())
end

function RougeFactionViewContainer:getListScrollParamStep()
	local param = self:getListScrollParam()

	if param.scrollDir == ScrollEnum.ScrollDirH then
		return param.cellWidth + param.cellSpaceH
	else
		return param.cellHeight + param.cellSpaceV
	end
end

return RougeFactionViewContainer
