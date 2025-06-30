-- chunkname: @IQIGame\\Module\\CommandChallenge\\CommandChallengeModule.lua

local m = {
	isFight = false,
	commandChallengeDataTab = {}
}
local CommandChallengeData = require("IQIGame.Module.CommandChallenge.CommandChallengeData")
local ChallengeRewardData = require("IQIGame.Module.Challenge.ChallengeRewardData")

function m.Reload()
	PlayerModule.PlayerInfo.commandChallengeLayerIDs = PlayerModule.PlayerInfo.commandChallengeLayerIDs or {}

	m.CreateData()
	m.AddListeners()
end

function m.AddListeners()
	EventDispatcher.AddEventListener(EventID.UnlockFunction, m.OnUnlockNotify)
end

function m.RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, m.OnUnlockNotify)
end

function m.OnUnlockNotify()
	m.CreateData()
end

function m.CreateData()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.COMMAND_CHALLENGE)

	if result and #m.commandChallengeDataTab == 0 then
		for i, v in pairsCfg(CfgCommandChallengeLayerTable) do
			local state = table.indexOf(PlayerModule.PlayerInfo.commandChallengeLayerIDs, v.Id) ~= -1
			local commandChallengeData = CommandChallengeData.New(v.Id, state)

			table.insert(m.commandChallengeDataTab, commandChallengeData)
		end
	end
end

function m.IsAllCompleted()
	for i, v in pairs(m.commandChallengeDataTab) do
		if not v.pass then
			return false
		end
	end

	return true
end

function m.CheckCommandChallengeRed()
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.COMMAND_CHALLENGE) == false then
		return false
	end

	local key = PlayerModule.PlayerInfo.baseInfo.pid
	local openState = PlayerPrefsUtil.GetInt(key, Constant.PlayerPrefsConst.Open_CommandChallenge)

	if openState == 0 then
		return true
	end

	return false
end

function m.SaveOpenCommandChallengePrefs()
	PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.Open_CommandChallenge, 1)
	EventDispatcher.Dispatch(EventID.UpdateCommandChallengeRedPointEvent)
end

function m.Shutdown()
	m.RemoveListeners()

	m.isFight = false
	m.commandChallengeDataTab = {}
end

function m.StartDrill(levelID)
	if m.isFight then
		return
	end

	m.isFight = true

	net_commandChallengeLayer.startDrill(levelID)
end

function m.StartDrillResult()
	return
end

function m.NotifyFightComplete(win, levelID, dmgRecords, getItems)
	m.isFight = false

	MainCityBattleModule.Instance:QuitBattle()

	local showItems = {}

	for i, v in pairs(getItems) do
		table.insert(showItems, v)
	end

	local rewardData = ChallengeRewardData.New(1, win, showItems, nil, dmgRecords)

	rewardData.battleType = 0

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)

	if win then
		local isFirstPass = false

		if table.indexOf(PlayerModule.PlayerInfo.commandChallengeLayerIDs, levelID) == -1 then
			table.insert(PlayerModule.PlayerInfo.commandChallengeLayerIDs, levelID)

			isFirstPass = true
		end

		for i, v in pairs(m.commandChallengeDataTab) do
			if v.cid == levelID then
				m.commandChallengeDataTab[i].pass = true
			end
		end

		EventDispatcher.Dispatch(EventID.UpdateCommandChallengeEvent, isFirstPass)
	end
end

CommandChallengeModule = m
