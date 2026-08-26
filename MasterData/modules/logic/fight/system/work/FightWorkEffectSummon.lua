-- chunkname: @modules/logic/fight/system/work/FightWorkEffectSummon.lua

module("modules.logic.fight.system.work.FightWorkEffectSummon", package.seeall)

local FightWorkEffectSummon = class("FightWorkEffectSummon", FightEffectBase)

function FightWorkEffectSummon:onStart()
	self._entityMO = FightDataHelper.entityMgr:getById(self.actEffectData.entity.id)

	if self._entityMO then
		if FightDataHelper.entityMgr:isDeadUid(self._entityMO.uid) then
			self:onDone(true)

			return
		end

		self:com_registTimer(self._delayDone, 10)
		FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)

		self._entityId = self._entityMO.id

		local entity = FightGameMgr.entityMgr:newEntity(self._entityMO)

		if isTypeOf(entity, FightEntityAssembledMonsterSub) then
			self:onDone(true)

			return
		end
	else
		self:onDone(true)
	end
end

function FightWorkEffectSummon:_onSpineLoaded(unitSpine)
	if self._entityId == unitSpine.unitSpawn.id then
		self._entity = FightHelper.getEntity(self._entityId)
		self._audioId = 410000038

		if self._entityMO.side == FightEnum.EntitySide.MySide then
			self._flow = FlowParallel.New()

			self._flow:addWork(FightWorkStartBornNormal.New(self._entity, false))
		else
			self._flow = FlowParallel.New()

			local effectName = "buff/buff_zhaohuan"
			local time = 0.6
			local hangName = ModuleEnum.SpineHangPoint.mountbody
			local config = lua_fight_summon_show.configDict[self._entityMO.skin]

			if config then
				if not string.nilorempty(config.actionName) then
					effectName = nil

					self._flow:addWork(FightWorkEntityPlayAct.New(self._entity, config.actionName))
				end

				if config.audioId ~= 0 then
					self._audioId = config.audioId
				end

				if not string.nilorempty(config.effect) then
					effectName = config.effect
					time = config.effectTime and config.effectTime ~= 0 and config.effectTime / 1000 or time
				end

				if not string.nilorempty(config.effectHangPoint) then
					hangName = config.effectHangPoint
				end

				if config.ingoreEffect == 1 then
					effectName = nil
				end
			end

			if effectName then
				time = time / FightModel.instance:getSpeed()

				self._flow:addWork(FightWorkStartBornExtendForEffect.New(self._entity, false, effectName, hangName, time))
			end
		end

		self:com_registTimer(self._delayDone, 60)
		self._flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.AfterSummon, self._entityMO.modelId))
		self._flow:registerDoneListener(self._onSummonBornDone, self)
		self._flow:start()
		AudioMgr.instance:trigger(self._audioId)
		FightController.instance:dispatchEvent(FightEvent.OnSummon, self._entity)
	end
end

function FightWorkEffectSummon:_playAudio(audioId)
	AudioMgr.instance:trigger(audioId)
end

function FightWorkEffectSummon:_onSummonBornDone()
	self:onDone(true)
end

function FightWorkEffectSummon:_delayDone()
	logError("召唤效果超时")
	self:onDone(true)
end

function FightWorkEffectSummon:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)

	if self._flow then
		self._flow:unregisterDoneListener(self._onAniFlowDone, self)
		self._flow:stop()

		self._flow = nil
	end
end

return FightWorkEffectSummon
