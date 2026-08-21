-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/filterview/BackpackSortItemNew.lua

module("logic.extensions.backpack.view.filterview.BackpackSortItemNew", package.seeall)

local M = class("BackpackSortItemNew")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._isSelect = false
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	self._btn = Astral.ButtonAdapter.Get(self.mainGO)
	self._imgSelect = goutil.findChild(self.mainGO, "select")
	self._upGo = goutil.findChild(self.mainGO, "up")
	self._downGo = goutil.findChild(self.mainGO, "down")
	self._text = goutil.findChildTextComponent(self.mainGO, "Label")
end

function M:destroyUI()
	self.mainGO = nil
	self._evt = nil
	self._sortData = nil
end

function M:bindEvents()
	self._btn:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btn:RemoveClickListener()
end

function M:_onClick()
	if self._isSelect then
		local isUp = not self._sortData.isUp

		goutil.setActive(self._upGo, isUp)
		goutil.setActive(self._downGo, not isUp)

		self._sortData.isUp = isUp
	end

	if self._event then
		GlobalDispatcher:dispatchEvent(self._event, self._sortData)
	end
end

function M:showUp(isShow)
	goutil.setActive(self._upGo, isShow)
	goutil.setActive(self._downGo, not isShow)
end

function M:setEvent(evt)
	self._event = evt
end

function M:setData(BackpackItemSortData)
	self._sortData = BackpackItemSortData
	self._text.text = BackpackItemSortData:getName()

	self:showUp(BackpackItemSortData.isUp)
end

function M:getData()
	return self._sortData
end

function M:setSelect(select)
	self._isSelect = select

	goutil.setActive(self._imgSelect, self._isSelect)
end

return M
