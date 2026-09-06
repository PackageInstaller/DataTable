-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/model/DivineAoJiuModel.lua

module("logic.extensions.divineaojiu.model.DivineAoJiuModel", package.seeall)

local DivineAoJiuModel = class("DivineAoJiuModel", BaseModel)

DivineAoJiuModel.ReadFlag = "DivineAoJiuModel.ReadFlag"

function DivineAoJiuModel:ctor()
	return
end

function DivineAoJiuModel:onInit()
	self:onReset()
end

function DivineAoJiuModel:onReset()
	self._extraFmtMo = nil
	self._normalFmtMo = nil
	self._saveTeamStageId = nil
	self._resultTempData = nil
	self._info = {}
	self._extStageInfo = {}
	self._buffTypeCount = {}
end

function DivineAoJiuModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._info[data.activityId] = data

	local extStageInfo = {}

	for i, v in ipairs(data.stageList) do
		extStageInfo[v.stageId] = v
	end

	self._extStageInfo[data.activityId] = extStageInfo

	self:checkBuffTypeCount(data.activityId)
end

function DivineAoJiuModel:getExtStageInfo(activityId, stageId)
	if self._extStageInfo[activityId] then
		return self._extStageInfo[activityId][stageId]
	end
end

function DivineAoJiuModel:getExtraFmtMo()
	self._extraFmtMo = self._extraFmtMo or DivineAoJiuExtremeFmtMo.New()

	return self._extraFmtMo
end

function DivineAoJiuModel:getNormalFmtMo()
	self._normalFmtMo = self._normalFmtMo or DivineAoJiuNormalFmtMo.New()

	return self._normalFmtMo
end

function DivineAoJiuModel:resetSaveTempStage()
	self._saveTeamStageId = nil
end

function DivineAoJiuModel:saveTampStage(stageId)
	self._saveTeamStageId = stageId
end

function DivineAoJiuModel:getSaveTempStage()
	self._saveTeamStageId = self._saveTeamStageId or 1

	return self._saveTeamStageId
end

function DivineAoJiuModel:checkBuffTypeCount(activityId)
	self._buffTypeCount[activityId] = {}

	for stageId, info in pairs(self._extStageInfo[activityId]) do
		local buffCfg = DivineAoJiuConfig.instance:getBuffCfg(activityId, info.buffId)

		if buffCfg then
			self._buffTypeCount[activityId][buffCfg.buffType] = checknumber(self._buffTypeCount[activityId][buffCfg.buffType]) + 1
		end
	end
end

function DivineAoJiuModel:getBuffTypeCount(activityId, buffType)
	if self._buffTypeCount[activityId] then
		return checknumber(self._buffTypeCount[activityId][buffType])
	end

	return 0
end

function DivineAoJiuModel:getIsGainPassPrize(activityId)
	if self._info[activityId] then
		return self._info[activityId].gainFirstPassPrize
	end

	return false
end

function DivineAoJiuModel:saveTempResultData(msg)
	self._resultTempData = GameUtil.pbToTable(msg)
end

function DivineAoJiuModel:getTempResultData()
	return self._resultTempData
end

function DivineAoJiuModel:resetTempResultData()
	self._resultTempData = nil
end

function DivineAoJiuModel:saveComfirmResult(msg)
	local data = GameUtil.pbToTable(msg)

	if self._extStageInfo[data.activityId] then
		self._extStageInfo[data.activityId][data.stage.stageId] = data.stage
	end

	if self._info[data.activityId] then
		self._info[data.activityId].gainFirstPassPrize = data.gainFirstPassPrize
	end

	self:checkBuffTypeCount(data.activityId)
end

function DivineAoJiuModel:getPassNormalStage(activityId)
	if self._info[activityId] then
		return self._info[activityId].maxPassNormalStageId or 0
	end

	return 0
end

function DivineAoJiuModel:getLeftPassTime(activityId)
	if self._info[activityId] then
		return self._info[activityId].leftNormalFightTimes or 0
	end

	return 0
end

function DivineAoJiuModel:saveNormalBattleInfo(msg)
	local data = GameUtil.pbToTable(msg)

	if self._info[data.activityId] then
		self._info[data.activityId].maxPassNormalStageId = data.stageId
		self._info[data.activityId].leftNormalFightTimes = data.leftFightTimes
	end
end

function DivineAoJiuModel:saveBuyPassInfo(msg)
	local data = GameUtil.pbToTable(msg)

	if self._info[data.activityId] then
		self._info[data.activityId].maxPassNormalStageId = data.maxPassStageId
		self._info[data.activityId].leftNormalFightTimes = data.leftFightTimes
	end
end

function DivineAoJiuModel:saveExtremeFmt(activityId, stageId, posInfo)
	local key = string.format("%s#fmtRecord#%d#%d", DivineAoJiuModel.ReadFlag, activityId, stageId)
	local infoStr = GameUtil.jsonToString(posInfo)

	GameUtil.saveUserData(key, infoStr)
end

function DivineAoJiuModel:getExtremeFmt(activityId, stageId)
	local hasResult = false
	local key = string.format("%s#fmtRecord#%d#%d", DivineAoJiuModel.ReadFlag, activityId, stageId)
	local resultStr = GameUtil.getUserData(key)

	if not string.nilorempty(resultStr) then
		hasResult = true

		local info = GameUtil.jsonToTable(resultStr)

		return hasResult, info
	else
		return hasResult
	end
end

DivineAoJiuModel.instance = DivineAoJiuModel.New()

return DivineAoJiuModel
