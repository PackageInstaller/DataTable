-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/mgr/TravelGoEntityMgr.lua

module("modules.logic.versionactivity3_7.travelgo.battle.mgr.TravelGoEntityMgr", package.seeall)

local TravelGoEntityMgr = class("TravelGoEntityMgr", TravelGoBase)

function TravelGoEntityMgr:ctor()
	TravelGoEntityMgr.super.ctor(self)

	self.uid = 0
	self.playerEntity = nil
	self.enemyEntityList = {}
	self.npcEntityDic = {}
end

function TravelGoEntityMgr:onDisable()
	return
end

function TravelGoEntityMgr:onDispose()
	if self.playerEntity then
		self.playerEntity:dispose()

		self.playerEntity = nil
	end
end

function TravelGoEntityMgr:createPlayerEntity()
	self.uid = self.uid + 1
	self.playerEntity = TravelGoPlayerEntity.New(self.uid, TravelGoBattleEnum.EntityType.Player)

	self.playerEntity:awake(true)

	return self.playerEntity
end

function TravelGoEntityMgr:createEnemyEntity(cfgId)
	self.uid = self.uid + 1

	local enemyEntity = TravelGoEntity.New(self.uid, cfgId, TravelGoBattleEnum.EntityType.Enemy)

	enemyEntity:awake(true)
	table.insert(self.enemyEntityList, enemyEntity)
	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnCreateEntity, enemyEntity)

	return enemyEntity
end

function TravelGoEntityMgr:createNpcEntity(cfgId)
	self.uid = self.uid + 1

	local npcEntity = TravelGoEntity.New(self.uid, cfgId, TravelGoBattleEnum.EntityType.Npc)

	npcEntity:awake(true)

	self.npcEntityDic[self.uid] = npcEntity

	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnCreateEntity, npcEntity)

	return npcEntity
end

function TravelGoEntityMgr:removeEnemy(uid)
	for i, v in pairs(self.enemyEntityList) do
		if v.uid == uid then
			v:dispose()

			self.enemyEntityList[i] = nil

			TravelGoController.instance:dispatchEvent(TravelGoEvent.OnRemoveEntity, uid)

			break
		end
	end
end

function TravelGoEntityMgr:removeNpc(uid)
	for i, v in pairs(self.npcEntityDic) do
		if v.uid == uid then
			v:dispose()

			self.npcEntityDic[i] = nil

			break
		end
	end
end

return TravelGoEntityMgr
