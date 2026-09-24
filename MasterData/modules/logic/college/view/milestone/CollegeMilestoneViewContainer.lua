-- chunkname: @modules/logic/college/view/milestone/CollegeMilestoneViewContainer.lua

module("modules.logic.college.view.milestone.CollegeMilestoneViewContainer", package.seeall)

local CollegeMilestoneViewContainer = class("CollegeMilestoneViewContainer", BaseViewContainer)

function CollegeMilestoneViewContainer:buildViews()
	local listScrollParam = ListScrollParam.New()

	listScrollParam.scrollDir = ScrollEnum.ScrollDirH
	listScrollParam.lineCount = 1
	listScrollParam.cellWidth = 517
	listScrollParam.cellHeight = 856
	listScrollParam.cellSpaceH = 36
	listScrollParam.cellSpaceV = 0
	self._listScrollParam = listScrollParam
	self._milestoneView = CollegeMilestoneView.New()

	return {
		self._milestoneView,
		CollegeMilestoneRewardView.New(),
		CollegeMilestoneDetailView.New(),
		CollegeVisibleBaseView.New(),
		CollegeCurrencyView.New("#go_topright", {
			CollegeEnum.ItemType.Story
		}),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function CollegeMilestoneViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigationView
		}
	end
end

function CollegeMilestoneViewContainer:getScrollRect()
	return self._milestoneView._scrollViewLimitScrollCmp
end

function CollegeMilestoneViewContainer:onContainerInit()
	local scrollRect = self:getScrollRect()

	self._scrollViewGo = scrollRect.gameObject
	self._scrollContentTrans = scrollRect.content
	self._scrollContentGo = self._scrollContentTrans.gameObject

	local themeList = CollegeModel.instance:getSceneMo().milestoneBox.themes

	self._themeList = tabletool.copy(themeList)

	table.sort(self._themeList, function(a, b)
		return a.id < b.id
	end)
end

function CollegeMilestoneViewContainer:getScrollViewGo()
	return self._scrollViewGo
end

function CollegeMilestoneViewContainer:getScrollContentTranform()
	return self._scrollContentTrans
end

function CollegeMilestoneViewContainer:getScrollContentGo()
	return self._scrollContentGo
end

function CollegeMilestoneViewContainer:getListScrollParam()
	return self._listScrollParam
end

function CollegeMilestoneViewContainer:getListScrollParam_cellSize()
	local listScrollParam = self._listScrollParam

	return listScrollParam.cellWidth, listScrollParam.cellHeight
end

function CollegeMilestoneViewContainer:getListScrollParamStep()
	local param = self:getListScrollParam()

	if param.scrollDir == ScrollEnum.ScrollDirH then
		return param.cellWidth + param.cellSpaceH
	else
		return param.cellHeight + param.cellSpaceV
	end
end

function CollegeMilestoneViewContainer:rebuildLayout()
	ZProj.UGUIHelper.RebuildLayout(self:getScrollContentTranform())
end

function CollegeMilestoneViewContainer:getThemeList()
	return self._themeList
end

return CollegeMilestoneViewContainer
