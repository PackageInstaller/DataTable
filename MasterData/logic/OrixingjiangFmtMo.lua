-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orixingjiang/model/OrixingjiangFmtMo.lua

module("logic.extensions.orixingjiang.model.OrixingjiangFmtMo", package.seeall)

local OrixingjiangFmtMo = class("OrixingjiangFmtMo", BaseCustomFmtMo)

function OrixingjiangFmtMo:initParams(activityId, stageId, creepsMasterId)
	self._activityId = activityId
	self._stageId = stageId
	self._creepsMasterId = creepsMasterId
	self._masterData = OrixingjiangConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = OrixingjiangConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self._stageCfg = OrixingjiangConfig.instance:getStageCfg(self._activityId, self._stageId)
	self._lockRaceIdMap = OrixingjiangModel.instance:getLockRaceIdMap(self._activityId)
	self._transmogIdMap = {}
end

function OrixingjiangFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function OrixingjiangFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()
		local petIdToTransmogId = {}

		for petId, transmogId in pairs(self._transmogIdMap) do
			table.insert(petIdToTransmogId, {
				petId = petId,
				transmogId = transmogId
			})
		end

		OrixingjiangController.instance:setCurrClgStageId(self._stageId)
		OrixingjiangController.instance:sendPM_OriginXingjiangClgReq(self._activityId, self._stageId, petIdToTransmogId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OrixingjiangFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OrixingjiangFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OrixingjiangFmtMo:checkPetIsForbit(petMo, baseCheck)
	return self._lockRaceIdMap[petMo.raceId]
end

function OrixingjiangFmtMo:showForbitPetAlert(petMo)
	FloatWordMgr.instance:show("精灵锁定，无法上阵")
end

function OrixingjiangFmtMo:getExtendViewName()
	return ViewName.OriginxingjiangextView
end

function OrixingjiangFmtMo:resetTransmogMap()
	self._transmogIdMap = {}
end

function OrixingjiangFmtMo:setTransmogId(petId, transmogId)
	for k, v in pairs(self._transmogIdMap) do
		if v == transmogId then
			self._transmogIdMap[k] = nil
		end
	end

	self._transmogIdMap[petId] = transmogId
end

function OrixingjiangFmtMo:getTransmogId(petId)
	return self._transmogIdMap[petId]
end

function OrixingjiangFmtMo:isTransmog(transmogId)
	for k, v in pairs(self._transmogIdMap) do
		if v == transmogId then
			return true
		end
	end

	return false
end

return OrixingjiangFmtMo
