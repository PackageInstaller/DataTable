-- chunkname: @modules/logic/fight/mgr/FightEntityEvolutionMgr.lua

module("modules.logic.fight.mgr.FightEntityEvolutionMgr", package.seeall)

local FightEntityEvolutionMgr = class("FightEntityEvolutionMgr", FightBaseClass)

function FightEntityEvolutionMgr:onConstructor()
	self._entityDic = {}
	self._entityVisible = {}
	self._skinId2Entity = {}
	self._skinIds = {}
	self._delayReleaseEntity = {}

	self:com_registMsg(FightMsgId.SetBossEvolution, self._onSetBossEvolution)
	self:com_registMsg(FightMsgId.PlayTimelineSkill, self._onPlayTimelineSkill)
	self:com_registMsg(FightMsgId.PlayTimelineSkillFinish, self._onPlayTimelineSkillFinish)
	self:com_registMsg(FightMsgId.CameraFocusChanged, self._onCameraFocusChanged)
	self:com_registMsg(FightMsgId.ReleaseAllEntrustedEntity, self._onReleaseAllEntrustedEntity)
	self:com_registMsg(FightMsgId.SpineLoadFinish, self._onSpineLoadFinish)
	self:com_registMsg(FightMsgId.IsEvolutionSkin, self._onIsEvolutionSkin)
	self:com_registFightEvent(FightEvent.BeforeDestroyEntity, self._onBeforeDestroyEntity)
end

function FightEntityEvolutionMgr:_onBeforeDestroyEntity(entity)
	if not entity then
		return
	end

	if self._entityDic[entity.id] == entity then
		self:_releaseEntity(entity)

		for i, tab in ipairs(self._delayReleaseEntity) do
			if tab.entity == entity then
				self._entityVisible[entity.id] = 0
			end
		end
	end
end

function FightEntityEvolutionMgr:_onIsEvolutionSkin(skinId)
	FightMsgMgr.replyMsg(FightMsgId.IsEvolutionSkin, self._skinIds[skinId])
end

function FightEntityEvolutionMgr:_onSetBossEvolution(tempEntity, skinId)
	local entityId = tempEntity.id

	if self._entityDic[entityId] and tempEntity ~= self._entityDic[entityId] then
		self:_releaseEntity(self._entityDic[entityId])
	end

	self._entityDic[entityId] = tempEntity
	self._entityVisible[entityId] = 0

	tempEntity.spine:play(tempEntity.spine._curAnimState, true)

	self._skinId2Entity[skinId] = self._skinId2Entity[skinId] or {}

	table.insert(self._skinId2Entity[skinId], tempEntity)

	self._skinIds[skinId] = true
end

function FightEntityEvolutionMgr:_onSpineLoadFinish(spine)
	local entity = spine.unitSpawn
	local entityMO = entity and entity:getMO()

	if entityMO and self._skinId2Entity[entityMO.skin] then
		for i, v in ipairs(self._skinId2Entity[entityMO.skin]) do
			local mainSpine = v.spine

			if mainSpine then
				::label_5_0::

				local var_5_0 = mainSpine._skeletonAnim

				if mainSpine._skeletonAnim then
					local curTrack = mainSpine._skeletonAnim.state:GetCurrent(0)

					if curTrack and spine._skeletonAnim then
						spine._skeletonAnim:Jump2Time(curTrack.TrackTime)
					end

					local tab = {}

					tab.entity = v

					local spineGO = spine:getSpineGO()

					tab.spineGO = spineGO

					transformhelper.setLocalPos(spineGO.transform, -10000, 0, 0)
					table.insert(self._delayReleaseEntity, tab)
				end
			end
		end

		self:com_registTimer(self._delayRelease, 0.01)

		self._skinId2Entity[entityMO.skin] = nil
	end
end

function FightEntityEvolutionMgr:_delayRelease()
	for i, v in ipairs(self._delayReleaseEntity) do
		self:_releaseEntity(v.entity)

		if not gohelper.isNil(v.spineGO) then
			transformhelper.setLocalPos(v.spineGO.transform, 0, 0, 0)
		end
	end

	self._delayReleaseEntity = {}
end

function FightEntityEvolutionMgr:_onPlayTimelineSkill()
	for k, v in pairs(self._entityDic) do
		if not v.IS_REMOVED then
			self._entityVisible[v.id] = (self._entityVisible[v.id] or 0) + 1

			v:setAlpha(0, 0.2)
		end
	end
end

function FightEntityEvolutionMgr:_onPlayTimelineSkillFinish()
	for k, v in pairs(self._entityDic) do
		if self._entityVisible[v.id] then
			self._entityVisible[v.id] = self._entityVisible[v.id] - 1

			if self._entityVisible[v.id] < 0 then
				self._entityVisible[v.id] = 0
			end
		end

		if self._entityVisible[v.id] == 0 then
			v:setAlpha(1, 0.2)
			FightGameMgr.entityMgr:adjustSpineLookRotation(v)
		end
	end
end

function FightEntityEvolutionMgr:_onCameraFocusChanged(state)
	if state then
		self:_onPlayTimelineSkill()
	else
		self:_onPlayTimelineSkillFinish()
	end
end

function FightEntityEvolutionMgr:_releaseEntity(entity)
	if self._entityDic[entity.id] then
		self._entityDic[entity.id]:disposeSelf()

		self._entityDic[entity.id] = nil
		self._entityVisible[entity.id] = nil
	end
end

function FightEntityEvolutionMgr:_releaseAllEntity()
	for k, entity in pairs(self._entityDic) do
		self:_releaseEntity(entity)
	end

	self._skinId2Entity = {}
	self._skinIds = {}
	self._delayReleaseEntity = {}
end

function FightEntityEvolutionMgr:_onReleaseAllEntrustedEntity()
	self:_releaseAllEntity()
end

function FightEntityEvolutionMgr:onDestructor()
	self:_releaseAllEntity()
end

return FightEntityEvolutionMgr
