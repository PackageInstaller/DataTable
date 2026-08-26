-- chunkname: @modules/logic/store/view/DecorateStoreSkinListComp.lua

module("modules.logic.store.view.DecorateStoreSkinListComp", package.seeall)

local DecorateStoreSkinListComp = class("DecorateStoreSkinListComp", LuaCompBase)

DecorateStoreSkinListComp.AutoToNextTime = 4

function DecorateStoreSkinListComp:init(go)
	self.viewGO = go
	self.transform = go.transform
	self.goItem = gohelper.findChild(self.viewGO, "scroll_skin/viewport/content/#go_skinitem")

	gohelper.setActive(self.goItem, false)

	self.itemList = {}
end

function DecorateStoreSkinListComp:addEventListeners()
	return
end

function DecorateStoreSkinListComp:removeEventListeners()
	return
end

function DecorateStoreSkinListComp:setSkinList(list)
	self:buildScroll()
	self:setListVisible(true)
	DecorateStoreSkinListModel.instance:refreshList(list)

	local selectMo = self:getSelect()
	local index = DecorateStoreSkinListModel.instance:getSkinIndex(selectMo and selectMo.id) or 1

	DecorateStoreSkinListModel.instance:selectCell(index, true)
	self:autoShowNextSkin(true)
end

function DecorateStoreSkinListComp:autoShowNextSkin(isAuto)
	TaskDispatcher.cancelTask(self._toNextSkin, self)

	if isAuto then
		TaskDispatcher.runDelay(self._toNextSkin, self, DecorateStoreSkinListComp.AutoToNextTime)
	end
end

function DecorateStoreSkinListComp:_toNextSkin()
	local selectMo = self:getSelect()
	local newIndex = DecorateStoreSkinListModel.instance:getNextSkinIndex(selectMo) or 1

	DecorateStoreSkinListModel.instance:selectCell(newIndex, true)
	self._scrollView:moveToByIndex(newIndex)

	selectMo = self:getSelect()

	if selectMo then
		StoreController.instance:dispatchEvent(StoreEvent.DecorateStoreSkinSelectItemClick, selectMo.id, true)
	end
end

function DecorateStoreSkinListComp:buildScroll()
	if self._scrollView then
		return
	end

	self.notPlayAnimation = true

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "scroll_skin"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "scroll_skin/viewport/content/#go_skinitem"
	scrollParam.cellClass = DecorateStoreSkinListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 144
	scrollParam.cellHeight = 126
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 30
	scrollParam.endSpace = 0
	scrollParam.sortMode = ScrollEnum.ScrollSortUp
	self._scrollView = LuaListScrollViewWithAnimator.New(DecorateStoreSkinListModel.instance, scrollParam)
	self._scrollView.isFirst = true

	function self._scrollView.onUpdateFinish(view)
		view.isFirst = false
	end

	self._scrollView:__onInit()

	self._scrollView.viewGO = self.viewGO
	self._scrollView.viewContainer = self

	self._scrollView:onInitViewInternal()
	self._scrollView:addEventsInternal()
end

function DecorateStoreSkinListComp:setListVisible(isShow)
	if isShow then
		self._scrollView:onOpen()
	else
		self._scrollView:onCloseFinish()
	end
end

function DecorateStoreSkinListComp:getSelect()
	return self._scrollView:getFirstSelect()
end

function DecorateStoreSkinListComp:onClose()
	TaskDispatcher.cancelTask(self._toNextSkin, self)
end

function DecorateStoreSkinListComp:onDestroy()
	TaskDispatcher.cancelTask(self._toNextSkin, self)

	if self._scrollView then
		self._scrollView:removeEventsInternal()
		self._scrollView:onDestroyViewInternal()
		self._scrollView:__onDispose()
	end

	self._scrollView = nil
end

return DecorateStoreSkinListComp
