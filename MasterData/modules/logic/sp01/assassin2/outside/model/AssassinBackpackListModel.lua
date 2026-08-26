-- chunkname: @modules/logic/sp01/assassin2/outside/model/AssassinBackpackListModel.lua

module("modules.logic.sp01.assassin2.outside.model.AssassinBackpackListModel", package.seeall)

local AssassinBackpackListModel = class("AssassinBackpackListModel", ListScrollModel)

function AssassinBackpackListModel:onInit()
	self:clearAll()
end

function AssassinBackpackListModel:reInit()
	self:clearData()
end

function AssassinBackpackListModel:clearAll()
	self:clear()
	self:clearData()
end

function AssassinBackpackListModel:clearData()
	self._selectedItemId = nil
end

function AssassinBackpackListModel:setAssassinBackpackList()
	self:clearAll()

	local list = AssassinItemModel.instance:getAssassinItemMoList()

	self:setList(list)
end

local DEFAULT_SELECT_INDEX = 1

function AssassinBackpackListModel:selectCell(index, isSelect)
	local mo = self:getByIndex(index)

	if not mo then
		index = DEFAULT_SELECT_INDEX
		mo = self:getByIndex(DEFAULT_SELECT_INDEX)
	end

	AssassinBackpackListModel.super.selectCell(self, index, isSelect)

	self._selectedItemId = mo and mo:getId()
end

function AssassinBackpackListModel:getSelectedItemId()
	return self._selectedItemId
end

AssassinBackpackListModel.instance = AssassinBackpackListModel.New()

return AssassinBackpackListModel
