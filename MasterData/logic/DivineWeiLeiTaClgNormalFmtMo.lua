-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/model/DivineWeiLeiTaClgNormalFmtMo.lua

module("logic.extensions.divineweileitaclg.model.DivineWeiLeiTaClgNormalFmtMo", package.seeall)

local DivineWeiLeiTaClgNormalFmtMo = class("DivineWeiLeiTaClgNormalFmtMo", BaseCustomFmtMo)

function DivineWeiLeiTaClgNormalFmtMo:initParams(activityId, creepMasterId)
	self.activityId = activityId
	self._creepMasterId = creepMasterId
	self._cfgEnemy = DivineWeiLeiTaClgConfig.instance:getTeamCfg(self._creepMasterId)
	self._masterList = DivineWeiLeiTaClgConfig.instance:getCreepsCfg(self._creepMasterId)
	self.useMaxFightPower = true
end

function DivineWeiLeiTaClgNormalFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.winDesc
	self.validatorDescStr = self._cfgEnemy.bottomDesc
	self.isSetEnemySimpleForm = true

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function DivineWeiLeiTaClgNormalFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:pushOneStack(ViewName.DivineWeiLeiTaClgMainView, true, self.activityId)
		UIJumper.instance:pushOneStack(ViewName.DivineWeiLeiTaClgNormalView, true, self.activityId)
		UIJumper.instance:pushOneStack(ViewName.DivineWeiLeiTaClgDamageView, true, self.activityId)

		local simpleForm = self:getCurSimpleForm()

		DivineWeiLeiTaClgAgent.instance:sendPM_DivineWeiLeiTaClgNormalChallengeReq(self.activityId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineWeiLeiTaClgNormalFmtMo:getMonsterConfigList()
	return self._masterList
end

function DivineWeiLeiTaClgNormalFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

return DivineWeiLeiTaClgNormalFmtMo
