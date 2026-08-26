-- chunkname: @modules/logic/fight/mgr/FightEntrustEntityMgr.lua

module("modules.logic.fight.mgr.FightEntrustEntityMgr", package.seeall)

local FightEntrustEntityMgr = class("FightEntrustEntityMgr", FightBaseClass)

function FightEntrustEntityMgr:onConstructor()
	self.entityDic = {}
	self.entityVisible = {}

	self:com_registFightEvent(FightEvent.EntrustTempEntity, self._onEntrustTempEntity)
	self:com_registFightEvent(FightEvent.OnRestartStageBefore, self._onRestartStageBefore)
	self:com_registFightEvent(FightEvent.OnSwitchPlaneClearAsset, self._onSwitchPlaneClearAsset)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self._onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish)
	self:com_registFightEvent(FightEvent.OnCameraFocusChanged, self._onCameraFocusChanged)
	self:com_registFightEvent(FightEvent.ReleaseAllEntrustedEntity, self._releaseAllEntity)
end

function FightEntrustEntityMgr:_onEntrustTempEntity(tempEntity)
	local entityId = tempEntity.id

	if self.entityDic[entityId] then
		self:_releaseEntity(self.entityDic[entityId])
	end

	self.entityDic[entityId] = tempEntity
	self.entityVisible[entityId] = 0

	tempEntity.spine:play(tempEntity.spine._curAnimState, true)
end

function FightEntrustEntityMgr:_onSkillPlayStart()
	for k, v in pairs(self.entityDic) do
		self.entityVisible[v.id] = (self.entityVisible[v.id] or 0) + 1

		v:setVisibleByPos(false)
	end
end

function FightEntrustEntityMgr:_onSkillPlayFinish()
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

function FightEntrustEntityMgr:_onCameraFocusChanged(state)
	if state then
		self:_onSkillPlayStart()
	else
		self:_onSkillPlayFinish()
	end
end

function FightEntrustEntityMgr:_releaseEntity(entity)
	self.entityDic[entity.id]:disposeSelf()

	self.entityDic[entity.id] = nil
	self.entityVisible[entity.id] = nil
end

function FightEntrustEntityMgr:_releaseAllEntity()
	for k, entity in pairs(self.entityDic) do
		self:_releaseEntity(entity)
	end
end

function FightEntrustEntityMgr:_onRestartStageBefore()
	self:_releaseAllEntity()
end

function FightEntrustEntityMgr:_onSwitchPlaneClearAsset()
	self:_releaseAllEntity()
end

function FightEntrustEntityMgr:onDestructor()
	self:_releaseAllEntity()
end

return FightEntrustEntityMgr
