-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/model/GodLongYanCustomFmtMo.lua

module("logic.extensions.godlongyan.model.GodLongYanCustomFmtMo", package.seeall)

local GodLongYanCustomFmtMo = class("GodLongYanCustomFmtMo", ICustomFmtMo)

function GodLongYanCustomFmtMo:initParams(challengeId, cfgEnemy)
	self._challengeId = challengeId
	self._cfgEnemy = cfgEnemy
	self._totalLevelCount = totalLevelCount
	self._masterList = GodLongYanConfig.instance:getCreepsMasterList(self._cfgEnemy.creepsMasterId)
end

function GodLongYanCustomFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.winRule1
	self.isShowBtnFormation = true

	self:setFormCondition(self._cfgEnemy.formCondition)
end

function GodLongYanCustomFmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

function GodLongYanCustomFmtMo:initFightHandler()
	local function handler()
		local raceId
		local cfg = EvolveConfig.instance:getDivineEvolveCfgByChallengeId(self._challengeId)

		if cfg then
			raceId = cfg.raceId
		end

		UIJumper.instance:pushOneStack(ViewName.DivineEvolveEnterView, true)
		UIJumper.instance:pushOneStack(ViewName.DivineEvolveMainView, true, raceId)
		UIJumper.instance:pushOneStack(ViewName.LongYanSQMainView, true, self._challengeId)
		UIJumper.instance:pushOneStack(ViewName.LongYanSQLevelView, true, self._challengeId)
		BattleFacade.instance:startLongyanSQFight()
		GodLongYanAgent.instance:sendPM_GodLongYanChallengeFightReq()
	end

	self:setFightHandler(handler, nil)
end

function GodLongYanCustomFmtMo:refreshPetList(changePetMoMap)
	print(">>>>>> GodLongYanCustomFmtMo 更新 列表 ")

	for petId, petMo in pairs(changePetMoMap) do
		local mo = petMo:GetClone()

		mo.attrMo:resetPublicAttr()
		mo.attrMo:calcTotalAttrs()
		mo:refreshAllAttr()
		self:updatePetMo(mo)
	end
end

function GodLongYanCustomFmtMo:initPetList()
	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		local mo = petMo:GetClone()

		mo.attrMo:resetPublicAttr()
		mo.attrMo:calcTotalAttrs()
		mo:refreshAllAttr()
		self:addPetToList(mo)
	end
end

function GodLongYanCustomFmtMo:getMonsterConfigList()
	return self._masterList
end

function GodLongYanCustomFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

return GodLongYanCustomFmtMo
