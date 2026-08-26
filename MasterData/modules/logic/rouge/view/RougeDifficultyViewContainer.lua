-- chunkname: @modules/logic/rouge/view/RougeDifficultyViewContainer.lua

module("modules.logic.rouge.view.RougeDifficultyViewContainer", package.seeall)

local RougeDifficultyViewContainer = class("RougeDifficultyViewContainer", BaseViewContainer)
local kTabContainerId_NavigateButtonsView = 1

function RougeDifficultyViewContainer:buildViews()
	local listScrollParam = ListScrollParam.New()

	listScrollParam.scrollDir = ScrollEnum.ScrollDirH
	listScrollParam.lineCount = 1
	listScrollParam.cellWidth = 480
	listScrollParam.cellHeight = 980
	listScrollParam.cellSpaceH = 36
	listScrollParam.cellSpaceV = 0
	self._listScrollParam = listScrollParam
	self._difficultyView = RougeDifficultyView.New()

	return {
		self._difficultyView,
		TabViewGroup.New(kTabContainerId_NavigateButtonsView, "#go_lefttop")
	}
end

local kViewhelpId = HelpEnum.HelpId.RougeDifficultyViewHelp

function RougeDifficultyViewContainer:buildTabViews(tabContainerId)
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

function RougeDifficultyViewContainer:getScrollRect()
	return self._difficultyView._scrollViewLimitScrollCmp
end

function RougeDifficultyViewContainer:onContainerInit()
	local scrollRect = self:getScrollRect()

	self._scrollViewGo = scrollRect.gameObject
	self._scrollContentTrans = scrollRect.content
	self._scrollContentGo = self._scrollContentTrans.gameObject
end

function RougeDifficultyViewContainer:getScrollViewGo()
	return self._scrollViewGo
end

function RougeDifficultyViewContainer:getScrollContentTranform()
	return self._scrollContentTrans
end

function RougeDifficultyViewContainer:getScrollContentGo()
	return self._scrollContentGo
end

function RougeDifficultyViewContainer:getListScrollParam()
	return self._listScrollParam
end

function RougeDifficultyViewContainer:getListScrollParam_cellSize()
	local listScrollParam = self._listScrollParam

	return listScrollParam.cellWidth, listScrollParam.cellHeight
end

function RougeDifficultyViewContainer:getListScrollParamStep()
	local param = self:getListScrollParam()

	if param.scrollDir == ScrollEnum.ScrollDirH then
		return param.cellWidth + param.cellSpaceH
	else
		return param.cellHeight + param.cellSpaceV
	end
end

function RougeDifficultyViewContainer:rebuildLayout()
	ZProj.UGUIHelper.RebuildLayout(self:getScrollContentTranform())
end

function RougeDifficultyViewContainer:getSumDescIndexList(...)
	return self._difficultyView:getSumDescIndexList(...)
end

return RougeDifficultyViewContainer
