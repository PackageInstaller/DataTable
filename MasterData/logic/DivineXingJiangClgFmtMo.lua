-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/model/DivineXingJiangClgFmtMo.lua

module("logic.extensions.divinexingjiangclg.model.DivineXingJiangClgFmtMo", package.seeall)

local DivineXingJiangClgFmtMo = class("DivineXingJiangClgFmtMo", BaseCustomFmtMo)

function DivineXingJiangClgFmtMo:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local cfg = DivineXingJiangClgConfig.instance:getStageCfg(self._activityId, self._stageId)

	self._monsterCfg = DivineXingJiangClgConfig.instance:getMonsterCfg(cfg.creepsMasterId)
	self._creepsCfgs = DivineXingJiangClgConfig.instance:getCreeps(cfg.creepsMasterId)
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = nil

	self:setFormCondition(self._monsterCfg.formCondition)
end

function DivineXingJiangClgFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		DivineXingJiangClgAgent.instance:sendPM_DivineXingJiangClgFightReq(self._activityId, self._stageId, form)
	end

	self:setFightHandler(handler, nil)
end

function DivineXingJiangClgFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function DivineXingJiangClgFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

return DivineXingJiangClgFmtMo
