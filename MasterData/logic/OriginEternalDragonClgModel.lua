-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origineternaldragonclg/model/OriginEternalDragonClgModel.lua

module("logic.extensions.origineternaldragonclg.model.OriginEternalDragonClgModel", package.seeall)

local OriginEternalDragonClgModel = class("OriginEternalDragonClgModel", BaseModel)

function OriginEternalDragonClgModel:ctor()
	return
end

function OriginEternalDragonClgModel:onInit()
	self:onReset()
end

function OriginEternalDragonClgModel:onReset()
	self._infos = {}
	self._customFmtMoPool = {}
	self._stageInfoMap = {}
	self._typeInfoMap = {}
end

function OriginEternalDragonClgModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = OriginEternalDragonClgFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function OriginEternalDragonClgModel:getStageInfoMap(activityId)
	return self._stOriginEternalDragonClgModelageInfoMap[activityId]
end

function OriginEternalDragonClgModel:getInfo(activityId)
	return self._infos[activityId]
end

function OriginEternalDragonClgModel:getTypeInfoMap(activityId)
	return self._typeInfoMap[activityId]
end

function OriginEternalDragonClgModel:handlePM_OriginEternalDragonClgGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
	self._typeInfoMap[msg.activityId] = {}

	local info = self._infos[msg.activityId]
	local typeInfoMap = self._typeInfoMap[msg.activityId]

	info.effectComboIds = info.effectComboIds or {}
	info.typeList = info.typeList or {}

	for _, typeInfo in ipairs(info.typeList) do
		typeInfoMap[typeInfo.type] = typeInfo
	end
end

function OriginEternalDragonClgModel:handlePM_OriginEternalDragonClgFightNotifyRes(msg)
	local info = self._infos[msg.activityId]
	local typeInfoMap = self._typeInfoMap[msg.activityId]

	if msg.isWin then
		typeInfoMap[msg.type] = msg.typeInfo
	end

	if msg.changeSetId then
		info.gainFirstPassPrize = true
	end
end

function OriginEternalDragonClgModel:handlePM_OriginEternalDragonClgUnlockComboRes(msg)
	local info = self._infos[msg.activityId]

	table.insert(info.effectComboIds, msg.comboId)
end

function OriginEternalDragonClgModel:handlePM_OriginEternalDragonClgResetRes(msg)
	local info = self._infos[msg.activityId]

	self._typeInfoMap[msg.activityId] = {}
	info.typeList = {}
	info.effectComboIds = {}
end

OriginEternalDragonClgModel.instance = OriginEternalDragonClgModel.New()

return OriginEternalDragonClgModel
