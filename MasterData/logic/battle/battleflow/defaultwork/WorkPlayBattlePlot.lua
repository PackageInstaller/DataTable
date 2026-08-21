-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkPlayBattlePlot.lua

module("logic.battle.battleflow.defaultwork.WorkPlayBattlePlot", package.seeall)

local M = class("WorkPlayBattlePlot", WorkBase)

function M:onEnter(context)
	local dungeonBttleFlow = DungeonController.instance:getDungeonBattleFlow()

	if dungeonBttleFlow then
		local plotCode = dungeonBttleFlow.model:getPlotCodeAfterReady()
		local isShowPlot = dungeonBttleFlow.model:isShowPlot()

		if isShowPlot and plotCode and plotCode > 0 then
			StoryMgr.instance:startSingle(plotCode, false, self._onPlotFinish, self, false, NewbieExtension_pb.PlotEnum.DUNGEON)
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
