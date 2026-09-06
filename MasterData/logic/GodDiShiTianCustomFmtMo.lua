-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddishitian/model/GodDiShiTianCustomFmtMo.lua

module("logic.extensions.goddishitian.model.GodDiShiTianCustomFmtMo", package.seeall)

local GodDiShiTianCustomFmtMo = class("GodDiShiTianCustomFmtMo", ICustomFmtMo)

function GodDiShiTianCustomFmtMo:onReset()
	GodDiShiTianCustomFmtMo.super.onReset(self)
end

function GodDiShiTianCustomFmtMo:initParams(challengeId, cfgEnemy, stageType, enterType)
	self._challengeId = challengeId
	self._cfgEnemy = cfgEnemy
	self._stageType = stageType
	self._enterType = enterType
	self._masterList = GodDiShiTianConfig.instance:getCreeps(self._cfgEnemy.creepsMasterId)

	if self._cfgEnemy.btlType > 0 then
		self._btlType = self._cfgEnemy.btlType or 1
	end

	self.isShowBtnCutePet = self._btlType ~= 1
end

function GodDiShiTianCustomFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.description or ""
	self.isShowBtnFormation = false
	self.isShowMaxBuffFormLv = self._btlType == 1

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:_setFmtData()
	self:initPetList()
end

function GodDiShiTianCustomFmtMo:initFormationMo()
	self.formationMo = FormationMO.New(GameUtil.handler(self.getPetMoById, self))

	self:_setFmtData()
end

function GodDiShiTianCustomFmtMo:_setFmtData()
	if self.formationMo then
		local simpleForm = GodDiShiTianModel.instance:getSimpleForm()

		if simpleForm then
			self.formationMo:SetData(simpleForm)
		end
	end
end

function GodDiShiTianCustomFmtMo:initFightHandler()
	local function handler()
		local raceId
		local cfg = EvolveConfig.instance:getDivineEvolveCfgByChallengeId(self._challengeId)

		if self._enterType == 1 then
			UIJumper.instance:pushOneStack(ViewName.DivineEvolveEnterView, true)
			UIJumper.instance:pushOneStack(ViewName.DivineEvolveMainView, true, (cfg or nil) and cfg.raceId)
		else
			UIJumper.instance:pushOneStack(ViewName.ZhiHuiJiaZuHudView, true)
		end

		printInfo("test 开始战斗", self._cfgEnemy.winId)
		BattleFacade.instance:startDishitianSQFight(self._cfgEnemy.winId)

		local simpleForm = self:getCurSimpleForm()

		GodDiShiTianAgent.instance:sendPM_GodDiShiTianChallengeReq(self._cfgEnemy.creepsMasterId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function GodDiShiTianCustomFmtMo:getMonsterConfigList()
	return self._masterList
end

function GodDiShiTianCustomFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function GodDiShiTianCustomFmtMo:initPetList()
	self:clearAllPetList()

	if self._btlType == 1 then
		local bagPetMoList = self:_getMaxInfoPetList()

		for _, petMo in pairs(bagPetMoList) do
			self:addPetToList(petMo)
		end
	else
		local bagPetMoList = BagPetsController.instance:getFightBagPet()

		for _, petMo in pairs(bagPetMoList) do
			local mo = petMo:GetClone()

			mo.attrMo:resetPublicAttr()
			mo.attrMo:calcTotalAttrs()
			mo:refreshAllAttr()
			self:addPetToList(mo)
		end
	end
end

function GodDiShiTianCustomFmtMo:_getMaxInfoPetList()
	local pets = BagPetsController.instance:getFightBagPet()
	local list = {}

	ArraySort.sortOn(pets, function(mo)
		return (mo:getFightingPower())
	end, ArraySort.DESCENDING)

	for k, v in pairs(pets) do
		local mo = FightingPowerPetMo.getMaxPetMoByData(v)

		table.insert(list, mo)
	end

	return list
end

return GodDiShiTianCustomFmtMo
