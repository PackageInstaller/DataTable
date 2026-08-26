-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzleChangeColorView.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzleChangeColorView", package.seeall)

local DungeonPuzzleChangeColorView = class("DungeonPuzzleChangeColorView", BaseView)

function DungeonPuzzleChangeColorView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._goshowboard = gohelper.findChild(self.viewGO, "#go_showboard")
	self._gofinalboard = gohelper.findChild(self.viewGO, "#go_finalboard")
	self._gointeractboard = gohelper.findChild(self.viewGO, "#go_interactboard")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._gosort = gohelper.findChild(self.viewGO, "#go_sort")
	self._gofinished = gohelper.findChild(self.viewGO, "#go_finish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonPuzzleChangeColorView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function DungeonPuzzleChangeColorView:removeEvents()
	self._btnreset:RemoveClickListener()
end

function DungeonPuzzleChangeColorView:_btnresetOnClick()
	self:_reset()
end

function DungeonPuzzleChangeColorView:_editableInitView()
	self._goshowitem = gohelper.findChild(self.viewGO, "#go_showboard/showitem")
	self._gofinalitem = gohelper.findChild(self.viewGO, "#go_finalboard/finalitem")
	self._gointeractitem = gohelper.findChild(self.viewGO, "#go_interactboard/interactitem")
	self._gosortitem = gohelper.findChild(self.viewGO, "#go_sort/sortitem")

	gohelper.setActive(self._gofinished, false)

	self._curTags = {}
	self._finalTags = {}
	self._showItems = {}
	self._finalItems = {}
	self._sortItems = {}
	self._interactItems = {}
end

function DungeonPuzzleChangeColorView:onUpdateParam()
	return
end

function DungeonPuzzleChangeColorView:onOpen()
	self._simagebg:LoadImage(ResUrl.getDungeonPuzzleBg("zqlm_bg4"))
	self:_initTags()
	self:_setFinalItem()
	self:_setSortItem()
	self:_setInteractItem()
	self:_refreshShowItem()
	self.addEventCb(self, DungeonPuzzleChangeColorController.instance, DungeonPuzzleEvent.InteractClick, self._changeTags, self)
end

function DungeonPuzzleChangeColorView:_initTags()
	local lvCo = DungeonConfig.instance:getDecryptChangeColorCo(self.viewParam)

	self._curTags = string.splitToNumber(lvCo.initColors, "#")
	self._finalTags = string.splitToNumber(lvCo.finalColors, "#")
end

function DungeonPuzzleChangeColorView:_isSuccess()
	if #self._curTags ~= #self._finalTags then
		return false
	end

	for i, v in ipairs(self._curTags) do
		if self._finalTags[i] ~= v then
			return false
		end
	end

	return true
end

function DungeonPuzzleChangeColorView:_changeTags(btnid)
	local btnCo = DungeonConfig.instance:getDecryptChangeColorInteractCo(btnid)
	local lvCo = DungeonConfig.instance:getDecryptChangeColorCo(self.viewParam)
	local totalSorts = string.splitToNumber(lvCo.interactbtns, "#")
	local value = string.split(btnCo.interactvalue, "|")
	local changes = string.splitToNumber(value[2], "#")

	for _, v in ipairs(changes) do
		self._curTags[v] = self._curTags[v] + tonumber(value[1]) > #totalSorts and (self._curTags[v] + tonumber(value[1])) % (#totalSorts + 1) + 1 or self._curTags[v] + tonumber(value[1])
	end

	self:_refreshShowItem()

	local isSuccess = self:_isSuccess()

	gohelper.setActive(self._gofinished, isSuccess)
end

function DungeonPuzzleChangeColorView:_reset()
	local lvCo = DungeonConfig.instance:getDecryptChangeColorCo(self.viewParam)

	self._curTags = string.splitToNumber(lvCo.initColors, "#")

	self:_refreshShowItem()
end

function DungeonPuzzleChangeColorView:_setFinalItem()
	if self._finalItems then
		for _, v in pairs(self._finalItems) do
			v:onDestroy()
		end
	end

	self._finalItems = {}

	for i = 1, #self._finalTags do
		local child = gohelper.cloneInPlace(self._gofinalitem)

		gohelper.setActive(child, true)

		local item = DungeonPuzzleChangeColorFinalColorItem.New()

		item:init(child, self._finalTags[i])
		table.insert(self._finalItems, item)
	end
end

function DungeonPuzzleChangeColorView:_setSortItem()
	if self._sortItems then
		for _, v in pairs(self._sortItems) do
			v:onDestroy()
		end
	end

	self._sortItems = {}

	local sorts = string.splitToNumber(DungeonConfig.instance:getDecryptChangeColorCo(self.viewParam).colorsort, "#")

	for i = 1, #sorts do
		local child = gohelper.cloneInPlace(self._gosortitem)

		gohelper.setActive(child, true)

		local item = DungeonPuzzleChangeColorSortItem.New()

		item:init(child, sorts[i])
		table.insert(self._sortItems, item)
	end
end

function DungeonPuzzleChangeColorView:_setInteractItem()
	if self._interactItems then
		for _, v in pairs(self._interactItems) do
			v:onDestroy()
		end
	end

	self._interactItems = {}

	local btns = string.splitToNumber(DungeonConfig.instance:getDecryptChangeColorCo(self.viewParam).interactbtns, "#")

	for i = 1, #btns do
		local child = gohelper.cloneInPlace(self._gointeractitem)

		gohelper.setActive(child, true)

		local item = DungeonPuzzleChangeColorInteractItem.New()

		item:init(child, btns[i])
		table.insert(self._interactItems, item)
	end
end

function DungeonPuzzleChangeColorView:_refreshShowItem()
	if self._showItems then
		for _, v in pairs(self._showItems) do
			v:onDestroy()
		end
	end

	self._showItems = {}

	for i = 1, #self._curTags do
		local child = gohelper.cloneInPlace(self._goshowitem)

		gohelper.setActive(child, true)

		local item = DungeonPuzzleChangeColorShowColorItem.New()

		item:init(child, self._curTags[i])
		table.insert(self._showItems, item)
	end
end

function DungeonPuzzleChangeColorView:onClose()
	self.removeEventCb(self, DungeonPuzzleChangeColorController.instance, DungeonPuzzleEvent.InteractClick, self._changeTags, self)
end

function DungeonPuzzleChangeColorView:onDestroyView()
	self._simagebg:UnLoadImage()

	if self._finalItems then
		for _, v in pairs(self._finalItems) do
			v:onDestroy()
		end

		self._finalItems = nil
	end

	if self._sortItems then
		for _, v in pairs(self._sortItems) do
			v:onDestroy()
		end

		self._sortItems = nil
	end

	if self._interactItems then
		for _, v in pairs(self._interactItems) do
			v:onDestroy()
		end

		self._interactItems = nil
	end

	if self._showItems then
		for _, v in pairs(self._showItems) do
			v:onDestroy()
		end

		self._showItems = nil
	end
end

return DungeonPuzzleChangeColorView
