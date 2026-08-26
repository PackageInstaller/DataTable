-- chunkname: @modules/logic/rouge/view/RougeFactionItemSelected_DescItem.lua

module("modules.logic.rouge.view.RougeFactionItemSelected_DescItem", package.seeall)

local RougeFactionItemSelected_DescItem = class("RougeFactionItemSelected_DescItem", UserDataDispose)

function RougeFactionItemSelected_DescItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeFactionItemSelected_DescItem:addEvents()
	return
end

function RougeFactionItemSelected_DescItem:removeEvents()
	return
end

function RougeFactionItemSelected_DescItem:ctor(parent)
	self:__onInit()

	self._parent = parent
end

function RougeFactionItemSelected_DescItem:init(go)
	self.viewGO = go

	self:onInitView()
end

function RougeFactionItemSelected_DescItem:setIndex(index)
	self._index = index
end

function RougeFactionItemSelected_DescItem:index()
	return self._index
end

function RougeFactionItemSelected_DescItem:_editableInitView()
	self._txt = gohelper.findChildText(self.viewGO, "")

	self:setData(nil)
end

function RougeFactionItemSelected_DescItem:setData(desc)
	self._txt.text = desc or ""

	self:setActive(not string.nilorempty(desc))
end

function RougeFactionItemSelected_DescItem:setActive(bool)
	gohelper.setActive(self.viewGO, bool)
end

function RougeFactionItemSelected_DescItem:onDestroyView()
	self:__onDispose()
end

return RougeFactionItemSelected_DescItem
