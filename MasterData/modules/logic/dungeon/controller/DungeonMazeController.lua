-- chunkname: @modules/logic/dungeon/controller/DungeonMazeController.lua

module("modules.logic.dungeon.controller.DungeonMazeController", package.seeall)

local DungeonMazeController = class("DungeonMazeController", BaseController)

function DungeonMazeController:onInitFinish()
	return
end

function DungeonMazeController:addConstEvents()
	return
end

function DungeonMazeController:reInit()
	return
end

function DungeonMazeController:release()
	return
end

function DungeonMazeController:MoveTo(dir)
	local curCellData = DungeonMazeModel.instance:getCurCellData()
	local targetCell = curCellData.connectSet[dir]
	local gameOver = false

	if targetCell then
		DungeonMazeModel.instance:setCurCellData(targetCell)
		DungeonMazeModel.instance:addChaosValue()

		local curChaos = DungeonMazeModel.instance:getChaosValue()
		local resultViewParams = {}

		resultViewParams.episodeId = self._mazeEpisodeId

		if targetCell.value == 2 then
			self:sandStatData(DungeonMazeEnum.resultStat[1], targetCell.cellId, curChaos)

			local episodeCfg = DungeonConfig.instance:getEpisodeCO(self._mazeEpisodeId)
			local afterStory = tonumber(episodeCfg.story)

			if afterStory ~= 0 then
				self:playMazeAfterStory(afterStory)

				return
			else
				DungeonRpc.instance:sendEndDungeonRequest(false)

				resultViewParams.isWin = true

				self:openMazeResultView(resultViewParams)

				gameOver = true
			end
		elseif curChaos == DungeonMazeEnum.MaxChaosValue then
			self:sandStatData(DungeonMazeEnum.resultStat[2], targetCell.cellId, curChaos)

			resultViewParams.isWin = false

			self:openMazeResultView(resultViewParams)

			gameOver = true
		end
	end

	DungeonMazeModel.instance:UnpateSkillState(true)

	if not gameOver then
		DungeonMazeModel.instance:SaveCurProgress()
	end
end

function DungeonMazeController:playMazeAfterStory(storyId)
	local param = {}

	param.mark = true

	local resultViewParams = {}

	resultViewParams.episodeId = self._mazeEpisodeId
	resultViewParams.isWin = true

	StoryController.instance:playStory(storyId, param, function()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		DungeonRpc.instance:sendEndDungeonRequest(false)
		DungeonMazeController.instance:openMazeResultView(resultViewParams)
		ViewMgr.instance:closeView(ViewName.DungeonMapLevelView)
	end)
end

function DungeonMazeController:UseEyeSkill()
	local curSkillState = DungeonMazeModel.instance:GetSkillState()

	if curSkillState == DungeonMazeEnum.skillState.using then
		return
	end

	if curSkillState == DungeonMazeEnum.skillState.cooling then
		return
	end

	DungeonMazeModel.instance:UnpateSkillState()
end

function DungeonMazeController:openMazeGameView(viewParams)
	self:initStatData()

	self._mazeEpisodeId = viewParams.episodeCfg.id

	DungeonMazeModel.instance:initData()
	DungeonMazeModel.instance:LoadProgress()
	ViewMgr.instance:openView(ViewName.DungeonMazeView, viewParams)
end

function DungeonMazeController:openMazeResultView(viewParams)
	DungeonMazeModel.instance:ClearProgress()
	ViewMgr.instance:openView(ViewName.DungeonMazeResultView, viewParams)
end

function DungeonMazeController:initStatData()
	self.statMo = DungeonGameMo.New()
end

function DungeonMazeController:sandStatData(result, cellId, chaoValue)
	self.statMo:sendMazeGameStatData(result, cellId, chaoValue)
end

DungeonMazeController.instance = DungeonMazeController.New()

return DungeonMazeController
