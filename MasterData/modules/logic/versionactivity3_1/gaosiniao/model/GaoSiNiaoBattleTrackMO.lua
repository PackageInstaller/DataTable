-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/model/GaoSiNiaoBattleTrackMO.lua

module("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoBattleTrackMO", package.seeall)

local GaoSiNiaoBattleTrackMO = class("GaoSiNiaoBattleTrackMO")
local kPathTypeToNameDict

local function _ctor_kPathTypeToName()
	if kPathTypeToNameDict then
		return
	end

	kPathTypeToNameDict = {}

	for eName, eValue in pairs(GaoSiNiaoEnum.PathType) do
		kPathTypeToNameDict[eValue] = eName
	end
end

function GaoSiNiaoBattleTrackMO:ctor()
	self:clear()
end

function GaoSiNiaoBattleTrackMO:clear()
	self.used_times = -1
	self._startTs = 0
end

function GaoSiNiaoBattleTrackMO:onGameStart()
	self.used_times = 0
	self._startTs = os.time()
end

function GaoSiNiaoBattleTrackMO:onGameReset()
	self:_addResetTimes()
end

function GaoSiNiaoBattleTrackMO:_addResetTimes()
	self.used_times = self.used_times + 1
end

function GaoSiNiaoBattleTrackMO:track_act210_operation(mapMO, operation_type)
	if self.used_times == -1 then
		return
	end

	_ctor_kPathTypeToName()

	local map_id = mapMO:mapId()
	local usetime = os.time() - self._startTs
	local act210_grid_info = {}

	mapMO:foreachGrid(function(gridItem, _, x, y)
		local bagItem = gridItem:_getPlacedBagItem()

		if bagItem then
			local ePathType = bagItem.type
			local ePathTypeName = kPathTypeToNameDict[ePathType]

			table.insert(act210_grid_info, {
				id = ePathTypeName or "[Unknown]",
				x = x,
				y = y
			})
		end
	end)
	SDKDataTrackMgr.instance:track_act210_operation(map_id, operation_type, act210_grid_info, self.used_times, usetime)
end

return GaoSiNiaoBattleTrackMO
