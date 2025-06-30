-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkDollMachineGame\\AmusementParkDollMachineGameModule.lua

local m = {
	maxLv = 0,
	rankType = 1,
	dollMachineGameRankMaxNum = 50,
	maxScore = 0,
	callBack = Queue.New()
}
local AmusementParkDollMachineData = require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkDollMachineGame.AmusementParkDollMachineData")

function m.Reload()
	m.callBack = Queue.New()

	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.GetDollMachineGameRank()
	if not AmusementParkModule.IsShow() then
		return
	end

	CenterRankModule.GetRanking(Constant.RankingType.AmusementParkDollMachineRank, m.dollMachineGameRankMaxNum, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		m.myRanking = myRanking
		m.rankType = rankType

		EventDispatcher.Dispatch(EventID.APUpdateDollMachineGameRankEvent)
	end)
end

function m.CreateNewGame()
	local cfgData

	for i, v in pairsCfg(CfgAmusementParkDollMachineControlTable) do
		if v.Group == AmusementParkModule.GlobalCid then
			local buildID = v.BuildingLevel[1]
			local needLv = v.BuildingLevel[2]
			local buildData = AmusementParkModule.GetAmusementParkBuildData(buildID)

			if buildData and needLv <= buildData.parkBuildPOD.level then
				if cfgData == nil then
					cfgData = v
				elseif cfgData.Level < v.Level then
					cfgData = v
				end
			end
		end
	end

	m.apDollMachineGameData = AmusementParkDollMachineData.New(cfgData.Id)
end

function m.StartDollMachineGame()
	m.DollMachineInfo(function()
		m.CreateNewGame()
		UIModule.Open(Constant.UIControllerName.AmusementParkGamePrizeClawUI, Constant.UILayer.UI)
	end)
end

function m.Shutdown()
	m.RemoveListeners()

	m.apDollMachineGameData = nil

	m.callBack:Clear()
end

function m.DollMachineInfo(callBack)
	if callBack then
		m.callBack:Enqueue(callBack)
	end

	net_amusementPark.dollMachineInfo()
end

function m.DollMachine()
	if not AmusementParkModule.IsShow() then
		return
	end

	net_amusementPark.dollMachine(m.apDollMachineGameData:GetCfgData().Level, m.apDollMachineGameData.totalScore)
end

function m.DollMachineInfoResult(level, score)
	m.maxLv = level
	m.maxScore = score

	if m.callBack.Size > 0 then
		local callBack = m.callBack:Dequeue()

		callBack()
	end
end

function m.DollMachineResult(level, score)
	if level > m.maxLv then
		m.maxLv = level
		m.maxScore = 0
	end

	if score > m.maxScore then
		m.maxScore = score
	end

	m.GetDollMachineGameRank()
	AmusementParkModule.GetLittleGameInfo()
end

AmusementParkDollMachineGameModule = m
