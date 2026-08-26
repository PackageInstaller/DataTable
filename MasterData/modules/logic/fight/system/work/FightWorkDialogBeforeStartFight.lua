-- chunkname: @modules/logic/fight/system/work/FightWorkDialogBeforeStartFight.lua

module("modules.logic.fight.system.work.FightWorkDialogBeforeStartFight", package.seeall)

local FightWorkDialogBeforeStartFight = class("FightWorkDialogBeforeStartFight", BaseWork)

function FightWorkDialogBeforeStartFight:onStart()
	self._flow = FlowSequence.New()

	self._flow:addWork(FunctionWork.New(self._setHudState, self))
	self._flow:addWork(FunctionWork.New(self._setFightViewState, self, true))
	self._flow:addWork(FunctionWork.New(self._setEntityState, self, false))
	self._flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.BeforeStartFight))
	self._flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.BeforeStartFightAndXXTimesEnterBattleId))
	self._flow:addWork(FunctionWork.New(self._setFightViewState, self, false))
	self._flow:registerDoneListener(self._onFlowDone, self)
	self._flow:start()
end

function FightWorkDialogBeforeStartFight:_setHudState()
	gohelper.setActive(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
end

function FightWorkDialogBeforeStartFight:_setFightViewState(state)
	FightController.instance:dispatchEvent(FightEvent.SetStateForDialogBeforeStartFight, state)
end

function FightWorkDialogBeforeStartFight:_setEntityState(state)
	FightViewPartVisible.set()

	local entitys = FightHelper.getAllEntitys()

	for _, entity in ipairs(entitys) do
		if entity.nameUI then
			entity.nameUI:setActive(state)
		end

		if entity.setAlpha then
			entity:setAlpha(state and 1 or 0, 0)
		end
	end
end

function FightWorkDialogBeforeStartFight:_onFlowDone()
	self:onDone(true)
end

function FightWorkDialogBeforeStartFight:revertState()
	if not self._reverStateDone then
		self._reverStateDone = true

		self:_setFightViewState(false)
		self:_setEntityState(true)
	end
end

function FightWorkDialogBeforeStartFight:clearWork()
	self:revertState()

	if self._flow then
		self._flow:unregisterDoneListener(self._onFlowDone, self)
		self._flow:stop()

		self._flow = nil
	end
end

return FightWorkDialogBeforeStartFight
