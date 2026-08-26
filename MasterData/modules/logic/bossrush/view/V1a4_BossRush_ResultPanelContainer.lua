-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_ResultPanelContainer.lua

module("modules.logic.bossrush.view.V1a4_BossRush_ResultPanelContainer", package.seeall)

local V1a4_BossRush_ResultPanelContainer = class("V1a4_BossRush_ResultPanelContainer", BaseViewContainer)

function V1a4_BossRush_ResultPanelContainer:buildViews()
	local scrollParam = ListScrollParam.New()
	local scrollModel = V1a4_BossRush_ResultPanelListModel.instance

	scrollParam.cellClass = V1a4_BossRush_ResultPanelItem
	scrollParam.scrollGOPath = "Root/Right/Slider/#go_Slider/#scroll_progress"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "Root/Right/Slider/#go_Slider/#scroll_progress/viewport/content/#go_prefabInst"
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 200
	scrollParam.cellSpaceH = 150
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.endSpace = 150
	self._listScrollParam = scrollParam
	self._scrollView = LuaListScrollView.New(scrollModel, scrollParam)

	return {
		V1a4_BossRush_ResultPanel.New(),
		self._scrollView
	}
end

function V1a4_BossRush_ResultPanelContainer:getListScrollParam()
	return self._listScrollParam
end

function V1a4_BossRush_ResultPanelContainer:getScrollView()
	return self._scrollView
end

function V1a4_BossRush_ResultPanelContainer:getCsListScroll()
	local scrollView = self:getScrollView()

	return (scrollView:getCsListScroll())
end

function V1a4_BossRush_ResultPanelContainer:onContainerCloseFinish()
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
end

return V1a4_BossRush_ResultPanelContainer
