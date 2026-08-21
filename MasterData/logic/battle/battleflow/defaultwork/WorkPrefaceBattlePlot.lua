-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkPrefaceBattlePlot.lua

module("logic.battle.battleflow.defaultwork.WorkPrefaceBattlePlot", package.seeall)

local M = class("WorkPrefaceBattlePlot", WorkBase)

function M:onEnter(context)
	local prefaceFW = PrefaceController.instance:getPrefaceBattleFlow()

	if prefaceFW then
		local plotCode = prefaceFW.model:getPlotCodeAfterReady()
		local isShowPlot = prefaceFW.model:isShowPlot()

		if isShowPlot and plotCode and plotCode > 0 then
			StoryMgr.instance:startSingle(plotCode, false, self._onPlotFinish, self)
		else
			self:onDone(WorkResult.Succeed)
		end
	else
		self:onDone(WorkResult.Succeed)
	end
end

function M:onExit(isInterrupt)
	return
end

function M:_onPlotFinish()
	self:onDone(WorkResult.Succeed)
end

return M
