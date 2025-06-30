-- chunkname: @IQIGame\\Module\\UserInfo\\UserInfoModule.lua

UserInfoModule = {
	CHANGE_PLAYER_DESCRIBE = 2,
	CHANGE_PLAYER_BirthDay = 4,
	CHANGE_PLAYER_Sex = 3,
	ResetTalentCount = 0,
	ResetTimeCd = 0,
	CHANGE_PLAYER_NAME = 1
}
UserInfoModule.ShowType = {
	CG = 1,
	IMG = 2
}
UserInfoModule.Freids = {}
UserInfoModule.Heros = {}
UserInfoModule.Story = {}

function UserInfoModule.Reload(playerPODList)
	for i, v in pairs(playerPODList.heros) do
		table.insert(UserInfoModule.Heros, v)
	end

	for i, v in pairs(playerPODList.friends) do
		table.insert(UserInfoModule.Freids, v)
	end

	UserInfoModule.Story = playerPODList.baseInfo.unlockOpera

	UserInfoModule.RefreshTalentData(playerPODList.talentPOD)
end

function UserInfoModule.RefreshTalentData(talentPOD)
	UserInfoModule.Talents = talentPOD.talents
	UserInfoModule.ResetTalentCount = talentPOD.resetTalentCount
	UserInfoModule.ResetTimeCd = talentPOD.resetTimeCd
end

function UserInfoModule.LoadOpera(playerPODList)
	UserInfoModule.Story = playerPODList.unlockOpera
end

function UserInfoModule.GetPlayerInfo()
	return PlayerModule.PlayerInfo.baseInfo
end

function UserInfoModule.ChangeUserDataResult(baseInfo)
	PlayerModule.PlayerInfo.baseInfo = baseInfo

	EventDispatcher.Dispatch(EventID.InputNameUICreateNameSuccessEvent)
	EventDispatcher.Dispatch(EventID.PlayerDataChangeEvent)
end

function UserInfoModule.GetStroyCfgData(type)
	local tempTable = {}

	for k, v in pairsCfg(CfgTheStoryTable) do
		if v.Type == type then
			table.insert(tempTable, v)
		end
	end

	table.sort(tempTable, function(a, b)
		return a.Id < b.Id
	end)

	return tempTable
end

function UserInfoModule.GetSubStoryCfgData(cfgdata)
	local tempTable = {}

	for k, v in pairsCfg(CfgStoryTable) do
		if v.Team == cfgdata.Team then
			table.insert(tempTable, v)
		end
	end

	table.sort(tempTable, function(a, b)
		return a.TeamOrder < b.TeamOrder
	end)

	return tempTable
end

function UserInfoModule.CollectIsUnLock(cfgid)
	for k, v in pairs(UserInfoModule.Story) do
		if CfgTheStoryTable[cfgid].Team == CfgStoryTable[v].Team then
			return true
		end
	end

	return false
end

function UserInfoModule.SubCollectIsUnLock(cfgid)
	for k, v in pairs(UserInfoModule.Story) do
		if v == cfgid then
			return true
		end
	end

	return false
end

function UserInfoModule.GetPlayerHeroCount()
	local count = 0

	for k, v in pairs(PlayerModule.PlayerInfo.heros) do
		count = count + 1
	end

	return count
end

function UserInfoModule.GetTalentIsActive(talentId)
	return UserInfoModule.Talents[talentId] ~= nil
end

function UserInfoModule.GetTalentIsCanActive(talentId)
	local talentCfg = CfgPlayerTalentTable[talentId]

	for k, v in pairs(talentCfg.Precondition) do
		if UserInfoModule.GetTalentIsActive(v) == false then
			return false
		end
	end

	return true
end

function UserInfoModule.GetTalentAttr(type, val, zeroHandle)
	if zeroHandle and val == 0 then
		return 0
	end

	local newVal = 0

	for k, v in pairs(UserInfoModule.Talents) do
		local talentCfg = CfgPlayerTalentTable[k]

		if talentCfg ~= nil and talentCfg.EffectType == Constant.TalentEffectType.CHANGE_PLAYER_ATTR and talentCfg.EffectParam[1] == type then
			if talentCfg.EffectParam[2] == 1 then
				newVal = newVal + talentCfg.EffectParam[3]
			elseif talentCfg.EffectParam[2] == 2 then
				newVal = Mathf.Floor(newVal + val * (talentCfg.EffectParam[3] / 10000))
			end
		end
	end

	return newVal + val
end

function UserInfoModule.GetSeverPlayerInfo(pId, serverId)
	net_player.getPlayerInfo(pId, serverId)
end

function UserInfoModule.ChangeUserData(content)
	net_player.changeData(content)
end

function UserInfoModule.ActiveTalent(talentId)
	net_player.activeTalent(talentId)
end

function UserInfoModule.ResetTalent()
	net_player.resetTalent()
end

function UserInfoModule.ReceiveReChargeRebate(id)
	net_user.receiveRebate(id)
end

function UserInfoModule.TriggerEvent(type)
	net_player.triggerEvent(type)
end

function UserInfoModule.PlayerInfoResult()
	return
end

function UserInfoModule.ActiveTalentResult(talents)
	for k, v in pairs(talents) do
		UserInfoModule.Talents[k] = v
	end

	EventDispatcher.Dispatch(EventID.ActiveTalentSuccess)
end

function UserInfoModule.ResetTalentResult(talentPOD, items)
	UserInfoModule.RefreshTalentData(talentPOD)
	NoticeModule.OnNoticeGetItem(items)
	EventDispatcher.Dispatch(EventID.ResetTalentSuccess)
end

function UserInfoModule.ReceiveReChargeRebateResult(items)
	PlayerModule.PlayerInfo.baseInfo.rebate = nil

	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	EventDispatcher.Dispatch(EventID.ReceiveRechargeRebateEvent)
end
