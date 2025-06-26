-- chunkname: @IQIGame\\Module\\Puzzle\\PuzzleModule.lua

PuzzleModule = {}

local this = PuzzleModule
local pairs = pairs
local pairsCfg = pairsCfg

function PuzzleModule.Initialize()
	PuzzleModule._InitData()
	PuzzleModule._AddEventListeners()
end

function PuzzleModule.Shutdown()
	PuzzleModule._RemoveEventListeners()
end

function PuzzleModule._AddEventListeners()
	return
end

function PuzzleModule._RemoveEventListeners()
	return
end

function PuzzleModule._InitData()
	PuzzleModule.currentStoryCluesList = {}
	PuzzleModule.exchangeCluesList = {}
	PuzzleModule.hasSurveyedList = {}
end

function PuzzleModule.AddClueInCurrentStoryClueList(clueID, needTip)
	local addClueID = clueID

	if PuzzleModule.exchangeCluesList[clueID] then
		addClueID = PuzzleModule.exchangeCluesList[clueID]
		PuzzleModule.exchangeCluesList[clueID] = nil
	end

	table.insert(PuzzleModule.currentStoryCluesList, addClueID)
	EventDispatcher.Dispatch(EventID.BehaviourTreeStoryUIRefreshEvent, clueID, needTip, Constant.CluesGetType.Add)
	EventDispatcher.Dispatch(EventID.ExchangeClues)

	local storyInfo = {
		step = PuzzleUIApi:GetGainStepText(),
		clueID = clueID
	}
end

function PuzzleModule.AddClueInExchangeClueList(originClue, targetClue)
	PuzzleModule.exchangeCluesList[originClue] = targetClue

	for i = 1, getCfgTableLength(PuzzleModule.currentStoryCluesList) do
		if PuzzleModule.currentStoryCluesList[i] == originClue then
			PuzzleModule.currentStoryCluesList[i] = targetClue
			PuzzleModule.exchangeCluesList[originClue] = nil
		end
	end

	EventDispatcher.Dispatch(EventID.BehaviourTreeStoryUIRefreshEvent, targetClue, true, Constant.CluesGetType.Refresh)
	EventDispatcher.Dispatch(EventID.ExchangeClues)
end

function PuzzleModule.CluesComposing(cfgClueCraftID)
	local cfg = CfgUtil.GetCfgCluesCraftDataWithID(cfgClueCraftID)
	local set = {}
	local len = #cfg.CluesID

	for i = 1, len do
		set[cfg.CluesID[i]] = 1
	end

	len = #this.currentStoryCluesList

	for i = len, 1, -1 do
		if set[this.currentStoryCluesList[i]] then
			table.remove(this.currentStoryCluesList, i)
		end
	end

	PuzzleModule.AddClueInCurrentStoryClueList(cfg.ComposeID)

	return composeClueID
end

function PuzzleModule.GetCurrentStoryCluesData()
	local cluesDataTable = {}

	for i = 1, getCfgTableLength(PuzzleModule.currentStoryCluesList) do
		for _, v in pairsCfg(CfgCluesTable) do
			local cfg = v

			if cfg.Id == PuzzleModule.currentStoryCluesList[i] then
				table.insert(cluesDataTable, cfg)
			end
		end
	end

	return cluesDataTable
end

function PuzzleModule.GetThreadPuzzleCfgData(puzzleID)
	for _, v in pairsCfg(CfgDecryptioncluesTable) do
		local cfg = v

		if cfg.Id == puzzleID then
			return cfg
		end
	end
end

function PuzzleModule.GetCluesCfgDataWithID(clueID)
	for _, v in pairsCfg(CfgCluesTable) do
		local cfg = v

		if cfg.Id == clueID then
			return cfg
		end
	end
end

function PuzzleModule.GetCfgImagePuzzleDataWithID(imagePuzzleID)
	for _, v in pairsCfg(CfgImagePuzzleTable) do
		local cfg = v

		if cfg.Id == imagePuzzleID then
			return cfg
		end
	end
end

function PuzzleModule.GetCurrentStoryCluesCount()
	return getCfgTableLength(PuzzleModule.currentStoryCluesList)
end

function PuzzleModule.SetClueHasSurveyed(clueID)
	PuzzleModule.hasSurveyedList[clueID] = true
end

function PuzzleModule.SetNoSurveyCluesSurveyed()
	for i = 1, #PuzzleModule.currentStoryCluesList do
		local cfgClue = CfgUtil.GetCfgCluesDataWithID(PuzzleModule.currentStoryCluesList[i])

		if not cfgClue.IsSurvey then
			PuzzleModule.SetClueHasSurveyed(PuzzleModule.currentStoryCluesList[i])
		end
	end
end

function PuzzleModule.GetIsSurveyedAll()
	if #PuzzleModule.currentStoryCluesList < 0 then
		return false
	end

	for i = 1, #PuzzleModule.currentStoryCluesList do
		if not PuzzleModule.hasSurveyedList[PuzzleModule.currentStoryCluesList[i]] then
			return false
		end
	end

	return true
end

function PuzzleModule.GetClueIsHad(clueID)
	for _, v in pairs(PuzzleModule.currentStoryCluesList) do
		if v == clueID then
			return true
		end
	end

	return false
end

function PuzzleModule.GetTheFirstCanCompose()
	local clueList = this.currentStoryCluesList
	local cfgCanCompose

	for _, v in pairs(CfgCluesCraftTable) do
		local isSceneRight = false
		local len = #v.StoryDataID

		for i = 1, len do
			if v.StoryDataID[i] == StoryModule.currentStoryID then
				isSceneRight = true

				break
			end
		end

		if isSceneRight then
			local canCompose = true

			len = #v.CluesID

			for i = 1, len do
				local len2 = #clueList
				local isHave = false

				for j = 1, len2 do
					if clueList[j] == v.CluesID[i] then
						isHave = true

						break
					end
				end

				if not isHave then
					canCompose = false

					break
				end
			end

			if canCompose then
				if not cfgCanCompose then
					cfgCanCompose = v
				else
					cfgCanCompose = cfgCanCompose.Display < v.Display and cfgCanCompose or v
				end
			end
		end
	end

	return cfgCanCompose
end
