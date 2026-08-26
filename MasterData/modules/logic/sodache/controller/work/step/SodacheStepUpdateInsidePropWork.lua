-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepUpdateInsidePropWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepUpdateInsidePropWork", package.seeall)

local SodacheStepUpdateInsidePropWork = class("SodacheStepUpdateInsidePropWork", SodacheStepBaseWork)

function SodacheStepUpdateInsidePropWork:onWorkStart(context)
	local insideMo = SodacheModel.instance:getInsideMo()
	local preStatus = insideMo.prop.status

	insideMo.prop:init(self._stepMo.insideProp)

	if SodacheModel.instance.____gmfastrun then
		self:onDone(true)

		return
	end

	if preStatus <= SodacheEnum.InsideSceneStatus.Normal and insideMo.prop.status > SodacheEnum.InsideSceneStatus.Normal and not insideMo.prop.win then
		SodacheController.instance:dispatchEvent(SodacheEvent.OnPlayerDieAnim)
		TaskDispatcher.runDelay(self._afterPlayerDie, self, 0.5)
		UIBlockHelper.instance:startBlock("SodacheStepUpdateInsidePropWork", 0.5)
	else
		self:_afterPlayerDie()
	end
end

function SodacheStepUpdateInsidePropWork:_afterPlayerDie()
	local reason = self._stepMo.paramInt[1]
	local insideMo = SodacheModel.instance:getInsideMo()

	if insideMo.prop.status == SodacheEnum.InsideSceneStatus.End then
		self:onDone(true)
	elseif insideMo.prop.status == SodacheEnum.InsideSceneStatus.SelectCard then
		self.context.isEnd = true

		self:openAndWaitView(ViewName.SodacheTakeView)
	elseif reason == SodacheEnum.Reason.SelectTime then
		self:openAndWaitView(ViewName.SodacheMapMonsterAttrView)
	else
		SodacheController.instance:dispatchEvent(SodacheEvent.OnScenePropUpdate)
		self:onDone(true)
	end
end

function SodacheStepUpdateInsidePropWork:openAndWaitView(viewName)
	self._waitView = viewName

	ViewMgr.instance:openView(viewName)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onViewClose, self)
end

function SodacheStepUpdateInsidePropWork:_onViewClose(viewName)
	if viewName == self._waitView then
		if self._waitView ~= ViewName.SodacheTakeView then
			SodacheController.instance:dispatchEvent(SodacheEvent.OnScenePropUpdate)
		end

		self:onDone(true)
	end
end

function SodacheStepUpdateInsidePropWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onViewClose, self)
	TaskDispatcher.cancelTask(self._afterPlayerDie, self)
end

return SodacheStepUpdateInsidePropWork
