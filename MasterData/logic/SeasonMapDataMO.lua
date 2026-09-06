-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonMapDataMO.lua

module("logic.extensions.season.model.SeasonMapDataMO", package.seeall)

local SeasonMapDataMO = class("SeasonMapDataMO")

SeasonMapDataMO.Fog_None = nil
SeasonMapDataMO.Fog_Within = 1
SeasonMapDataMO.Fog_Without = 2

function SeasonMapDataMO:ctor()
	self.id = 0
	self._isMark = false
	self._isOccupied = false
	self._gridX = nil
	self._gridY = nil
	self._fogState = SeasonMapDataMO.Fog_None
	self._eventInfo = {}
	self._unlockedDanceLionMap = {}
	self._rotateDir = nil
	self._isInitServerData = false
	self.initEventType = nil
	self.initEventId = nil
end

function SeasonMapDataMO:setGridId(id)
	self.id = id

	local seasonModel = SeasonModel.instance
	local seasonId = seasonModel:getSeasonId()
	local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, id)

	if evtConfig then
		self.initEventType = evtConfig.eventType
		self.initEventId = evtConfig.eventId

		if self.initEventType == SeasonGridEvtTypes.EVT_MAP_LOCK then
			local fogObjIds = string.splitToNumber(evtConfig.fogObjIds or "", ",")

			for _, linkElementId in ipairs(fogObjIds) do
				local linkGrid = SeasonPathFindingDataModel.instance:getGridIdByElementId(linkElementId)

				seasonModel:setMapInfoFogState(linkGrid, SeasonMapDataMO.Fog_Within)
			end
		elseif self.initEventType == SeasonGridEvtTypes.EVT_DANCE_LION and table.nums(self._unlockedDanceLionMap) == 0 then
			local fogObjIds = string.splitToNumber(evtConfig.fogObjIds or "", ",")

			for _, linkElementId in ipairs(fogObjIds) do
				local linkGrid = SeasonPathFindingDataModel.instance:getGridIdByElementId(linkElementId)

				self._unlockedDanceLionMap[linkGrid] = false
			end
		end

		if self.initEventType == SeasonGridEvtTypes.EVT_DANCE_LION then
			self._rotateDir = 4
		end
	end
end

function SeasonMapDataMO:getRotateDir()
	return self._rotateDir
end

function SeasonMapDataMO:rotateDir()
	self._rotateDir = self._rotateDir + 1

	if self._rotateDir > 6 then
		self._rotateDir = 1
	end
end

function SeasonMapDataMO:setGridIdAndInit(id)
	self._isInitServerData = true

	self:setGridId(id)
end

function SeasonMapDataMO:isInitServerData()
	return self._isInitServerData
end

function SeasonMapDataMO:getFindWayWeight()
	if self.initEventType ~= nil and not self._isOccupied then
		return SeasonGridEvtTypes.Weights[self.initEventType] or 0
	end

	return 0
end

function SeasonMapDataMO:update(params)
	self:setGridIdAndInit(params.pointId)

	self._gridX = nil
	self._gridY = nil
	self._isOccupied = params.isOccupied

	self:updateEventInfo(params)

	if params.isOccupied then
		SeasonModel.instance:setOccupied(self.id)
	end
end

function SeasonMapDataMO:updateEventInfo(params)
	if params.eventInfo then
		if not string.nilorempty(params.eventInfo.param) then
			local status, result = xpcall(GameUtil.jsonToTable, __G__TRACKBACK__, params.eventInfo.param)

			if result then
				self._eventInfo.param = result
			end
		end

		if params.eventInfo.eventType then
			self._eventInfo.eventType = params.eventInfo.eventType
		end
	end
end

function SeasonMapDataMO:updateFogState(state)
	if self._fogState ~= SeasonMapDataMO.Fog_Without then
		self._fogState = state
	end
end

function SeasonMapDataMO:updateDanceLionState(unlockedPointId)
	for _, gridId in ipairs(unlockedPointId) do
		self:addDanceLionState(gridId)
	end
end

function SeasonMapDataMO:addDanceLionState(gridId)
	self._unlockedDanceLionMap[gridId] = true
end

function SeasonMapDataMO:isLionUnlock(gridId)
	return self._unlockedDanceLionMap[gridId] == true
end

function SeasonMapDataMO:getLionUnlockArray()
	local array = {}

	for gridId, v in pairs(self._unlockedDanceLionMap) do
		if v == false then
			table.insert(array, gridId)
		end
	end

	return array
end

function SeasonMapDataMO:_setOccupied()
	self._isOccupied = true
end

function SeasonMapDataMO:isOccupied()
	return self._isOccupied
end

function SeasonMapDataMO:isLock()
	if self._eventInfo.param then
		return checkbool(self._eventInfo.param.is_lock)
	end
end

function SeasonMapDataMO:getWoodenOldDamage()
	if self._eventInfo.param then
		return checknumber(self._eventInfo.param.old_damage)
	end

	return 0
end

function SeasonMapDataMO:getGridPos()
	if self._gridX == nil then
		self._gridX, self._gridY = SeasonPathFindingDataModel.instance:id2Grid(self.id)
	end

	return self._gridX, self._gridY
end

function SeasonMapDataMO:_setMarkState(isMark)
	self._isMark = isMark
end

function SeasonMapDataMO:isMark()
	return self._isMark
end

return SeasonMapDataMO
