-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/data/OriginKingOrderClgSubMo.lua

module("logic.extensions.originkingorderclg.data.OriginKingOrderClgSubMo", package.seeall)

local OriginKingOrderClgSubMo = class("OriginKingOrderClgSubMo")

function OriginKingOrderClgSubMo:ctor(activityId)
	self._activityId = activityId

	local stageDatas = OriginKingOrderClgConfig.instance:getStageDatas(self._activityId) or {}
	local maxStageData = stageDatas[#stageDatas]

	if maxStageData then
		self._maxStageId = maxStageData.stageId or 0
	end

	self:_resetData()
end

function OriginKingOrderClgSubMo:_resetData()
	self._curPassedStageId = 0
	self._maxPassedStageId = 0
	self._lastFormationSoul = {}
	self._fightResultMsg = nil
end

function OriginKingOrderClgSubMo:dispose()
	self:_resetData()
end

function OriginKingOrderClgSubMo:handlePM_OriginKingOrderClgGetInfoRes(msg)
	self._curPassedStageId = msg.curPassedStageId
	self._maxPassedStageId = msg.maxPassedStageId

	table.clear(self._lastFormationSoul)

	for i = 1, #msg.lastFormationSoul do
		self._lastFormationSoul[i] = msg.lastFormationSoul[i]
	end
end

function OriginKingOrderClgSubMo:handlePM_Notify_OriginKingOrderClgFightRes(msg)
	self._curPassedStageId = msg.stageId

	table.clear(self._lastFormationSoul)

	for i = 1, #msg.formationSoul do
		self._lastFormationSoul[i] = msg.formationSoul[i]
	end

	self._fightResultMsg = msg
end

function OriginKingOrderClgSubMo:handlePM_OriginKingOrderClgResetRes(msg)
	self._curPassedStageId = 0

	table.clear(self._lastFormationSoul)
end

function OriginKingOrderClgSubMo:handlePM_OriginKingOrderClgConfirmRes(msg)
	if msg:HasField("changeSetId") then
		self._changeSetId = msg.changeSetId
	end

	if msg.save then
		self._curPassedStageId = Mathf.Max(self._curPassedStageId, msg.stageId)
		self._maxPassedStageId = Mathf.Max(self._maxPassedStageId, msg.stageId)
	end
end

function OriginKingOrderClgSubMo:getCurPassedStageId()
	return self._curPassedStageId
end

function OriginKingOrderClgSubMo:isStagePassed(stageId)
	return stageId <= self._curPassedStageId
end

function OriginKingOrderClgSubMo:isHistoryStagePassed(stageId)
	return stageId <= self._maxPassedStageId
end

function OriginKingOrderClgSubMo:isStageUnlocked(stageId)
	return stageId <= self._curPassedStageId + 1
end

function OriginKingOrderClgSubMo:isAllStagePassed()
	return self._curPassedStageId >= self._maxStageId
end

function OriginKingOrderClgSubMo:isHistoryAllStagePassed()
	return self._maxPassedStageId >= self._maxStageId
end

function OriginKingOrderClgSubMo:getMaxPassedStageId()
	return self._maxPassedStageId
end

function OriginKingOrderClgSubMo:getMaxStageId()
	return self._maxStageId
end

function OriginKingOrderClgSubMo:getLastFormationSoul()
	return self._lastFormationSoul
end

function OriginKingOrderClgSubMo:getNextFormationSigns(lastFormationSoul, stageId)
	local map = {}
	local stageData = OriginKingOrderClgConfig.instance:getStageData(self._activityId, stageId)

	if stageData then
		for _, posId in ipairs(stageData.posSigns) do
			map[posId] = true
		end
	end

	local lastStageId = stageId - 1
	local stageType = self:getStageType(lastStageId)

	if stageType == OriginKingOrderClgEnum.StageType_Water then
		for posId = 1, 9 do
			if not lastFormationSoul[posId] then
				local soul = 0

				if soul <= 0 then
					map[posId] = true
				end
			end
		end
	elseif stageType == OriginKingOrderClgEnum.StageType_Kong then
		for posId = 1, 9 do
			if not lastFormationSoul[posId] then
				local soul = 0

				if soul == -1 then
					map[posId] = true
				end
			end
		end
	end

	return map
end

function OriginKingOrderClgSubMo:getStormRadiations(signs)
	local map = {}

	for posId = 1, 9 do
		map[posId] = 0
	end

	local dirs = {
		{
			-1,
			0
		},
		{
			1,
			0
		},
		{
			0,
			-1
		},
		{
			0,
			1
		}
	}

	for posId, isSign in ipairs(signs) do
		if isSign then
			local col = math.ceil(posId / 3)
			local row = (posId - 1) % 3 + 1

			for _, dir in ipairs(dirs) do
				local dr, dc = dir[1], dir[2]
				local dist = 1
				local nr, nc = row + dr, col + dc

				while nr >= 1 and nr <= 3 and nc >= 1 and nc <= 3 do
					local targetPosId = (nc - 1) * 3 + nr
					local value = map[targetPosId]

					if value == 0 then
						map[targetPosId] = dist
					elseif value ~= dist then
						map[targetPosId] = Mathf.Min(value + dist, 3)
					end

					dist = dist + 1
					nr = nr + dr
					nc = nc + dc
				end
			end
		end
	end

	return map
end

function OriginKingOrderClgSubMo:getStageType(stageId)
	local data = OriginKingOrderClgConfig.instance:getStageData(self._activityId, stageId)

	return (data or nil) and (data.type or OriginKingOrderClgEnum.StageType_None)
end

function OriginKingOrderClgSubMo:getFightResultMsg()
	return self._fightResultMsg
end

function OriginKingOrderClgSubMo:saveChangeSetId(changeSetId)
	self._changeSetId = changeSetId
end

function OriginKingOrderClgSubMo:popChangeSetId()
	self._changeSetId = nil

	return self._changeSetId
end

return OriginKingOrderClgSubMo
