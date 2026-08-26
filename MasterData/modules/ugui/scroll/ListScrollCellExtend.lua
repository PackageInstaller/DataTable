-- chunkname: @modules/ugui/scroll/ListScrollCellExtend.lua

module("modules.ugui.scroll.ListScrollCellExtend", package.seeall)

local ListScrollCellExtend = class("ListScrollCellExtend", ListScrollCell)

function ListScrollCellExtend:onInitView()
	return
end

function ListScrollCellExtend:addEvents()
	return
end

function ListScrollCellExtend:removeEvents()
	return
end

function ListScrollCellExtend:_editableAddEvents()
	return
end

function ListScrollCellExtend:_editableRemoveEvents()
	return
end

function ListScrollCellExtend:onDestroyView()
	return
end

function ListScrollCellExtend:init(go)
	self.viewGO = go

	self:onInitView()
end

function ListScrollCellExtend:addEventListeners()
	self:addEvents()
	self:_editableAddEvents()
end

function ListScrollCellExtend:removeEventListeners()
	self:removeEvents()
	self:_editableRemoveEvents()
end

function ListScrollCellExtend:onUpdateMO(mo)
	return
end

function ListScrollCellExtend:onSelect(isSelect)
	return
end

function ListScrollCellExtend:onDestroy()
	self:onDestroyView()
end

return ListScrollCellExtend
