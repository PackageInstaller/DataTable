-- chunkname: @modules/logic/dungeon/view/map/DungeonRecheckElementsView.lua

module("modules.logic.dungeon.view.map.DungeonRecheckElementsView", package.seeall)

local DungeonRecheckElementsView = class("DungeonRecheckElementsView", BaseView)

function DungeonRecheckElementsView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "#scroll_item")
	self._goitem = gohelper.findChild(self.viewGO, "#scroll_item/Viewport/Content/#go_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonRecheckElementsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function DungeonRecheckElementsView:removeEvents()
	self._btnclose:RemoveClickListener()

	for _, item in ipairs(self._items) do
		item.btngoto:RemoveClickListener()
	end
end

function DungeonRecheckElementsView:_btncloseOnClick()
	self:closeThis()
end

function DungeonRecheckElementsView:onClickModalMask()
	self:closeThis()
end

function DungeonRecheckElementsView:_btngotoOnClick(index)
	local item = self:_getItem(index)

	self:_onRecheck(item.elementId)
end

function DungeonRecheckElementsView:_onRecheck(elementId)
	if not elementId then
		return
	end

	local elementCo = lua_chapter_map_element.configDict[elementId]

	if not elementCo then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnRecheckElement, elementId, self.viewParam.isGM)
	self:closeThis()
end

function DungeonRecheckElementsView:_editableInitView()
	gohelper.setActive(self._goitem, false)

	self._items = self:getUserDataTb_()
end

function DungeonRecheckElementsView:onUpdateParam()
	return
end

function DungeonRecheckElementsView:_getElements(chapterId)
	if self.viewParam.isAll then
		local chapterElements = DungeonMapModel.instance:getChapterElements(chapterId)
		local list = {}

		if chapterElements then
			for _, co in ipairs(chapterElements) do
				if DungeonMapModel.instance:isCanRecheckElements(co) then
					table.insert(list, co.id)
				end
			end
		end

		return list
	end

	return DungeonMapModel.instance:getCanRecheckElements(chapterId)
end

function DungeonRecheckElementsView:onOpen()
	local chapterId = self.viewParam.chapterId

	self._canRecheckElements = self:_getElements(chapterId)

	if self._canRecheckElements then
		table.sort(self._canRecheckElements, function(a, b)
			local aco = lua_chapter_map_element.configDict[a]
			local bco = lua_chapter_map_element.configDict[b]

			if aco.mapId == bco.mapId then
				return a < b
			end

			return aco.mapId < bco.mapId
		end)

		for i, elementId in ipairs(self._canRecheckElements) do
			local item = self:_getItem(i)

			item.elementId = elementId

			local co = lua_chapter_map_element.configDict[elementId]

			if co then
				item.txtinfo.text = co.title
			end
		end
	end

	if self._canRecheckElements then
		local count = #self._canRecheckElements

		for i, item in ipairs(self._items) do
			gohelper.setActive(item.go, i <= count)
		end
	end
end

function DungeonRecheckElementsView:_getItem(index)
	local item = self._items[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goitem, index)

		local txtindex = gohelper.findChildText(item.go, "index")

		txtindex.text = index
		item.txtinfo = gohelper.findChildText(item.go, "info")
		item.btngoto = gohelper.findChildButtonWithAudio(item.go, "#btn_goto")
		self._items[index] = item

		item.btngoto:AddClickListener(self._btngotoOnClick, self, index)
	end

	return item
end

function DungeonRecheckElementsView:onClose()
	return
end

function DungeonRecheckElementsView:onDestroyView()
	return
end

return DungeonRecheckElementsView
