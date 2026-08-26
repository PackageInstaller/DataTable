-- chunkname: @modules/logic/dungeonmazev3a7/controller/DungeonMazeV3a7Controller.lua

module("modules.logic.dungeonmazev3a7.controller.DungeonMazeV3a7Controller", package.seeall)

local DungeonMazeV3a7Controller = class("DungeonMazeV3a7Controller", BaseController)

function DungeonMazeV3a7Controller:onInitFinish()
	return
end

function DungeonMazeV3a7Controller:addConstEvents()
	return
end

function DungeonMazeV3a7Controller:reInit()
	return
end

function DungeonMazeV3a7Controller:release()
	return
end

function DungeonMazeV3a7Controller:gmWin()
	local resultViewParams = {}

	resultViewParams.episodeId = self._mazeEpisodeId

	local episodeCfg = DungeonConfig.instance:getEpisodeCO(self._mazeEpisodeId)
	local afterStory = tonumber(episodeCfg.story)

	if afterStory ~= 0 then
		self:playMazeAfterStory(afterStory)

		return
	else
		DungeonRpc.instance:sendEndDungeonRequest(false)

		resultViewParams.isWin = true

		self:openMazeResultView(resultViewParams)
	end
end

function DungeonMazeV3a7Controller:MoveTo(dir)
	local curCellData = DungeonMazeV3a7Model.instance:getCurCellData()
	local targetCell = curCellData.connectSet[dir]
	local gameOver = false
	local isSuccess = false

	if targetCell then
		DungeonMazeV3a7Model.instance:setCurCellData(targetCell)
		DungeonMazeV3a7Model.instance:addChaosValue()

		local curChaos = DungeonMazeV3a7Model.instance:getChaosValue()
		local resultViewParams = {}

		resultViewParams.episodeId = self._mazeEpisodeId

		if targetCell.value == 2 then
			self:sandStatData(DungeonMazeV3a7Enum.resultStat[1], targetCell.cellId, curChaos)

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
				isSuccess = true
			end
		elseif curChaos == DungeonMazeV3a7Enum.MaxChaosValue then
			self:sandStatData(DungeonMazeV3a7Enum.resultStat[2], targetCell.cellId, curChaos)

			gameOver = true
		end
	end

	DungeonMazeV3a7Model.instance:UnpateSkillState(true)

	if not gameOver then
		DungeonMazeV3a7Model.instance:SaveCurProgress()
	end

	return gameOver, isSuccess
end

function DungeonMazeV3a7Controller:playMazeAfterStory(storyId)
	local param = {}

	param.mark = true

	local resultViewParams = {}

	resultViewParams.episodeId = self._mazeEpisodeId
	resultViewParams.isWin = true

	StoryController.instance:playStory(storyId, param, function()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		DungeonRpc.instance:sendEndDungeonRequest(false)
		DungeonMazeV3a7Controller.instance:openMazeResultView(resultViewParams)
		ViewMgr.instance:closeView(ViewName.DungeonMapLevelView)
	end)
end

function DungeonMazeV3a7Controller:UseEyeSkill()
	local curSkillState = DungeonMazeV3a7Model.instance:GetSkillState()

	if curSkillState == DungeonMazeV3a7Enum.skillState.using then
		return
	end

	if curSkillState == DungeonMazeV3a7Enum.skillState.cooling then
		return
	end

	DungeonMazeV3a7Model.instance:UnpateSkillState()
end

function DungeonMazeV3a7Controller:openMazeGameView(viewParams)
	self:initStatData()

	self._mazeEpisodeId = viewParams.episodeCfg.id

	DungeonMazeV3a7Model.instance:initData()
	DungeonMazeV3a7Model.instance:LoadProgress()
	ViewMgr.instance:openView(ViewName.DungeonMazeV3a7View, viewParams)
end

function DungeonMazeV3a7Controller:openMazeResultView(viewParams)
	DungeonMazeV3a7Model.instance:ClearProgress()
	DungeonMazeV3a7Controller.instance:dispatchEvent(DungeonMazeV3a7Event.DungeonMazeV3a7Completed)
end

function DungeonMazeV3a7Controller:initStatData()
	self.statMo = DungeonGameMo.New()
end

function DungeonMazeV3a7Controller:sandStatData(result, cellId, chaoValue)
	self.statMo:sendMazeGameStatData(result, cellId, chaoValue)
end

DungeonMazeV3a7Controller.instance = DungeonMazeV3a7Controller.New()

return DungeonMazeV3a7Controller
