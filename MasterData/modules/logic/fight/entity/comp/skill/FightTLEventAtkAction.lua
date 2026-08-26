-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventAtkAction.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventAtkAction", package.seeall)

local FightTLEventAtkAction = class("FightTLEventAtkAction", FightTimelineTrackItem)

function FightTLEventAtkAction:onTrackStart(fightStepData, duration, paramsArr)
	if not FightHelper.detectTimelinePlayEffectCondition(fightStepData, paramsArr[11]) then
		return
	end

	self._attacker = FightHelper.getEntity(fightStepData.fromId)

	if not string.nilorempty(paramsArr[7]) then
		local targetSkin = tonumber(paramsArr[7])
		local entityList = FightHelper.getAllEntitys()

		for i, entity in ipairs(entityList) do
			local entityData = entity:getMO()

			if entityData and entityData.skin == targetSkin then
				self._attacker = entity

				break
			end
		end
	end

	self._action = paramsArr[1]
	self._loop = paramsArr[2] == "1"
	self._monsterEvolution = paramsArr[3] == "1"
	self._detectCanPlay = paramsArr[4] == "1"
	self.lockAct = paramsArr[6] == "1"
	self.isUnlock = paramsArr[6] == "2"
	self.donotProcess = paramsArr[8] == "1"
	self.stillLockWhenEnd = paramsArr[10] == "1"

	if paramsArr[5] == "1" then
		self._attacker = FightHelper.getEntity(fightStepData.toId)
	end

	if not string.nilorempty(paramsArr[9]) then
		local arr = string.splitToNumber(paramsArr[9])

		for _, buffId in ipairs(arr) do
			for entityId, entityData in pairs(FightDataHelper.entityMgr.entityDataDic) do
				local buffDic = entityData.buffDic

				for _, buffData in pairs(buffDic) do
					if buffData.id == buffId then
						self._attacker = FightHelper.getEntity(entityId)

						break
					end
				end
			end
		end
	end

	if not string.nilorempty(paramsArr[12]) then
		self._attacker = FightGameMgr.tokenReleaseEntityMgr:getEntity(paramsArr[12])
	end

	if self.timelineItem.spineDelayTime then
		TaskDispatcher.runDelay(self._playAct, self, self.timelineItem.spineDelayTime)
	else
		self:_playAct()
	end

	if not string.nilorempty(paramsArr[13]) then
		self:com_registTimer(self.unLockSpine, tonumber(paramsArr[13]) / FightModel.instance:getSpeed())
	end
end

function FightTLEventAtkAction:unLockSpine()
	if self._attacker and self._attacker.spine then
		self._attacker.spine.lockAct = false
	end
end

function FightTLEventAtkAction:_playAct()
	if self._attacker and self._attacker.spine then
		if not string.nilorempty(self._action) then
			if self.isUnlock then
				self._attacker.spine.lockAct = false
			end

			if self._detectCanPlay then
				if not self._attacker.spine:tryPlay(self._action, self._loop, true) then
					return
				end
			else
				self._attacker.spine:play(self._action, self._loop, true, self.donotProcess)
			end

			if self.timelineItem.spineStartTime then
				self._attacker.spine._skeletonAnim:Jump2Time(self.timelineItem.spineStartTime)
			end

			if self._monsterEvolution then
				local attackerMO = self._attacker:getMO()

				if not self._attacker.beforeMonsterChangeSkin then
					local skin = attackerMO.skin
					local config = attackerMO and lua_fight_boss_evolution_client.configDict[skin]

					if config then
						self._attacker.spine.lockAct = true
					end
				end
			end
		end

		if self.lockAct then
			self._attacker.spine.lockAct = true
		end
	end
end

function FightTLEventAtkAction:onTrackEnd()
	if self.lockAct and self._attacker and self._attacker.spine and not self.stillLockWhenEnd then
		self._attacker.spine.lockAct = false
	end

	self:_onActionFinish()
end

function FightTLEventAtkAction:_onActionFinish()
	if self.lockAct and self.stillLockWhenEnd then
		return
	end

	self._actionFinish = true

	if self._attacker and self._attacker.spine and self._attacker.spine:getAnimState() == self._action then
		local animName = self._attacker:getDefaultAnim()
		local skeletonAnim = self._attacker.spine:getSkeletonAnim()

		if skeletonAnim and skeletonAnim:HasAnimation(animName) then
			self._attacker.spine:play(animName, true, false)
		end
	end

	self._attacker = nil
end

function FightTLEventAtkAction:onDestructor()
	if self.lockAct and self._attacker and self._attacker.spine and not self.stillLockWhenEnd then
		self._attacker.spine.lockAct = false
	end

	if not self._actionFinish then
		self:_onActionFinish()
	end

	self._actionFinish = nil
	self._attacker = nil

	TaskDispatcher.cancelTask(self._playAct, self)
end

return FightTLEventAtkAction
