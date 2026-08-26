-- chunkname: @modules/logic/antique/model/AntiqueBackpackListModel.lua

module("modules.logic.antique.model.AntiqueBackpackListModel", package.seeall)

local AntiqueBackpackListModel = class("AntiqueBackpackListModel", ListScrollModel)

function AntiqueBackpackListModel:init()
	self:reInit()
end

function AntiqueBackpackListModel:reInit()
	self._antiqueList = {}
end

function AntiqueBackpackListModel:updateModel()
	self:setList(self._antiqueList)
end

function AntiqueBackpackListModel:getCount()
	return (self._antiqueList or nil) and (#self._antiqueList or 0)
end

function AntiqueBackpackListModel:setAntiqueList(antiqueList)
	self._antiqueList = antiqueList

	table.sort(self._antiqueList, function(a, b)
		return a.id < b.id
	end)
	self:setList(self._antiqueList)
end

function AntiqueBackpackListModel:_getAntiqueList()
	return self._antiqueList
end

function AntiqueBackpackListModel:clearAntiqueList()
	self._antiqueList = nil

	self:clear()
end

AntiqueBackpackListModel.instance = AntiqueBackpackListModel.New()

return AntiqueBackpackListModel
