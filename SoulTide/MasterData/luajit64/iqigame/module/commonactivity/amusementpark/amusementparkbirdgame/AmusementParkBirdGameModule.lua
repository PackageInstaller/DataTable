-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkBirdGame\\AmusementParkBirdGameModule.lua

local m = {
	birdRankMaxNum = 50,
	maxLv = 0,
	rankType = 1,
	maxScore = 0,
	myRanking = 0,
	callBack = Queue.New()
}
local AmusementParkBirdGameData = require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkBirdGame.AmusementParkBirdGameData")

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

function m.GetBirdGameRank()
	if not AmusementParkModule.IsShow() then
		return
	end

	CenterRankModule.GetRanking(Constant.RankingType.AmusementParkFlyBirdRank, m.birdRankMaxNum, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		m.rankType = rankType
		m.myRanking = myRanking

		EventDispatcher.Dispatch(EventID.APUpdateBirdGameRankEvent)
	end)
end

function m.CreateNewGame()
	local cfgData

	for i, v in pairsCfg(CfgAmusementParkBirdControlTable) do
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

	m.apBirdGameData = AmusementParkBirdGameData.New(cfgData.Id)
end

function m.StartBirdGame()
	m.PixelBirdInfo(function()
		m.CreateNewGame()
		UIModule.Open(Constant.UIControllerName.AmusementParkGameFlappyBirdUI, Constant.UILayer.UI)
	end)
end

function m.Shutdown()
	m.RemoveListeners()

	m.apBirdGameData = nil

	m.callBack:Clear()
end

function m.PixelBirdInfo(callBack)
	if callBack then
		m.callBack:Enqueue(callBack)
	end

	net_amusementPark.pixelBirdInfo()
end

function m.PixelBird()
	if not AmusementParkModule.IsShow() then
		return
	end

	local level = m.apBirdGameData:GetCfgData().Level
	local score = m.apBirdGameData:GetGameScore()

	net_amusementPark.pixelBird(level, score)
end

function m.PixelBirdInfoResult(level, score)
	m.maxLv = level
	m.maxScore = score

	if m.callBack.Size > 0 then
		local callBack = m.callBack:Dequeue()

		callBack()
	end
end

function m.PixelBirdResult(level, score)
	if level > m.maxLv then
		m.maxLv = level
	end

	m.maxScore = score

	m.GetBirdGameRank()
	AmusementParkModule.GetLittleGameInfo()
end

AmusementParkBirdGameModule = m
