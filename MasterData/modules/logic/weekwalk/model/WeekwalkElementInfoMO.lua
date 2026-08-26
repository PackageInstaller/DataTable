-- chunkname: @modules/logic/weekwalk/model/WeekwalkElementInfoMO.lua

module("modules.logic.weekwalk.model.WeekwalkElementInfoMO", package.seeall)

local WeekwalkElementInfoMO = pureTable("WeekwalkElementInfoMO")

function WeekwalkElementInfoMO:init(info)
	self.elementId = info.elementId
	self.isFinish = info.isFinish
	self.index = info.index
	self.historylist = info.historylist
	self.visible = info.visible
	self.config = WeekWalkConfig.instance:getElementConfig(self.elementId)

	if not self.config then
		logError(string.format("WeekwalkElementInfoMO no config id:%s", self.elementId))

		return
	end

	self.typeList = string.splitToNumber(self.config.type, "#")
	self.paramList = string.split(self.config.param, "|")
end

function WeekwalkElementInfoMO:getRes()
	local layer = self._mapInfo:getLayer()

	if layer >= WeekWalkEnum.FirstDeepLayer and self.config.roundId ~= 0 then
		local mapConfig = self._mapInfo:getMapConfig()

		if self.config.roundId == WeekWalkEnum.OneDeepLayerFirstBattle then
			if not mapConfig.resIdFront then
				local resId = mapConfig.resIdRear

				if resId > 0 then
					local resConfig = lua_weekwalk_element_res.configDict[resId]

					if resConfig then
						return resConfig.res
					end
				end
			end
		end
	end

	return self.config.res
end

function WeekwalkElementInfoMO:setMapInfo(info)
	self._mapInfo = info
end

function WeekwalkElementInfoMO:isAvailable()
	return not self.isFinish and self.visible
end

function WeekwalkElementInfoMO:updateHistoryList(list)
	self.historylist = list
end

function WeekwalkElementInfoMO:getType()
	return self.typeList[self.index + 1]
end

function WeekwalkElementInfoMO:getNextType()
	return self.typeList[self.index + 2]
end

function WeekwalkElementInfoMO:getParam()
	return self.paramList[self.index + 1]
end

function WeekwalkElementInfoMO:getPrevParam()
	return self.paramList[self.index]
end

function WeekwalkElementInfoMO:getBattleId()
	return self:_getBattleId()
end

function WeekwalkElementInfoMO:_getBattleId()
	local layer = self._mapInfo:getLayer()

	if layer >= WeekWalkEnum.FirstDeepLayer and self.config.roundId ~= 0 then
		local mapConfig = self._mapInfo:getMapConfig()

		if self.config.roundId == WeekWalkEnum.OneDeepLayerFirstBattle then
			if not mapConfig.fightIdFront then
				local battleId = mapConfig.fightIdRear

				if self:_checkBattleId(battleId, true) then
					return battleId
				end
			end
		end
	end

	local param = self:getParam()

	return (tonumber(param))
end

function WeekwalkElementInfoMO:_checkBattleId(battleId, isFromMap)
	if battleId and battleId > 0 then
		local battleInfo = self._mapInfo:getBattleInfo(battleId)

		if not battleInfo then
			logError(string.format("WeekwalkElementInfoMO no battleInfo mapId:%s elementId:%s battleId:%s isFromMap:%s", self._mapInfo.id, self.elementId, battleId, isFromMap))

			return false
		end

		return true
	end
end

function WeekwalkElementInfoMO:getConfigBattleId()
	for i, v in ipairs(self.typeList) do
		if v == WeekWalkEnum.ElementType.Battle then
			local param = self.paramList[i]

			return tonumber(param)
		end
	end
end

function WeekwalkElementInfoMO:_isBattleElement()
	for i, v in ipairs(self.typeList) do
		if v == WeekWalkEnum.ElementType.Battle then
			return true
		end
	end
end

return WeekwalkElementInfoMO
