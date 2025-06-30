-- chunkname: @IQIGame\\Module\\ActiveMagicWaxMuseum\\ActiveMagicWaxMuseumModule.lua

local m = {
	isFight = false
}
local ChallengeRewardData = require("IQIGame.Module.Challenge.ChallengeRewardData")

function m.Reload()
	return
end

function m.GetMagicWaxMuseumBossList(operateEventID)
	local tab = {}
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

	if operationEventDataPOD then
		m.mmData = operationEventDataPOD.mmData

		if m.mmData and m.mmData.bossRewardsCount then
			for i, v in pairs(m.mmData.bossRewardsCount) do
				table.insert(tab, i)
			end
		end
	end

	return tab
end

function m.GetMagicWaxMuseumBossKillState(operateEventID, magicWaxMuseumListID)
	local top = false
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

	if operationEventDataPOD then
		m.mmData = operationEventDataPOD.mmData

		if m.mmData and m.mmData.bossRewardsCount then
			local value = m.mmData.bossRewardsCount[magicWaxMuseumListID]

			top = value == 1 and true or false
		end
	end

	return top
end

function m.CheckAllMagicWaxMuseumRedPoint()
	if ActiveOperationEventModule.opEventsStatus then
		for i, v in pairs(ActiveOperationEventModule.opEventsStatus) do
			local cfg = CfgOperateEventsControlTable[v.eventCfgId]

			if cfg.Type == Constant.Activity_Operation_Type.Activity_MagicWaxMuseum then
				local top = m.CheckMagicWaxMuseumRedPoint(v.eventCfgId)

				if top then
					return true
				end
			end
		end
	end

	return false
end

function m.CheckMagicWaxMuseumRedPoint(operateEventID)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

	if operationEventDataPOD then
		m.mmData = operationEventDataPOD.mmData

		if m.mmData and m.mmData.curRound then
			local curRound = m.mmData.curRound
			local key = PlayerModule.PlayerInfo.baseInfo.pid .. curRound
			local openState = PlayerPrefsUtil.GetInt(key, Constant.PlayerPrefsConst.Open_MagicWaxMuseum)

			if openState == 0 then
				return true
			end
		end
	end

	return false
end

function m.SaveOpenMagicWaxMuseumPrefs(operateEventID)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

	if operationEventDataPOD then
		m.mmData = operationEventDataPOD.mmData

		if m.mmData and m.mmData.curRound then
			local curRound = m.mmData.curRound
			local key = PlayerModule.PlayerInfo.baseInfo.pid .. curRound

			PlayerPrefsUtil.SetInt(key, Constant.PlayerPrefsConst.Open_MagicWaxMuseum, 1)
			EventDispatcher.Dispatch(EventID.UpdateMagicWaxMuseumRedPoint)
		end
	end
end

function m.Shutdown()
	m.isFight = false
end

function m.Attack(eventId, museumId, formationId)
	if m.isFight then
		return
	end

	net_operationsMagicMuseum.attack(eventId, museumId, formationId)

	m.isFight = true
end

function m.AttackResult()
	UIModule.Close(Constant.UIControllerName.ActivityUI)
	UIModule.Close(Constant.UIControllerName.TimeLimitedBossUI)
end

function m.NotifyMuseumAttackRet(eventId, museumId, win, showList)
	MainCityBattleModule.Instance:QuitBattle()

	m.isFight = false

	local rewardData = ChallengeRewardData.New(1, win, showList, nil, nil)
	local cfg = CfgOperateEventsControlTable[eventId]

	if cfg.Function > 0 then
		JumpModule.Jump(cfg.Function)
	end

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)
end

ActiveMagicWaxMuseumModule = m
