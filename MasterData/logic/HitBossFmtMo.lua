-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hitboss/model/HitBossFmtMo.lua

module("logic.extensions.hitboss.model.HitBossFmtMo", package.seeall)

local HitBossFmtMo = class("HitBossFmtMo", ICustomFmtMo)

function HitBossFmtMo:initParams(activityId, bossId)
	self._activityId = activityId
	self._bossId = bossId

	local monsterCfg = self:getFmtInfoConfig()

	self.topTitleStr = monsterCfg.name
	self.ruleDescStr = monsterCfg.WinDesc

	self:setFormCondition(monsterCfg.formCondition)
end

function HitBossFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:pushOneStack(ViewName.HitbossmainView)

		local form = self:getCurFormation():createFormPb()

		HitBossAgent.instance:sendPM_HitBossFightReq(self._activityId, form)
	end

	self:setFightHandler(handler)
end

function HitBossFmtMo:getMonsterConfigList()
	return HitbossConfig.instance:getCreepsList(self._bossId)
end

function HitBossFmtMo:getFmtInfoConfig()
	return HitbossConfig.instance:getMonsterCfg(self._bossId)
end

function HitBossFmtMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

return HitBossFmtMo
