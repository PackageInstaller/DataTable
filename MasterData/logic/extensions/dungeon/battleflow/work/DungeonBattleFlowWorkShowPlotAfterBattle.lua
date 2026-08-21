-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/work/DungeonBattleFlowWorkShowPlotAfterBattle.lua

module("logic.extensions.dungeon.battleflow.work.DungeonBattleFlowWorkShowPlotAfterBattle", package.seeall)

local M = class("DungeonBattleFlowWorkShowPlotAfterBattle", WorkBase)

function M:onEnter(context)
	local dungeonFlow = DungeonController.instance:getDungeonBattleFlow()
	local isShowPlot = true

	if dungeonFlow then
		isShowPlot = dungeonFlow.model:isShowPlot()
	end

	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()
	local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)
	local plotCode = dungeonMO:getPlotAfterBattle()

	if isShowPlot and context.model:isWin() and plotCode and plotCode > 0 then
		if BattleRoundReportViewFacade.instance:checkView(true) then
			if enableErrorLog then
				printError("战斗异常,未关闭roundReport,剧情code:", plotCode)
			end

			BattleRoundReportViewFacade.instance:setVisible(false)
		end

		LoadingFacade.instance:hideLoading()
		StoryMgr.instance:startSingle(plotCode, false, self._onPlotFinish, self, false, NewbieExtension_pb.PlotEnum.DUNGEON)
		StoryMgr.instance:isAfterBattle(true)
	else
		self:_onPlotFinish()
	end
end

function M:onExit(isInterrupt)
	return
end

function M:_onPlotFinish()
	if BattleRoundReportViewFacade.instance:checkView(true) then
		BattleRoundReportViewFacade.instance:setVisible(true)
	end

	self:onDone(WorkResult.Succeed)
end

return M
