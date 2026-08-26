-- chunkname: @modules/logic/fight/system/work/FightWorkAppearPerformance.lua

module("modules.logic.fight.system.work.FightWorkAppearPerformance", package.seeall)

local FightWorkAppearPerformance = class("FightWorkAppearPerformance", BaseWork)

function FightWorkAppearPerformance:onStart()
	self._flow = FlowSequence.New()

	self._flow:addWork(FightWorkAppearTimeline.New())

	local hasTimeline, entity = FightWorkAppearTimeline.getAppearTimeline()
	local entityMO = entity and entity:getMO()

	if hasTimeline and entityMO then
		self._flow:addWork(FunctionWork.New(function()
			local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)

			for i, v in ipairs(entityList) do
				if v.nameUI then
					v.nameUI:setActive(false)
				end

				if v.setAlpha then
					v:setAlpha(0, 0)
				end
			end
		end))
		self._flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.AfterAppearTimeline, entityMO.modelId))
	end

	self._flow:registerDoneListener(self._onFlowDone, self)
	self._flow:start()
end

function FightWorkAppearPerformance:_onFlowDone()
	self:onDone(true)
end

function FightWorkAppearPerformance:clearWork()
	if self._flow then
		self._flow:unregisterDoneListener(self._onFlowDone, self)
		self._flow:stop()

		self._flow = nil
	end
end

return FightWorkAppearPerformance
