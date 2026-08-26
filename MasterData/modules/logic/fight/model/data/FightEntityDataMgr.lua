-- chunkname: @modules/logic/fight/model/data/FightEntityDataMgr.lua

module("modules.logic.fight.model.data.FightEntityDataMgr", package.seeall)

local FightEntityDataMgr = FightDataClass("FightEntityDataMgr", FightDataMgrBase)
local listType = {
	normal = "normal",
	assistBoss = "assistBoss",
	ASFD_emitter = "ASFD_emitter",
	sp = "sp",
	sub = "sub",
	vorpalith = "vorpalith",
	spFightEntities = "spFightEntities",
	player = "player"
}

function FightEntityDataMgr:onConstructor()
	self.entityDataDic = {}
	self.sideDic = {}

	local sideType = {
		FightEnum.EntitySide.MySide,
		FightEnum.EntitySide.EnemySide
	}

	for i, side in ipairs(sideType) do
		self.sideDic[side] = {}

		for k, v in pairs(listType) do
			self.sideDic[side][v] = {}
		end
	end

	self.deadUids = {}
	self.heroId2SkinId = {}
end

local TempMoList = {}

function FightEntityDataMgr:getAllEntityList(returnList, includeDead)
	returnList = returnList or {}

	for _, type in pairs(listType) do
		self:getList(FightEnum.EntitySide.MySide, type, returnList, includeDead)
		self:getList(FightEnum.EntitySide.EnemySide, type, returnList, includeDead)
	end

	return returnList
end

function FightEntityDataMgr:getSideList(side, returnList, includeDead)
	local list = returnList or {}

	for k, v in pairs(listType) do
		self:getList(side, v, list, includeDead)
	end

	return list
end

function FightEntityDataMgr:getPlayerList(side, returnList, includeDead)
	return self:getList(side, listType.player, returnList, includeDead)
end

function FightEntityDataMgr:getMyPlayerList(returnList, includeDead)
	return self:getList(FightEnum.EntitySide.MySide, listType.player, returnList, includeDead)
end

function FightEntityDataMgr:getEnemyPlayerList(returnList, includeDead)
	return self:getList(FightEnum.EntitySide.EnemySide, listType.player, returnList, includeDead)
end

function FightEntityDataMgr:getMyVertin()
	return self:getMyPlayerList()[1]
end

function FightEntityDataMgr:getEnemyVertin()
	return self:getEnemyPlayerList()[1]
end

function FightEntityDataMgr:getNormalList(side, returnList, includeDead)
	return self:getList(side, listType.normal, returnList, includeDead)
end

function FightEntityDataMgr:getMyNormalList(returnList, includeDead)
	return self:getList(FightEnum.EntitySide.MySide, listType.normal, returnList, includeDead)
end

function FightEntityDataMgr:getEnemyNormalList(returnList, includeDead)
	local list = self:getList(FightEnum.EntitySide.EnemySide, listType.normal, returnList, includeDead)

	table.sort(list, FightHelper.sortAssembledMonsterFunc)

	return list
end

function FightEntityDataMgr:getSubList(side, returnList, includeDead)
	return self:getList(side, listType.sub, returnList, includeDead)
end

function FightEntityDataMgr:getMySubList(returnList, includeDead)
	return self:getList(FightEnum.EntitySide.MySide, listType.sub, returnList, includeDead)
end

function FightEntityDataMgr:getEnemySubList(returnList, includeDead)
	return self:getList(FightEnum.EntitySide.EnemySide, listType.sub, returnList, includeDead)
end

function FightEntityDataMgr:getSpList(side, returnList, includeDead)
	return self:getList(side, listType.sp, returnList, includeDead)
end

function FightEntityDataMgr:getMySpList(returnList, includeDead)
	return self:getList(FightEnum.EntitySide.MySide, listType.sp, returnList, includeDead)
end

function FightEntityDataMgr:getEnemySpList(returnList, includeDead)
	return self:getList(FightEnum.EntitySide.EnemySide, listType.sp, returnList, includeDead)
end

function FightEntityDataMgr:getAssistBoss()
	return self.sideDic[FightEnum.EntitySide.MySide][listType.assistBoss][1]
end

function FightEntityDataMgr:getVorpalith()
	return self.sideDic[FightEnum.EntitySide.MySide][listType.vorpalith][1]
end

function FightEntityDataMgr:getRouge2Music()
	local list = self.sideDic[FightEnum.EntitySide.MySide][listType.spFightEntities]

	for _, mo in ipairs(list) do
		if mo.entityType == FightEnum.EntityType.Rouge2Music then
			return mo
		end
	end
end

function FightEntityDataMgr:getASFDEntityMo(side)
	local sideDict = self.sideDic[side]
	local list = sideDict and sideDict[listType.ASFD_emitter]

	return list and list[1]
end

function FightEntityDataMgr:getDeadList(side, returnList)
	local list = returnList or {}

	for k, entityMO in pairs(self.entityDataDic) do
		if entityMO.side == side and entityMO:isStatusDead() then
			table.insert(list, entityMO)
		end
	end

	return list
end

function FightEntityDataMgr:getMyDeadList(returnList)
	return self:getDeadList(FightEnum.EntitySide.MySide, returnList)
end

function FightEntityDataMgr:getEnemyDeadList(side, returnList)
	return self:getDeadList(FightEnum.EntitySide.EnemySide, returnList)
end

function FightEntityDataMgr:getSpFightEntities(side, returnList, includeDead)
	return self:getList(side, listType.spFightEntities, returnList, includeDead)
end

function FightEntityDataMgr:getMySpFightEntities(returnList, includeDead)
	return self:getSpFightEntities(FightEnum.EntitySide.MySide, returnList, includeDead)
end

function FightEntityDataMgr:getEnemySpFightEntities(returnList, includeDead)
	return self:getSpFightEntities(FightEnum.EntitySide.EnemySide, returnList, includeDead)
end

function FightEntityDataMgr:getList(side, key, returnList, includeDead)
	local list = returnList or {}

	for i, v in ipairs(self.sideDic[side][key]) do
		if not ((v:isStatusDead() and not includeDead or nil) and true) then
			table.insert(list, v)
		end
	end

	return list
end

function FightEntityDataMgr:getOriginSide(side)
	return self.sideDic[side]
end

function FightEntityDataMgr:getOriginNormalList(side)
	return self.sideDic[side][listType.normal]
end

function FightEntityDataMgr:getOriginSubList(side)
	return self.sideDic[side][listType.sub]
end

function FightEntityDataMgr:getOriginSpList(side)
	return self.sideDic[side][listType.sp]
end

function FightEntityDataMgr:getOriginASFDEmitterList(side)
	return self.sideDic[side][listType.ASFD_emitter]
end

function FightEntityDataMgr:getOriginListById(entityId)
	local entityMO = self:getById(entityId)

	if entityMO then
		local side = entityMO.side
		local sideDic = self.sideDic[side]

		for k, list in pairs(sideDic) do
			for i, tarEntityMO in ipairs(list) do
				if tarEntityMO.uid == entityMO.uid then
					return list
				end
			end
		end
	end

	return {}
end

function FightEntityDataMgr:isSub(id)
	for k, v in pairs(self.sideDic) do
		for i, entityMO in ipairs(v[listType.sub]) do
			if entityMO.id == id then
				return true
			end
		end
	end
end

function FightEntityDataMgr:isMySub(id)
	for i, entityMO in ipairs(self.sideDic[FightEnum.EntitySide.MySide][listType.sub]) do
		if entityMO.id == id then
			return true
		end
	end
end

function FightEntityDataMgr:isSp(id)
	for k, v in pairs(self.sideDic) do
		for i, entityMO in ipairs(v[listType.sp]) do
			if entityMO.id == id then
				return true
			end
		end
	end
end

function FightEntityDataMgr:isAssistBoss(id)
	local assistBoss = self:getAssistBoss()

	return assistBoss and assistBoss.id == id
end

function FightEntityDataMgr:isAct191Boss(id)
	local entityData = self.entityDataDic[id]

	if not entityData then
		return false
	end

	if entityData.entityType == FightEnum.EntityType.Act191Boss then
		return true
	end
end

function FightEntityDataMgr:isMySp(id)
	for i, entityMO in ipairs(self.sideDic[FightEnum.EntitySide.MySide][listType.sp]) do
		if entityMO.id == id then
			return true
		end
	end
end

function FightEntityDataMgr:addDeadUid(uid)
	self.deadUids[uid] = true
end

function FightEntityDataMgr:isDeadUid(uid)
	return self.deadUids[uid]
end

function FightEntityDataMgr:removeEntity(uid)
	if not uid then
		return
	end

	local entityMo = self.entityDataDic[uid]

	if not entityMo then
		return
	end

	self.entityDataDic[uid] = nil

	for _, sideDict in pairs(self.sideDic) do
		for _, list in pairs(sideDict) do
			for index, _entityMo in ipairs(list) do
				if _entityMo.id == entityMo.id then
					table.remove(list, index)

					break
				end
			end
		end
	end

	return entityMo
end

function FightEntityDataMgr:getById(entityId)
	return self.entityDataDic[entityId]
end

function FightEntityDataMgr:getByPosId(side, position)
	for _, list in pairs(self.sideDic[side]) do
		for _, v in ipairs(list) do
			if not v:isStatusDead() and v.position == position then
				return v
			end
		end
	end
end

function FightEntityDataMgr:getOldEntityMO(id)
	local oldEntityMO = FightEntityMO.New()

	FightDataUtil.coverData(self:getById(id), oldEntityMO)

	return oldEntityMO
end

function FightEntityDataMgr:getAllEntityData()
	return self.entityDataDic
end

function FightEntityDataMgr:getAllEntityMO()
	return self.entityDataDic
end

function FightEntityDataMgr:addEntityMO(entityMO)
	return self:refreshEntityByEntityMO(entityMO)
end

function FightEntityDataMgr:replaceEntityMO(entityMO)
	return self:refreshEntityByEntityMO(entityMO)
end

function FightEntityDataMgr:refreshEntityByEntityMO(entityMO)
	local entityData = self.entityDataDic[entityMO.id]

	if not entityData then
		entityData = FightEntityMO.New()
		self.entityDataDic[entityMO.id] = entityData
	end

	FightEntityDataHelper.copyEntityMO(entityMO, entityData)

	if entityData:isASFDEmitter() then
		FightDataHelper.ASFDDataMgr:setEmitterEntityMo(entityData)
	end

	self.heroId2SkinId[entityData.modelId] = entityData.skin

	return entityData
end

function FightEntityDataMgr:addEntityMOByProto(proto, side)
	local entityMO = FightEntityMO.New()

	entityMO:init(proto, side)

	local version = FightModel.instance:getVersion()

	if version >= 4 then
		if entityMO:isStatusDead() then
			self:addDeadUid(entityMO.id)
		end
	elseif entityMO.currentHp <= 0 then
		entityMO:setDead()
		self:addDeadUid(entityMO.id)
	end

	return self:addEntityMO(entityMO)
end

function FightEntityDataMgr:initEntityListByProto(protoList, side, sideList)
	tabletool.clear(sideList)

	for i, v in ipairs(protoList) do
		table.insert(sideList, self:addEntityMOByProto(v, side))
	end
end

function FightEntityDataMgr:initOneEntityListByProto(proto, side, sideList)
	tabletool.clear(sideList)
	table.insert(sideList, self:addEntityMOByProto(proto, side))
end

function FightEntityDataMgr:onStageChanged(curStage, preStage)
	for _, entityMo in pairs(self.entityDataDic) do
		entityMo:onStageChanged(curStage, preStage)
	end
end

function FightEntityDataMgr:updateData(fightData)
	local mySide = self.sideDic[FightEnum.EntitySide.MySide]
	local enemySide = self.sideDic[FightEnum.EntitySide.EnemySide]

	if fightData.attacker.playerEntity then
		self:initOneEntityListByProto(fightData.attacker.playerEntity, FightEnum.EntitySide.MySide, mySide[listType.player])
	end

	self:initEntityListByProto(fightData.attacker.entitys, FightEnum.EntitySide.MySide, mySide[listType.normal])
	self:initEntityListByProto(fightData.attacker.subEntitys, FightEnum.EntitySide.MySide, mySide[listType.sub])
	self:initEntityListByProto(fightData.attacker.spEntitys, FightEnum.EntitySide.MySide, mySide[listType.sp])
	self:initEntityListByProto(fightData.attacker.spFightEntities, FightEnum.EntitySide.MySide, mySide[listType.spFightEntities])

	if fightData.attacker.assistBoss then
		self:initOneEntityListByProto(fightData.attacker.assistBoss, FightEnum.EntitySide.MySide, mySide[listType.assistBoss])
	end

	if fightData.attacker.emitter then
		self:initOneEntityListByProto(fightData.attacker.emitter, FightEnum.EntitySide.MySide, mySide[listType.ASFD_emitter])
	end

	if fightData.attacker.vorpalith then
		self:initOneEntityListByProto(fightData.attacker.vorpalith, FightEnum.EntitySide.MySide, mySide[listType.vorpalith])
	end

	if fightData.defender.playerEntity then
		self:initOneEntityListByProto(fightData.defender.playerEntity, FightEnum.EntitySide.EnemySide, enemySide[listType.player])
	end

	self:initEntityListByProto(fightData.defender.entitys, FightEnum.EntitySide.EnemySide, enemySide[listType.normal])
	self:initEntityListByProto(fightData.defender.subEntitys, FightEnum.EntitySide.EnemySide, enemySide[listType.sub])
	self:initEntityListByProto(fightData.defender.spEntitys, FightEnum.EntitySide.EnemySide, enemySide[listType.sp])
	self:initEntityListByProto(fightData.defender.spFightEntities, FightEnum.EntitySide.EnemySide, enemySide[listType.spFightEntities])

	if fightData.defender.emitter then
		self:initOneEntityListByProto(fightData.defender.emitter, FightEnum.EntitySide.EnemySide, enemySide[listType.ASFD_emitter])
	end
end

function FightEntityDataMgr:clientTestSetEntity(side, main, sub)
	self:clientSetEntityList(side, listType.normal, main)
	self:clientSetEntityList(side, listType.sub, sub)
end

function FightEntityDataMgr:clientSetEntityList(side, key, list)
	local originList = self.sideDic[side][key]

	tabletool.clear(originList)

	for i, v in ipairs(list) do
		local entityMO = self:addEntityMO(v)

		table.insert(originList, entityMO)
	end
end

function FightEntityDataMgr:clientSetSubEntityList(side, list)
	self:clientSetEntityList(side, listType.sub, list)
end

function FightEntityDataMgr:getHeroSkin(heroId)
	return self.heroId2SkinId[heroId]
end

function FightEntityDataMgr:getEntityMoByPos(posId)
	tabletool.clear(TempMoList)
	self:getMyNormalList(TempMoList)

	for _, entityMo in ipairs(TempMoList) do
		if entityMo.position == posId then
			return entityMo
		end
	end
end

function FightEntityDataMgr:checkSideHasBuffAct(side, buffActId)
	if side == FightEnum.EntitySide.BothSide then
		return self:_checkSideHasBuffAct(FightEnum.EntitySide.MySide, buffActId) or self:_checkSideHasBuffAct(FightEnum.EntitySide.EnemySide, buffActId)
	end

	return self:_checkSideHasBuffAct(side, buffActId)
end

function FightEntityDataMgr:_checkSideHasBuffAct(side, buffActId)
	local dict = self.sideDic[side]

	for _, list in pairs(dict) do
		for _, entityMo in ipairs(list) do
			if entityMo:hasBuffActId(buffActId) then
				return true
			end
		end
	end

	return false
end

return FightEntityDataMgr
