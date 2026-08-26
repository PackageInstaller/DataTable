-- chunkname: @modules/logic/fight/system/work/FightWorkMoveFront.lua

module("modules.logic.fight.system.work.FightWorkMoveFront", package.seeall)

local FightWorkMoveFront = class("FightWorkMoveFront", FightEffectBase)

function FightWorkMoveFront:ctor(fightStepData, actEffectData)
	if fightStepData then
		fightStepData.custom_ingoreParallelSkill = true
	end

	FightWorkMoveFront.super.ctor(self, fightStepData, actEffectData)
end

function FightWorkMoveFront:onStart()
	self._performanceTime = 0.75 / FightModel.instance:getSpeed()

	self:com_registTimer(self._delayDone, 5)

	self._flow = FlowParallel.New()
	self._cacheEntityIds = {}

	local tarEntityId = self.actEffectData.targetId
	local tarEntityMO = FightDataHelper.entityMgr:getById(tarEntityId)

	if tarEntityMO then
		local entity = FightHelper.getEntity(tarEntityId)

		if entity then
			local entityMO = tarEntityMO

			if entity.moveComp and entity.moveComp.mover then
				AudioMgr.instance:trigger(410000088)

				local tarTime = 0.5 / FightModel.instance:getSpeed()
				local endX, endY, endZ, targetScale = FightHelper.getEntityStandPos(entityMO)
				local parallelFlow = FlowParallel.New()

				parallelFlow:addWork(FunctionWork.New(self._playEffect, self, entity))
				parallelFlow:addWork(TweenWork.New({
					type = "DOScale",
					tr = entity.go.transform,
					to = targetScale,
					t = tarTime,
					ease = EaseType.InOutQuad
				}))
				parallelFlow:addWork(TweenWork.New({
					from = 0,
					type = "DOTweenFloat",
					to = 1,
					t = tarTime,
					frameCb = self._onFloat,
					cbObj = self,
					param = entity,
					ease = EaseType.InOutQuad
				}))
				parallelFlow:addWork(TweenWork.New({
					type = "DOMove",
					tr = entity.go.transform,
					tox = endX,
					toy = endY,
					toz = endZ,
					t = tarTime,
					ease = EaseType.InOutQuad
				}))
				self._flow:addWork(parallelFlow)
				table.insert(self._cacheEntityIds, entityMO.id)
			end
		end
	end

	local arr = string.split(self.actEffectData.reserveStr, "|")

	if #arr > 0 then
		for i, v in ipairs(arr) do
			local arr1 = string.split(v, "#")
			local entityId = arr1[1]
			local entityMO = FightDataHelper.entityMgr:getById(entityId)

			if entityMO then
				local entity = FightHelper.getEntity(entityId)

				if entity then
					local flow = FlowSequence.New()

					flow:addWork(WorkWaitSeconds.New(0.15 / FightModel.instance:getSpeed()))

					local parallelFlow = FlowParallel.New()
					local endX, endY, endZ, targetScale = FightHelper.getEntityStandPos(entityMO)
					local tarTime = 0.6 / FightModel.instance:getSpeed()

					parallelFlow:addWork(TweenWork.New({
						type = "DOScale",
						tr = entity.go.transform,
						to = targetScale,
						t = tarTime,
						ease = EaseType.InOutQuad
					}))
					parallelFlow:addWork(TweenWork.New({
						from = 0,
						type = "DOTweenFloat",
						to = 1,
						t = tarTime,
						frameCb = self._onFloat,
						cbObj = self,
						param = entity,
						ease = EaseType.InOutQuad
					}))
					parallelFlow:addWork(TweenWork.New({
						type = "DOMove",
						tr = entity.go.transform,
						tox = endX,
						toy = endY,
						toz = endZ,
						t = tarTime,
						ease = EaseType.InOutQuad
					}))
					flow:addWork(parallelFlow)
					self._flow:addWork(flow)
					table.insert(self._cacheEntityIds, entityMO.id)
				end
			end
		end
	end

	self._flow:registerDoneListener(self._onFlowDone, self)
	self._flow:start()
end

function FightWorkMoveFront:_onFlowDone()
	self:onDone(true)
end

function FightWorkMoveFront:_delayDone()
	self:onDone(true)
end

function FightWorkMoveFront:_playEffect(entity)
	if not entity then
		return
	end

	if not entity.effect then
		return
	end

	if FightDataHelper.fieldMgr:isRouge2() then
		local entityMo = entity:getMO()

		if entityMo.side == FightEnum.TeamType.EnemySide and not entityMo:hasBuffId(116320031) then
			return
		end
	end

	local effectWrap = entity.effect:addHangEffect("buff/buff_qianjin_jiantou", "mountbody", nil, self._performanceTime)

	FightRenderOrderMgr.instance:onAddEffectWrap(entity.id, effectWrap)
	effectWrap:setLocalPos(0, 0, 0)

	effectWrap = entity.effect:addHangEffect("buff/buff_qianjin_tuowei", "mountbody", nil, self._performanceTime)

	FightRenderOrderMgr.instance:onAddEffectWrap(entity.id, effectWrap)
	effectWrap:setLocalPos(0, 0, 0)
end

function FightWorkMoveFront:_onFloat(num, entity)
	if entity.go then
		FightController.instance:dispatchEvent(FightEvent.UpdateUIFollower, entity.id)
	end
end

function FightWorkMoveFront:clearWork()
	if self._flow then
		self._flow:unregisterDoneListener(self._onFlowDone, self)
		self._flow:stop()

		self._flow = nil
	end

	if self._cacheEntityIds then
		for i, v in ipairs(self._cacheEntityIds) do
			local entity = FightHelper.getEntity(v)

			if entity and entity.effect then
				entity.effect:refreshAllEffectLabel1()
			end
		end
	end

	FightRenderOrderMgr.instance:setSortType(FightEnum.RenderOrderType.StandPos)
end

return FightWorkMoveFront
