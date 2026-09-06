-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/model/OriginFightModel.lua

module("logic.extensions.originfight.model.OriginFightModel", package.seeall)

local OriginFightModel = class("OriginFightModel", BaseModel)

function OriginFightModel:ctor()
	return
end

function OriginFightModel:onInit()
	self:onReset()
end

function OriginFightModel:onReset()
	self._infos = {}
	self._customFmtMoPool = {}
	self._storyIdList = {}
	self._progressPrizeMap = {}
	self._rolePos = {}
	self._gameEventFinishMap = {}
	self._buyPetPosMap = {}
	self._railStateMap = {}
	self._switchStateMap = {}
	self._fmtMo = nil
	self._gameInfo = nil
	self._playingStageId = nil
end

function OriginFightModel:pushStoryId(storyId)
	table.insert(self._storyIdList, storyId)
end

function OriginFightModel:popStoryId(storyId)
	if #self._storyIdList > 0 then
		return table.remove(self._storyIdList)
	end
end

function OriginFightModel:getInfo(activityId)
	return self._infos[activityId]
end

function OriginFightModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = OriginFightFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function OriginFightModel:handlePM_OriginFightInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)

	local info = self._infos[msg.activityId]

	info.hasSummonGodFavorIds = msg.hasSummonGodFavorIds or {}
end

function OriginFightModel:handlePM_OriginFightGainPrizeRes(msg)
	local info = self._infos[msg.activityId]

	info.hasGainPrize = true
end

function OriginFightModel:handlePM_OriginFightCommonGodFavorRes(msg)
	local info = self._infos[msg.activityId]

	table.insert(info.hasSummonGodFavorIds, msg.godFavorId)
end

function OriginFightModel:isRailOpen(eventId)
	if self._railStateMap[eventId] ~= nil then
		return self._railStateMap[eventId]
	else
		return true
	end
end

function OriginFightModel:isSwitchOpen(eventId)
	if self._switchStateMap[eventId] ~= nil then
		return self._switchStateMap[eventId]
	else
		return true
	end
end

function OriginFightModel:isEventFinish(eventId)
	return self._gameEventFinishMap[eventId]
end

function OriginFightModel:initSwitchState(activityId, stageId)
	self._switchStateMap = {}

	local stageCfg = OriginFightConfig.instance:getDungeonStageCfg(activityId, stageId)
	local eventCfgs = OriginFightConfig.instance:getDungeonEventCfgs(stageId)

	for i, v in ipairs(eventCfgs) do
		if v.eventType == "switchCtrl" then
			local railEventIds = string.split(v.eventParam, ",")
			local checkRailEventCfg = OriginFightConfig.instance:getDungeonEventCfgById(stageId, checknumber(railEventIds[1]))

			self._switchStateMap[v.eventId] = checkRailEventCfg.eventParam == "open"
		end
	end
end

function OriginFightModel:isSwitchOpen(eventId)
	if self._switchStateMap[eventId] ~= nil then
		return self._switchStateMap[eventId]
	else
		return true
	end
end

function OriginFightModel:switchSwitchState(eventId)
	if self._switchStateMap[eventId] ~= nil then
		self._switchStateMap[eventId] = not self._switchStateMap[eventId]
	end
end

function OriginFightModel:getSwitchStateMap()
	return self._switchStateMap
end

function OriginFightModel:initRailState(activityId, stageId)
	self._railStateMap = {}

	local stageCfg = OriginFightConfig.instance:getDungeonStageCfg(activityId, stageId)
	local eventCfgs = OriginFightConfig.instance:getDungeonEventCfgs(stageId)

	for i, v in ipairs(eventCfgs) do
		if v.eventType == "rail" then
			self._railStateMap[v.eventId] = v.eventParam == "open"
		end
	end
end

function OriginFightModel:isRailOpen(eventId)
	if self._railStateMap[eventId] ~= nil then
		return self._railStateMap[eventId]
	else
		return true
	end
end

function OriginFightModel:switchRailState(eventId)
	if self._railStateMap[eventId] ~= nil then
		self._railStateMap[eventId] = not self._railStateMap[eventId]
	end
end

function OriginFightModel:getRailStateMap()
	return self._railStateMap
end

OriginFightModel.instance = OriginFightModel.New()

return OriginFightModel
