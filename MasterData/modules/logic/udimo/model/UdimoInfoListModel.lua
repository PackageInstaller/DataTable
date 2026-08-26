-- chunkname: @modules/logic/udimo/model/UdimoInfoListModel.lua

module("modules.logic.udimo.model.UdimoInfoListModel", package.seeall)

local UdimoInfoListModel = class("UdimoInfoListModel", ListScrollModel)

function UdimoInfoListModel:onInit()
	self:clear()
	self:clearData()
end

function UdimoInfoListModel:reInit()
	self:clearData()
end

function UdimoInfoListModel:clearData()
	self._selectedUdimoId = nil
end

function UdimoInfoListModel:setUdimoInfoList()
	self:clear()
	self:clearData()

	local list = UdimoConfig.instance:getAllUdimoList(true)

	self:setList(list)
end

local DEFAULT_SELECT_INDEX = 1

function UdimoInfoListModel:selectCell(index, isSelect)
	local mo = index and self:getByIndex(index)

	if not mo then
		index = DEFAULT_SELECT_INDEX
		mo = self:getByIndex(DEFAULT_SELECT_INDEX)
	end

	UdimoInfoListModel.super.selectCell(self, index, isSelect)

	self._selectedUdimoId = mo and mo.id
end

function UdimoInfoListModel:getSelectedUdimoId()
	return self._selectedUdimoId
end

UdimoInfoListModel.instance = UdimoInfoListModel.New()

return UdimoInfoListModel
