-- chunkname: @modules/logic/fight/mgr/FightEntrustDeadEntityMgr.lua

module("modules.logic.fight.mgr.FightEntrustDeadEntityMgr", package.seeall)

local FightEntrustDeadEntityMgr = class("FightEntrustDeadEntityMgr", FightBaseClass)

function FightEntrustDeadEntityMgr:onConstructor()
	self.entityDic = {}
	self.entityVisible = {}

	self:com_registFightEvent(FightEvent.EntrustEntity, self._onEntrustEntity)
	self:com_registFightEvent(FightEvent.OnRestartStageBefore, self._onRestartStageBefore)
	self:com_registFightEvent(FightEvent.OnSwitchPlaneClearAsset, self._onSwitchPlaneClearAsset)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self._onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish)
	self:com_registFightEvent(FightEvent.OnCameraFocusChanged, self._onCameraFocusChanged)
	self:com_registFightEvent(FightEvent.ReleaseAllEntrustedEntity, self._releaseAllEntity)
	self:com_registMsg(FightMsgId.GetDeadEntityMgr, self.onGetDeadEntityMgr)
end

function FightEntrustDeadEntityMgr:onGetDeadEntityMgr()
	self.com_replyMsg(self, FightMsgId.GetDeadEntityMgr, self)
end

function FightEntrustDeadEntityMgr:_onEntrustEntity(deadEntity)
	local entityId = deadEntity.id

	if self.entityDic[entityId] then
		self:_releaseEntity(self.entityDic[entityId])
	end

	self.entityDic[entityId] = deadEntity
	self.entityVisible[entityId] = 0

	local entityMO = deadEntity:getMO()
	local config = lua_fight_dead_entity_mgr.configDict[entityMO.skin]

	deadEntity.spine:play(config.loopActName, true, true)

	ZProj.TransformListener.Get(deadEntity.go).enabled = false
end

local filterTimeline = {
	["670403_die"] = true
}

function FightEntrustDeadEntityMgr:_onSkillPlayStart(entity, curSkillId, stepData, timelineName)
	if filterTimeline[timelineName] then
		return
	end

	for k, v in pairs(self.entityDic) do
		self.entityVisible[v.id] = (self.entityVisible[v.id] or 0) + 1

		v:setVisibleByPos(false)
	end
end

function FightEntrustDeadEntityMgr:_onSkillPlayFinish()
	for k, v in pairs(self.entityDic) do
		if self.entityVisible[v.id] then
			self.entityVisible[v.id] = self.entityVisible[v.id] - 1

			if self.entityVisible[v.id] < 0 then
				self.entityVisible[v.id] = 0
			end
		end

		if self.entityVisible[v.id] == 0 then
			v:setVisibleByPos(true)
			FightGameMgr.entityMgr:adjustSpineLookRotation(v)
		end
	end
end

function FightEntrustDeadEntityMgr:_onCameraFocusChanged(state)
	if state then
		self:_onSkillPlayStart()
	else
		self:_onSkillPlayFinish()
	end
end

function FightEntrustDeadEntityMgr:_releaseEntity(entity)
	self.entityDic[entity.id]:disposeSelf()

	self.entityDic[entity.id] = nil
	self.entityVisible[entity.id] = nil
end

function FightEntrustDeadEntityMgr:_releaseAllEntity()
	for k, entity in pairs(self.entityDic) do
		self:_releaseEntity(entity)
	end
end

function FightEntrustDeadEntityMgr:_onRestartStageBefore()
	self:_releaseAllEntity()
end

function FightEntrustDeadEntityMgr:_onSwitchPlaneClearAsset()
	self:_releaseAllEntity()
end

function FightEntrustDeadEntityMgr:onDestructor()
	self:_releaseAllEntity()
end

return FightEntrustDeadEntityMgr
