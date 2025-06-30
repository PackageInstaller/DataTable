-- chunkname: @IQIGame\\Module\\Challenge\\ChallengeModule.lua

ChallengeModule = {
	isFight = false
}

local ChallengeData = require("IQIGame.Module.Challenge.ChallengeData")
local ChallengeRewardData = require("IQIGame.Module.Challenge.ChallengeRewardData")

function ChallengeModule.Initialize()
	ChallengeModule.AddEventListeners()
end

function ChallengeModule.Shutdown()
	ChallengeModule.isFight = false

	ChallengeModule.RemoveEventListeners()
end

function ChallengeModule.AddEventListeners()
	EventDispatcher.AddEventListener(EventID.PlayerInfoChanged, ChallengeModule.OnPlayerInfoChanged)
end

function ChallengeModule.RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.PlayerInfoChanged, ChallengeModule.OnPlayerInfoChanged)
end

function ChallengeModule.ReloadChallengePOD(dailyDupPODList)
	ChallengeModule.challengePODDict = {}

	for i, lDailyDupPOD in pairs(dailyDupPODList) do
		ChallengeModule.AddChallengeData(lDailyDupPOD)
	end
end

function ChallengeModule.AddChallengeData(dailyDupPOD)
	if dailyDupPOD == nil then
		return
	end

	local isOpen = DailyDupModule.IsFunctionOpen(dailyDupPOD.common.cid)
	local isOpenTime = DailyDupModule.IsOpenTime(dailyDupPOD.common.cid)
	local challengeData = ChallengeData.New(dailyDupPOD.common.cid, isOpen, dailyDupPOD, false, isOpenTime)

	table.insert(ChallengeModule.challengePODDict, challengeData)
end

function ChallengeModule.GetChallengeDataByID(cfgID)
	if ChallengeModule.challengePODDict then
		for i, challengeData in pairs(ChallengeModule.challengePODDict) do
			if challengeData.cfgID == cfgID then
				return challengeData
			end
		end
	end

	return nil
end

function ChallengeModule.IsSweepAway(layerID)
	local cfgLayerData = CfgChallengeLayerTable[layerID]
	local dailyDupPod = DailyDupModule.GetDailyDupPOD(cfgLayerData.DailyDupId)

	return table.indexOf(dailyDupPod.challengePOD.difficult, layerID) ~= -1
end

function ChallengeModule.GetDailyDupCidByChallengeType(challengeType)
	for id, cfgDailyDupData in pairsCfg(CfgDailyDupTable) do
		if cfgDailyDupData.Type == challengeType then
			return id
		end
	end

	return nil
end

function ChallengeModule.OnPlayerInfoChanged()
	local isNew = false

	if ChallengeModule.challengePODDict then
		for k, challengeData in pairs(ChallengeModule.challengePODDict) do
			local top = challengeData:UpdateChallengeLayerByLv()

			if isNew == false then
				isNew = top
			end
		end
	end

	if isNew then
		EventDispatcher.Dispatch(EventID.UpdateDailyDupEvent)
	end
end

function ChallengeModule.ChallengeDup(levelCid, formationID)
	if ChallengeModule.isFight then
		return
	end

	net_challenge.challengeDup(levelCid, formationID)

	ChallengeModule.isFight = true
end

function ChallengeModule.Sweeping(levelCid, count)
	net_challenge.sweeping(levelCid, count)
end

function ChallengeModule.Reward(rewards, dupCid)
	net_challenge.reward(rewards, dupCid)
end

function ChallengeModule.SweepingResult(getItems, oldMaxHurt)
	local rewardData = ChallengeRewardData.New(2, true, getItems, oldMaxHurt)

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)
end

function ChallengeModule.NotifyChallengeComplete(win, dupCid, levelCid, dmgRecords, getItems, oldMaxHurt)
	ChallengeModule.isFight = false

	ChallengeModule.ExitBattle(win, getItems, oldMaxHurt, dmgRecords)

	if not win then
		EventDispatcher.Dispatch(EventID.UpdateChallengeFailure, levelCid)
	end
end

function ChallengeModule.ExitBattle(win, getItems, oldMaxHurt, dmgRecords)
	MainCityBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, getItems, oldMaxHurt, dmgRecords)

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)
end

function ChallengeModule.UpdateChallengeDupPOD(dailyDupPOD)
	if ChallengeModule.challengePODDict then
		local exist = false

		for k, challengeData in pairs(ChallengeModule.challengePODDict) do
			if dailyDupPOD.common.cid == challengeData.cfgID then
				challengeData:UpdateChallengePOD(dailyDupPOD)

				exist = true

				break
			end
		end

		if not exist then
			ChallengeModule.AddChallengeData(dailyDupPOD)
		end
	end
end
