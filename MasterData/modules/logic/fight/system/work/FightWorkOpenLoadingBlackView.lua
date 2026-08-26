-- chunkname: @modules/logic/fight/system/work/FightWorkOpenLoadingBlackView.lua

module("modules.logic.fight.system.work.FightWorkOpenLoadingBlackView", package.seeall)

local FightWorkOpenLoadingBlackView = class("FightWorkOpenLoadingBlackView", BaseWork)
local LoadingPreOpenTime = 0.5

function FightWorkOpenLoadingBlackView:onStart(context)
	local loadingState = GameGlobalMgr.instance:getLoadingState()
	local nextLoadingType = loadingState:getLoadingType()

	if nextLoadingType == GameLoadingState.LoadingBlackView then
		self._openViewTime = BaseViewContainer.openViewTime
		BaseViewContainer.openViewTime = LoadingPreOpenTime

		TaskDispatcher.runDelay(self._delayDone, self, LoadingPreOpenTime)
		ViewMgr.instance:openView(ViewName.LoadingBlackView)
	else
		self:onDone(true)
	end
end

function FightWorkOpenLoadingBlackView:_delayDone()
	BaseViewContainer.openViewTime = self._openViewTime

	self:onDone(true)
end

function FightWorkOpenLoadingBlackView:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightWorkOpenLoadingBlackView
