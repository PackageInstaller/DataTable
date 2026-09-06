-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/controller/ZoowarehouseController.lua

module("logic.extensions.zoo.controller.ZoowarehouseController", package.seeall)

local ZoowarehouseController = class("ZoowarehouseController", BaseController)

function ZoowarehouseController:ctor()
	ZoowarehouseController.super.ctor(self)
end

function ZoowarehouseController:onInit()
	ZoowarehouseController.super.onInit(self)
end

function ZoowarehouseController:onReset()
	ZoowarehouseController.super.onReset(self)

	self._name = nil
	self._raceId = nil
end

function ZoowarehouseController:setSearchName(name)
	self._name = name
end

function ZoowarehouseController:setSearchRace(raceId)
	self._raceId = raceId
end

function ZoowarehouseController:search(list)
	local result = {}

	for index, value in ipairs(list) do
		if (self._name == nil or self._name == "" or string.find(value.name, self._name)) and (self._raceId == nil or self._raceId == 0 or value.raceId == self._raceId) then
			table.insert(result, value)
		end
	end

	return result
end

function ZoowarehouseController:recordAnimalList(list, index)
	self._list = list
	self._index = index
end

function ZoowarehouseController:getCurAnimal()
	if self._list then
		return self._list[self._index]
	end
end

function ZoowarehouseController:getAdjoinAnimal(direction)
	self._index = direction and (self._list[self._index + 1] and self._index + 1 or 1) or self._list[self._index - 1] and self._index - 1 or #self._list

	return self._list[self._index]
end

ZoowarehouseController.instance = ZoowarehouseController.New()

return ZoowarehouseController
