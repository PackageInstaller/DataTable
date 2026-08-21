-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/DungeonEntranceModel.lua

module("logic.extensions.dungeon.model.DungeonEntranceModel", package.seeall)

local M = class("DungeonEntranceModel", BaseModel)

function M:ctor()
	M.super.ctor(self)

	self._firstEntranceMoList = BaseListModel.New()
	self._secondEntranceMoList = BaseListModel.New()
end

function M:onInit()
	self:onReset()

	local firstEntranceInfo = DungeonEntranceConfig.instance:getCfgFirstEntrance()

	for k, entranceCo in ipairs(firstEntranceInfo) do
		local entranceMo = DungeonFirstEntranceMo.New(entranceCo)

		self._firstEntranceMoList:addMo(entranceMo)
	end

	local secondEntranceInfo = DungeonEntranceConfig.instance:getCfgSecondEntrance()

	for k, entranceCo in ipairs(secondEntranceInfo) do
		local entranceMo = DungeonSecondEntranceMo.New(entranceCo)

		self._secondEntranceMoList:addMo(entranceMo)
	end
end

function M:onReset()
	return
end

function M:getFirstEntranceMoList()
	return self._firstEntranceMoList
end

function M:getFirstEntranceMoByCode(code)
	return self._firstEntranceMoList:getMoById(code)
end

function M:getSecondEntranceMoList()
	return self._secondEntranceMoList
end

M.instance = M.New()

return M
