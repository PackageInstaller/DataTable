-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingjiclg/model/DivinekingjiFmtMo.lua

module("logic.extensions.divinekingjiclg.model.DivinekingjiFmtMo", package.seeall)

local DivinekingjiFmtMo = class("DivinekingjiFmtMo", BaseCustomFmtMo)

function DivinekingjiFmtMo:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local stageCfg = DivinekingjiclgConfig.instance:getStageCfg(activityId, stageId)

	self._creepsMasterId = stageCfg.creepsMasterId
	self._masterData = DivinekingjiclgConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = DivinekingjiclgConfig.instance:getCreepsCfgs(self._creepsMasterId)

	local lockRaceIds = DivinekingjiclgModel.instance:getLockRaceIds(self._activityId)

	self._lockRaceIdMap = {}

	if lockRaceIds then
		for i, v in ipairs(lockRaceIds) do
			self._lockRaceIdMap[v] = true
		end
	end

	self.topTitleStr = self._masterData.name
	self.validatorDescStr = ""
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivinekingjiFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineKingJiClgAgent.instance:sendPM_DivineKingJiClgFightReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivinekingjiFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivinekingjiFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivinekingjiFmtMo:checkPetIsForbit(petMo)
	return self._lockRaceIdMap[petMo.raceId]
end

function DivinekingjiFmtMo:showForbitPetAlert(petMo)
	FloatWordMgr.instance:show("此精灵已锁定")
end

function DivinekingjiFmtMo:getExtendViewName()
	return ViewName.DivinekingjiclgextView
end

function DivinekingjiFmtMo:onFormationChangeFinish()
	GlobalDispatcher:dispatch(GlobalNotify.DivineKingJiClgCalLockRaceNum)
end

return DivinekingjiFmtMo
