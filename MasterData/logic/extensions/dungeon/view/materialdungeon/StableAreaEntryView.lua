-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/materialdungeon/StableAreaEntryView.lua

module("logic.extensions.dungeon.view.materialdungeon.StableAreaEntryView", package.seeall)

local M = class("StableAreaEntryView", ViewComponent)
local GuideId = 1001

function M:ctor()
	return
end

function M:buildUI()
	self._btnReturn = self:getBtn("1&title_view_-878360263")
	self._btnHome = self:getBtn("1&title_view_1398742689")
	self._btnExplain = self:getBtn("1&title_view_-636449388")
	self._scrollRect = self:getUIComponent("stable_area_entry_view_141474315", UIComponentType.ScrollRect)
	self._loopList = LoopListHelper.New(self:getGo("stable_area_entry_view_141474315"))

	self._loopList:InitListView(0, self._updateChapterCell, self)
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnExplain:AddClickListener(self._onClickExplain, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
end

function M:onEnter()
	self:_initData()
	self:_refreshView()
end

function M:onExit()
	return
end

function M:destroyUI()
	self._loopList:Dispose()

	self._loopList = nil
end

function M._sortChapterFun(chapter1, chapter2)
	if chapter1:getIsChapterUnlock() == chapter2:getIsChapterUnlock() then
		return chapter1:getChapterId() < chapter2:getChapterId()
	end

	return chapter1:getIsChapterUnlock()
end

function M:_initData()
	local chapterList = DungeonMaterialChapterModel.instance:getAllChapter()

	self._chapterList = {}

	for _, v in pairs(chapterList) do
		table.insert(self._chapterList, v)
	end

	table.sort(self._chapterList, self._sortChapterFun)
end

function M:_refreshView()
	self._loopList:SetListItemCount(#self._chapterList)
	self._loopList:RefreshAllShownItem()
end

function M:_updateChapterCell(index)
	local cellIndex = index + 1
	local item = self._loopList:NewListViewItem("stable_area_chapter_item")
	local itemView = Astral.SimpleLuaComponentContainer.Add(item.gameObject, StableAreaChapterCell)
	local chapterMo = self._chapterList[cellIndex]

	itemView:setData(chapterMo, self._onClickChapter, self)

	return item
end

function M:_onClickChapter(chapterMo)
	local chapterId = chapterMo:getChapterId()

	DungeonMaterialChapterModel.instance:setClickChapterIdAndDungeonIndex(chapterId, nil)
	ViewMgr.instance:open(ViewName.StableAreaChapterView, chapterId)
end

function M:_onClickReturn()
	local sceneFlowType = SceneFace.instance:getCurSceneFlowTyp()

	if sceneFlowType == nil then
		self:_onClickHome()
	else
		self:back()
	end
end

function M:_onClickHome()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_onClickExplain()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		GuideId
	})
end

return M
