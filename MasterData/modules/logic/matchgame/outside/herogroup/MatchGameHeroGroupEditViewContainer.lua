-- chunkname: @modules/logic/matchgame/outside/herogroup/MatchGameHeroGroupEditViewContainer.lua

module("modules.logic.matchgame.outside.herogroup.MatchGameHeroGroupEditViewContainer", package.seeall)

local MatchGameHeroGroupEditViewContainer = class("MatchGameHeroGroupEditViewContainer", BaseViewContainer)
local DefaultLineCount = 4

function MatchGameHeroGroupEditViewContainer:buildViews()
	self._curLineCount = DefaultLineCount

	local heroScrollParam = ListScrollParam.New()

	heroScrollParam.cellClass = MatchGameHeroEditCardItem
	heroScrollParam.scrollGOPath = "#go_rolecontainer/#go_scrollarea/#scroll_card"
	heroScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	heroScrollParam.prefabUrl = MatchGameEnum.CommonHeroCardItemPrefabPath
	heroScrollParam.scrollDir = ScrollEnum.ScrollDirV
	heroScrollParam.lineCount = self._curLineCount
	heroScrollParam.cellWidth = 240
	heroScrollParam.cellHeight = 560
	heroScrollParam.cellSpaceH = 0
	heroScrollParam.cellSpaceV = 0
	self._heroScrollView = LuaListScrollView.New(MatchGameHeroGroupEditListModel.instance, heroScrollParam)

	return {
		MatchGameHeroGroupEditView.New(),
		MatchGameCurrencyView.New("#go_righttop"),
		self._heroScrollView,
		TabViewGroup.New(1, "#go_btns")
	}
end

function MatchGameHeroGroupEditViewContainer:getScrollView()
	return self._heroScrollView
end

function MatchGameHeroGroupEditViewContainer:buildTabViews(tabContainerId)
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

function MatchGameHeroGroupEditViewContainer:onContainerInit()
	self._goScrollArea = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_scrollarea")
	self._tranScrollArea = self._goScrollArea.transform
	self._csListScroll = self._heroScrollView:getCsListScroll()

	self:checkUpdateScrollLineCount()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function MatchGameHeroGroupEditViewContainer:_onScreenSizeChange()
	self:checkUpdateScrollLineCount()
end

function MatchGameHeroGroupEditViewContainer:checkUpdateScrollLineCount()
	local newLineCount = self:calcLineCount()

	if newLineCount == self._curLineCount then
		return
	end

	self._curLineCount = newLineCount

	local scrollParam = self._heroScrollView._param

	scrollParam.lineCount = self._curLineCount

	self._csListScroll:Init(scrollParam.scrollDir, scrollParam.lineCount, scrollParam.cellWidth, scrollParam.cellHeight, scrollParam.cellSpaceH, scrollParam.cellSpaceV, scrollParam.startSpace, scrollParam.endSpace, scrollParam.sortMode, scrollParam.frameUpdateMs, scrollParam.minUpdateCountInFrame, self._heroScrollView._onUpdateCell, self._heroScrollView.onUpdateFinish, self._heroScrollView._onSelectCell, self._heroScrollView)
	self._heroScrollView:refreshScroll()
end

function MatchGameHeroGroupEditViewContainer:calcLineCount()
	local scrollWidth = recthelper.getWidth(self._tranScrollArea)
	local startSpace = self._heroScrollView._param.startSpace
	local cellWidth = self._heroScrollView._param.cellWidth
	local cellSpaceH = self._heroScrollView._param.cellSpaceH
	local showLineCount = math.floor((scrollWidth - startSpace) / (cellWidth + cellSpaceH))

	return math.max(DefaultLineCount, showLineCount)
end

return MatchGameHeroGroupEditViewContainer
