-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/model/DivineFarnasExtFmtMo.lua

module("logic.extensions.divineeternaldragonclg.model.DivineFarnasExtFmtMo", package.seeall)

local DivineFarnasExtFmtMo = class("DivineFarnasExtFmtMo", BaseCustomFmtMo)

function DivineFarnasExtFmtMo:updateCfg(activityId, stageId)
	self._proxyPool = {}
	self._activityId = checknumber(activityId)
	self._stageId = checknumber(stageId)

	local extStageCfgs = DivineFarnasConfig.instance:getExtStageCfgs(activityId)
	local extStageNum = #extStageCfgs

	self._creepsMasterId = DivineFarnasConfig.instance:getExtCreepsMasterId(activityId, stageId)
	self._masterData = DivineFarnasConfig.instance:getCreepMasterCfg(self._creepsMasterId)
	self._creepsCfg = DivineFarnasConfig.instance:getCreepsCfg(self._creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc
	self.validatorDescStr = ""

	if stageId > extStageNum / 2 then
		local curLevel = DivineFarnasController.instance:getActiveBuffCfgLevel(activityId)
		local curCfg = DivineFarnasConfig.instance:getBuffCfgByBuffId(activityId, curLevel)

		self.validatorDescStr = string.format("当前激活的加成：%s", curCfg.buffDesc)
	end

	self:setFormCondition(self._masterData.formCondition)
end

function DivineFarnasExtFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineFarnasController:sendPM_DivineFarnasClgExtremeFightReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function DivineFarnasExtFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineFarnasExtFmtMo:getFmtInfoConfig()
	return self._masterData
end

return DivineFarnasExtFmtMo
