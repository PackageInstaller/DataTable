-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/model/ShadowdragonclgFmtMo.lua

module("logic.extensions.shadowdragonclg.model.ShadowdragonclgFmtMo", package.seeall)

local ShadowdragonclgFmtMo = class("ShadowdragonclgFmtMo", BaseCustomFmtMo)

function ShadowdragonclgFmtMo:initParams(activityId, floorType, stageId)
	self._activityId = activityId
	self._floorType = floorType
	self._stageId = stageId
	self._isNow = floorType == ShadowdragonclgController.FloorType.Now
	self._stageCfg = self._isNow and ShadowdragonclgConfig.instance:getNowStageCfg(activityId, stageId) or ShadowdragonclgConfig.instance:getFuturePassStageCfg(activityId, stageId)
	self._creepsMasterId = self._stageCfg.creepsMasterId
	self._masterData = ShadowdragonclgConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = ShadowdragonclgConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self._lockPetRaceIdMap = self._isNow and ShadowdragonclgModel.instance:getNowStageLockPetRaceIdMap(activityId) or ShadowdragonclgModel.instance:getPassFutureStageLockPetRaceIdMap(activityId, self._stageCfg.stageId)
	self._useBuff = false
	self._param = ""
end

function ShadowdragonclgFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = ""
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
	self:getCurFormation():SetPosition(self._stageCfg.supportPetPosition, self._stageCfg.supportPetCreepsId)
end

function ShadowdragonclgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		if self._isNow then
			ShadowDragonClgAgent.instance:sendPM_ShadowDragonClgNowStageFightReq(self._activityId, self._stageId, simpleForm)
		else
			ShadowDragonClgAgent.instance:sendPM_ShadowDragonClgFuturePassStageFightReq(self._activityId, self._stageId, simpleForm, self._useBuff, self._param)
		end
	end

	self:setFightHandler(handler, nil)
end

function ShadowdragonclgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function ShadowdragonclgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function ShadowdragonclgFmtMo:getStageCfg()
	return self._stageCfg
end

function ShadowdragonclgFmtMo:getActId()
	return self._activityId
end

function ShadowdragonclgFmtMo:getExtendViewName()
	return ViewName.ShadowdragonclgextView
end

function ShadowdragonclgFmtMo:checkPetIsForbit(petMo, baseCheck)
	return self._lockPetRaceIdMap and self._lockPetRaceIdMap[petMo.raceId]
end

function ShadowdragonclgFmtMo:showForbitPetAlert(petMo)
	FloatWordMgr.instance:show("此精灵已锁定")
end

function ShadowdragonclgFmtMo:setPassStageBuffId(buffId)
	buffId = checknumber(buffId)
	self._useBuff = buffId > 0
	self._param = self._useBuff and tostring(buffId) or ""
end

function ShadowdragonclgFmtMo:getPassStageBuffId()
	return checknumber(self._param)
end

function ShadowdragonclgFmtMo:setFutureStageRaceId(raceId)
	raceId = checknumber(raceId)
	self._useBuff = raceId > 0
	self._param = self._useBuff and tostring(raceId) or ""
end

function ShadowdragonclgFmtMo:getFutureStageRaceId()
	return checknumber(self._param)
end

function ShadowdragonclgFmtMo:setDefultParam()
	local info = ShadowdragonclgModel.instance:getInfo(self._activityId)

	if self._stageCfg.type then
		local isPassStage = self._stageCfg.type == ShadowdragonclgController.PassFutureStageType.Pass

		if not self._isNow then
			for i, v in ipairs(info.futurePassStageList) do
				if v.stageId == self._stageId and v.useBuff and isPassStage then
					-- block empty
				end
			end
		end
	end
end

return ShadowdragonclgFmtMo
