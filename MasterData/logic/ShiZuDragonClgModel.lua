-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shizudragonclg/model/ShiZuDragonClgModel.lua

module("logic.extensions.shizudragonclg.model.ShiZuDragonClgModel", package.seeall)

local ShiZuDragonClgModel = class("ShiZuDragonClgModel", BaseModel)

function ShiZuDragonClgModel:onInit()
	self:onReset()
end

function ShiZuDragonClgModel:onReset()
	self._fmtMo = nil
	self._info = {}
	self._stageInfo = {}
end

function ShiZuDragonClgModel:getFmtMo()
	self._fmtMo = self._fmtMo or ShiZuDragonClgFmtMo.New()

	return self._fmtMo
end

function ShiZuDragonClgModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._info[data.activityId] = data

	local stageInfo = {}

	if data.stages then
		for i, v in ipairs(data.stages) do
			stageInfo[v.stageId] = v
		end
	end

	self._stageInfo[data.activityId] = stageInfo
end

function ShiZuDragonClgModel:saveReset(msg)
	if self._stageInfo[msg.activityId] then
		self._stageInfo[msg.activityId][msg.stageId] = nil
	end
end

function ShiZuDragonClgModel:saveChallenge(msg)
	if self._stageInfo[msg.activityId] then
		self._stageInfo[msg.activityId][msg.stageId] = {
			stageId = msg.stageId,
			num = msg.num
		}
	end
end

function ShiZuDragonClgModel:resetStageInfo(activityId, newPhaseId)
	if checknumber(newPhaseId) ~= 0 and self._info[activityId] then
		self._info[activityId].bestPhaseId = newPhaseId
	end

	self._stageInfo[activityId] = {}
end

function ShiZuDragonClgModel:saveNewPhaseId(activityId, newPhaseId)
	if checknumber(newPhaseId) ~= 0 and self._info[activityId] then
		self._info[activityId].bestPhaseId = newPhaseId
	end
end

function ShiZuDragonClgModel:getStageInfo(activityId, stageId)
	if self._stageInfo[activityId] then
		return self._stageInfo[activityId][stageId]
	end
end

function ShiZuDragonClgModel:getBestPhaseId(activityId)
	if self._info[activityId] then
		return self._info[activityId].bestPhaseId
	end

	return 0
end

function ShiZuDragonClgModel:saveClgTempInfo(msg)
	self._tempInfo = GameUtil.pbToTable(msg)
end

function ShiZuDragonClgModel:resetClgTempInfo()
	self._tempInfo = nil
end

function ShiZuDragonClgModel:getClgTempInfo()
	return self._tempInfo
end

ShiZuDragonClgModel.instance = ShiZuDragonClgModel.New()

return ShiZuDragonClgModel
