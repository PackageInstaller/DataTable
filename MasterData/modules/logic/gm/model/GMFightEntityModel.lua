-- chunkname: @modules/logic/gm/model/GMFightEntityModel.lua

module("modules.logic.gm.model.GMFightEntityModel", package.seeall)

local GMFightEntityModel = class("GMFightEntityModel", ListScrollModel)

function GMFightEntityModel:ctor()
	GMFightEntityModel.super.ctor(self)

	self.entityMO = nil
	self.buffModel = ListScrollModel.New()
	self.skillModel = ListScrollModel.New()
	self.attrModel = ListScrollModel.New()
end

function GMFightEntityModel:onOpen()
	local list = {}

	FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide, list, true)
	FightDataHelper.entityMgr:getSubList(FightEnum.EntitySide.MySide, list, true)
	FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide, list, true)
	FightDataHelper.entityMgr:getMyPlayerList(list, true)

	local assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	if assistBoss then
		table.insert(list, assistBoss)
	end

	local asfdEmitter = FightDataHelper.entityMgr:getASFDEntityMo(FightEnum.EntitySide.MySide)

	if asfdEmitter then
		table.insert(list, asfdEmitter)
	end

	local vorpalith = FightDataHelper.entityMgr:getVorpalith()

	if vorpalith then
		table.insert(list, vorpalith)
	end

	FightDataHelper.entityMgr:getMySpFightEntities(list, true)
	FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.EnemySide, list, true)
	FightDataHelper.entityMgr:getSubList(FightEnum.EntitySide.EnemySide, list, true)
	FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.EnemySide, list, true)
	FightDataHelper.entityMgr:getEnemyPlayerList(list, true)

	asfdEmitter = FightDataHelper.entityMgr:getASFDEntityMo(FightEnum.EntitySide.EnemySide)

	if asfdEmitter then
		table.insert(list, asfdEmitter)
	end

	self:setList(list)
end

function GMFightEntityModel:_addList(list, entityModel)
	for _, entityMO in ipairs(entityModel:getList()) do
		table.insert(list, entityMO)
	end
end

function GMFightEntityModel:setEntityMO(entityMO)
	self.entityMO = entityMO

	self.buffModel:setList(entityMO:getBuffList())

	local skillCOList = {}

	for _, skillId in ipairs(entityMO.skillList) do
		local skillCO = lua_skill.configDict[skillId]

		if skillCO then
			table.insert(skillCOList, skillCO)
		end
	end

	self.skillModel:setList(skillCOList)
	self:setEntityDetailInfo(entityMO)
end

function GMFightEntityModel:onGetSingleEntityInfo(msg)
	self:setEntityMO(self.entityMO)
end

function GMFightEntityModel:onGetEntityDetailInfos(msg)
	self._attrEntityList = {}
	self._attrEntityDict = {}

	for _, one in ipairs(msg.teamAInfos) do
		table.insert(self._attrEntityList, one)

		self._attrEntityDict[one.info.uid] = one
	end

	for _, one in ipairs(msg.teamBInfos) do
		table.insert(self._attrEntityList, one)

		self._attrEntityDict[one.info.uid] = one
	end

	self:setEntityDetailInfo(self.entityMO)
end

function GMFightEntityModel:setEntityDetailInfo(entityMO)
	if not entityMO then
		return
	end

	if self._attrEntityDict then
		local detailInfo = self._attrEntityDict[entityMO.id]

		if not detailInfo then
			return
		end

		local info = detailInfo.info.attr
		local exAttr = detailInfo.exAttr
		local spAttr = detailInfo.spAttr
		local addAttrPer = detailInfo.addAttrPer
		local addExAttr = detailInfo.addExAttr
		local addSpAttr = detailInfo.addSpAttr
		local testAddAttrPer = detailInfo.testAddAttrPer
		local testAddExAttr = detailInfo.testAddExAttr
		local testAddSpAttr = detailInfo.testAddSpAttr
		local partAttrBase = detailInfo.partAttrBase
		local partExAttr = detailInfo.partExAttr
		local partSpAttr = detailInfo.partSpAttr
		local testPartAttrBase = detailInfo.testPartAttrBase
		local testPartExAttr = detailInfo.testPartExAttr
		local testPartSpAttr = detailInfo.testPartSpAttr
		local finalAttrBase = detailInfo.finalAttrBase
		local finalExAttr = detailInfo.finalExAttr
		local finalSpAttr = detailInfo.finalSpAttr
		local list = {}

		table.insert(list, self:getAttrMo(101, info.hp, addAttrPer.hp, testAddAttrPer.hp, partAttrBase.hp, testPartAttrBase.hp, finalAttrBase.hp))
		table.insert(list, self:getAttrMo(102, info.attack, addAttrPer.attack, testAddAttrPer.attack, partAttrBase.attack, testPartAttrBase.attack, finalAttrBase.attack))
		table.insert(list, self:getAttrMo(103, info.defense, addAttrPer.defense, testAddAttrPer.defense, partAttrBase.defense, testPartAttrBase.defense, finalAttrBase.defense))
		table.insert(list, self:getAttrMo(104, info.mdefense, addAttrPer.mdefense, testAddAttrPer.mdefense, partAttrBase.mdefense, testPartAttrBase.mdefense, finalAttrBase.mdefense))
		table.insert(list, self:getAttrMo(105, info.technic, addAttrPer.technic, testAddAttrPer.technic, partAttrBase.technic, testPartAttrBase.technic, finalAttrBase.technic))
		table.insert(list, self:getAttrMo(201, exAttr.cri, addExAttr.cri, testAddExAttr.cri, partExAttr.cri, testPartExAttr.cri, finalExAttr.cri))
		table.insert(list, self:getAttrMo(202, exAttr.recri, addExAttr.recri, testAddExAttr.recri, partExAttr.recri, testPartExAttr.recri, finalExAttr.recri))
		table.insert(list, self:getAttrMo(203, exAttr.criDmg, addExAttr.criDmg, testAddExAttr.criDmg, partExAttr.criDmg, testPartExAttr.criDmg, finalExAttr.criDmg))
		table.insert(list, self:getAttrMo(204, exAttr.criDef, addExAttr.criDef, testAddExAttr.criDef, partExAttr.criDef, testPartExAttr.criDef, finalExAttr.criDef))
		table.insert(list, self:getAttrMo(205, exAttr.addDmg, addExAttr.addDmg, testAddExAttr.addDmg, partExAttr.addDmg, testPartExAttr.addDmg, finalExAttr.addDmg))
		table.insert(list, self:getAttrMo(206, exAttr.dropDmg, addExAttr.dropDmg, testAddExAttr.dropDmg, partExAttr.dropDmg, testPartExAttr.dropDmg, finalExAttr.dropDmg))
		table.insert(list, self:getAttrMo(207, spAttr.finalAddDmg, addSpAttr.finalAddDmg, testAddSpAttr.finalAddDmg, partSpAttr.finalAddDmg, testPartSpAttr.finalAddDmg, finalSpAttr.finalAddDmg))
		table.insert(list, self:getAttrMo(208, spAttr.finalDropDmg, addSpAttr.finalDropDmg, testAddSpAttr.finalDropDmg, partSpAttr.finalDropDmg, testPartSpAttr.finalDropDmg, finalSpAttr.finalDropDmg))
		table.insert(list, self:getAttrMo(209, spAttr.revive, addSpAttr.revive, testAddSpAttr.revive, partSpAttr.revive, testPartSpAttr.revive, finalSpAttr.revive))
		table.insert(list, self:getAttrMo(210, spAttr.absorb, addSpAttr.absorb, testAddSpAttr.absorb, partSpAttr.absorb, testPartSpAttr.absorb, finalSpAttr.absorb))
		table.insert(list, self:getAttrMo(211, spAttr.clutch, addSpAttr.clutch, testAddSpAttr.clutch, partSpAttr.clutch, testPartSpAttr.clutch, finalSpAttr.clutch))
		table.insert(list, self:getAttrMo(212, spAttr.heal, addSpAttr.heal, testAddSpAttr.heal, partSpAttr.heal, testPartSpAttr.heal, finalSpAttr.heal))
		table.insert(list, self:getAttrMo(213, spAttr.defenseIgnore, addSpAttr.defenseIgnore, testAddSpAttr.defenseIgnore, partSpAttr.defenseIgnore, testPartSpAttr.defenseIgnore, finalSpAttr.defenseIgnore))
		table.insert(list, self:getAttrMo(214, spAttr.normalSkillRate, addSpAttr.normalSkillRate, testAddSpAttr.normalSkillRate, partSpAttr.normalSkillRate, testPartSpAttr.normalSkillRate, finalSpAttr.normalSkillRate))
		table.insert(list, self:getAttrMo(215, spAttr.playAddRate, addSpAttr.playAddRate, testAddSpAttr.playAddRate, partSpAttr.playAddRate, testPartSpAttr.playAddRate, finalSpAttr.playAddRate))
		table.insert(list, self:getAttrMo(216, spAttr.playDropRate, addSpAttr.playDropRate, testAddSpAttr.playDropRate, partSpAttr.playDropRate, testPartSpAttr.playDropRate, finalSpAttr.playDropRate))
		table.insert(list, self:getAttrMo(218, spAttr.reboundDmg, addSpAttr.reboundDmg, testAddSpAttr.reboundDmg, partSpAttr.reboundDmg, testPartSpAttr.reboundDmg, finalSpAttr.reboundDmg))
		table.insert(list, self:getAttrMo(219, spAttr.extraDmg, addSpAttr.extraDmg, testAddSpAttr.extraDmg, partSpAttr.extraDmg, testPartSpAttr.extraDmg, finalSpAttr.extraDmg))
		table.insert(list, self:getAttrMo(220, spAttr.reuseDmg, addSpAttr.reuseDmg, testAddSpAttr.reuseDmg, partSpAttr.reuseDmg, testPartSpAttr.reuseDmg, finalSpAttr.reuseDmg))
		table.insert(list, self:getAttrMo(221, spAttr.bigSkillRate, addSpAttr.bigSkillRate, testAddSpAttr.bigSkillRate, partSpAttr.bigSkillRate, testPartSpAttr.bigSkillRate, finalSpAttr.bigSkillRate))
		table.insert(list, self:getAttrMo(222, spAttr.clutchDmg, addSpAttr.clutchDmg, testAddSpAttr.clutchDmg, partSpAttr.clutchDmg, testPartSpAttr.clutchDmg, finalSpAttr.clutchDmg))
		table.insert(list, self:getAttrMo(401, spAttr.dizzyResistances, addSpAttr.dizzyResistances, testAddSpAttr.dizzyResistances, partSpAttr.dizzyResistances, testPartSpAttr.dizzyResistances, finalSpAttr.dizzyResistances))
		table.insert(list, self:getAttrMo(402, spAttr.sleepResistances, addSpAttr.sleepResistances, testAddSpAttr.sleepResistances, partSpAttr.sleepResistances, testPartSpAttr.sleepResistances, finalSpAttr.sleepResistances))
		table.insert(list, self:getAttrMo(403, spAttr.petrifiedResistances, addSpAttr.petrifiedResistances, testAddSpAttr.petrifiedResistances, partSpAttr.petrifiedResistances, testPartSpAttr.petrifiedResistances, finalSpAttr.petrifiedResistances))
		table.insert(list, self:getAttrMo(404, spAttr.frozenResistances, addSpAttr.frozenResistances, testAddSpAttr.frozenResistances, partSpAttr.frozenResistances, testPartSpAttr.frozenResistances, finalSpAttr.frozenResistances))
		table.insert(list, self:getAttrMo(405, spAttr.disarmResistances, addSpAttr.disarmResistances, testAddSpAttr.disarmResistances, partSpAttr.disarmResistances, testPartSpAttr.disarmResistances, finalSpAttr.disarmResistances))
		table.insert(list, self:getAttrMo(406, spAttr.forbidResistances, addSpAttr.forbidResistances, testAddSpAttr.forbidResistances, partSpAttr.forbidResistances, testPartSpAttr.forbidResistances, finalSpAttr.forbidResistances))
		table.insert(list, self:getAttrMo(407, spAttr.sealResistances, addSpAttr.sealResistances, testAddSpAttr.sealResistances, partSpAttr.sealResistances, testPartSpAttr.sealResistances, finalSpAttr.sealResistances))
		table.insert(list, self:getAttrMo(408, spAttr.cantGetExskillResistances, addSpAttr.cantGetExskillResistances, testAddSpAttr.cantGetExskillResistances, partSpAttr.cantGetExskillResistances, testPartSpAttr.cantGetExskillResistances, finalSpAttr.cantGetExskillResistances))
		table.insert(list, self:getAttrMo(409, spAttr.delExPointResistances, addSpAttr.delExPointResistances, testAddSpAttr.delExPointResistances, partSpAttr.delExPointResistances, testPartSpAttr.delExPointResistances, finalSpAttr.delExPointResistances))
		table.insert(list, self:getAttrMo(410, spAttr.stressUpResistances, addSpAttr.stressUpResistances, testAddSpAttr.stressUpResistances, partSpAttr.stressUpResistances, testPartSpAttr.stressUpResistances, finalSpAttr.stressUpResistances))
		table.insert(list, self:getAttrMo(411, spAttr.charmResistances, addSpAttr.charmResistances, testAddSpAttr.charmResistances, partSpAttr.charmResistances, testPartSpAttr.charmResistances, finalSpAttr.charmResistances))
		table.insert(list, self:getAttrMo(501, spAttr.controlResilience, addSpAttr.controlResilience, testAddSpAttr.controlResilience, partSpAttr.controlResilience, testPartSpAttr.controlResilience, finalSpAttr.controlResilience))
		table.insert(list, self:getAttrMo(502, spAttr.delExPointResilience, addSpAttr.delExPointResilience, testAddSpAttr.delExPointResilience, partSpAttr.delExPointResilience, testPartSpAttr.delExPointResilience, finalSpAttr.delExPointResilience))
		table.insert(list, self:getAttrMo(503, spAttr.stressUpResilience, addSpAttr.stressUpResilience, testAddSpAttr.stressUpResilience, partSpAttr.stressUpResilience, testPartSpAttr.stressUpResilience, finalSpAttr.stressUpResilience))
		self.attrModel:setList(list)
	end
end

function GMFightEntityModel:getAttrMo(id, base, add, test, partAdd, partTest, final)
	self.attrPool = self.attrPool or {}

	local attrMo = self.attrPool[id]

	if not attrMo then
		attrMo = {
			id = id
		}
		self.attrPool[id] = attrMo
	end

	attrMo.base = base
	attrMo.add = add
	attrMo.test = test
	attrMo.partAdd = partAdd
	attrMo.partTest = partTest
	attrMo.final = final

	return attrMo
end

function GMFightEntityModel:onGetGMFightTeamDetailInfos(msg)
	self.myTeamRuleList = {}

	for _, ruleId in ipairs(msg.teamAInfos.ruleSkill) do
		table.insert(self.myTeamRuleList, ruleId)
	end

	self.enemyTeamRuleList = {}

	for _, ruleId in ipairs(msg.teamBInfos.ruleSkill) do
		table.insert(self.enemyTeamRuleList, ruleId)
	end
end

GMFightEntityModel.instance = GMFightEntityModel.New()

return GMFightEntityModel
