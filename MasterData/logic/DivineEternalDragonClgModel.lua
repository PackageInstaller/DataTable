-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineeternaldragonclg/model/DivineEternalDragonClgModel.lua

module("logic.extensions.divineeternaldragonclg.model.DivineEternalDragonClgModel", package.seeall)

local DivineEternalDragonClgModel = class("DivineEternalDragonClgModel", BaseModel)

function DivineEternalDragonClgModel:ctor()
	return
end

function DivineEternalDragonClgModel:onInit()
	self:onReset()
end

function DivineEternalDragonClgModel:onReset()
	self._baseInfoList = {}
	self._lastFightResultInfo = {}
end

function DivineEternalDragonClgModel:getBaseInfoByActId(actId)
	if not self._baseInfoList[actId] then
		printInfo("永恒圣龙数据未初始化")
	end

	return self._baseInfoList[actId]
end

function DivineEternalDragonClgModel:getLastFightResultInfo()
	return self._lastFightResultInfo
end

function DivineEternalDragonClgModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._baseInfoList[info.activityId] = info
end

function DivineEternalDragonClgModel:onResetStage(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self._baseInfoList[info.activityId]

	for i = 1, 2 do
		baseInfo.teamLockRaceIds[i] = {}
	end

	baseInfo.teamIsPass = {}
end

function DivineEternalDragonClgModel:onChallengeEnd(msg)
	self._lastFightResultInfo = GameUtil.pbToTable(msg)
end

DivineEternalDragonClgModel.instance = DivineEternalDragonClgModel.New()

return DivineEternalDragonClgModel
