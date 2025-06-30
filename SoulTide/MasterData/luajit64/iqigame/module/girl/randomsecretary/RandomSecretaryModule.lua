-- chunkname: @IQIGame\\Module\\Girl\\RandomSecretary\\RandomSecretaryModule.lua

local m = {
	lastChangeSecretaryTime = 0,
	allRandomSecretaryData = {},
	selectSouls = {},
	selectTypes = {}
}
local RandomSecretaryData = require("IQIGame.Module.Girl.RandomSecretary.RandomSecretaryData")

function m.Reload()
	m.allRandomSecretaryData = {}
	PlayerModule.PlayerInfo.dressUpRotateList = PlayerModule.PlayerInfo.dressUpRotateList or {}

	for i, v in pairsCfg(CfgRandomSecretaryTable) do
		local select = table.indexOf(PlayerModule.PlayerInfo.dressUpRotateList, v.Id) ~= -1
		local data = RandomSecretaryData.New(v.Id, select)

		m.allRandomSecretaryData[data.cid] = data
	end

	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.ChaneRandomSecretary()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.GIRL_ON_DUTY)

	if not result then
		return
	end

	local isOpen, dressUpRotateList = m.GetRandomDressUpRotateList()

	if #dressUpRotateList == 0 then
		return
	end

	local now = PlayerModule.GetServerTime()

	if now - m.lastChangeSecretaryTime < 1800 then
		return
	end

	m.lastChangeSecretaryTime = now

	if isOpen and #dressUpRotateList > 0 then
		local randomIndex = math.random(1, #dressUpRotateList)
		local nextCid = dressUpRotateList[randomIndex]
		local currentSoulCid = SoulModule.curSoulData.soulCid
		local nextSoulCid = CfgRandomSecretaryTable[nextCid].SoulId

		if nextSoulCid ~= currentSoulCid and nextSoulCid ~= 0 then
			SoulModule.SetCandidateSoul(nextSoulCid)
		end

		if CfgRandomSecretaryTable[nextCid].SecretaryType ~= Constant.GirlOnDutyShowType.ShowType_Oath then
			local IsWore = DressModule.CheckDressIsWore(CfgRandomSecretaryTable[nextCid].Dress)

			if not IsWore then
				DressModule.ReqWearDress(CfgRandomSecretaryTable[nextCid].Dress)
			end
		end

		PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.MainCity_Spine_BG, CfgRandomSecretaryTable[nextCid].SecretaryType)
	end
end

function m.ChangeNextRandomSecretary()
	return
end

function m.GetRandomSecretaryData(souls, types)
	local isSoul = true
	local isType = true
	local tabs = {}

	for i, v in pairs(m.allRandomSecretaryData) do
		if #souls > 0 then
			isSoul = table.indexOf(souls, v:GetCfgData().SoulId) ~= -1
		end

		if #types > 0 then
			isType = table.indexOf(types, v:GetCfgData().SecretaryType) ~= -1
		end

		if not v:GetCfgData().IsShow then
			local isCondition = ConditionModule.Check(v:GetCfgData().ShowCondition)

			if isCondition and isSoul and isType then
				table.insert(tabs, v)
			end
		end
	end

	return tabs
end

function m.GetAllSouls()
	local souls = {}

	for i, v in pairs(m.allRandomSecretaryData) do
		if table.indexOf(souls, v:GetCfgData().SoulId) == -1 then
			table.insert(souls, v:GetCfgData().SoulId)
		end
	end

	return souls
end

function m.AddSelectType(type)
	if table.indexOf(m.selectTypes, type) == -1 then
		table.insert(m.selectTypes, type)
		EventDispatcher.Dispatch(EventID.RefreshRandomSecretarySelectSoul)
	end
end

function m.RemoveSelectType(type)
	local index = table.indexOf(m.selectTypes, type)

	if index ~= -1 then
		table.remove(m.selectTypes, index)
		EventDispatcher.Dispatch(EventID.RefreshRandomSecretarySelectSoul)
	end
end

function m.RefreshRandomList()
	local ids = {}

	for i, v in pairs(m.allRandomSecretaryData) do
		if v.isSelect then
			table.insert(ids, v.cid)
		end
	end

	PlayerModule.PlayerInfo.dressUpRotateList = ids

	m.DressUpRotateList(ids)
end

function m.CheckToggleIsSelect(type)
	if table.indexOf(m.selectTypes, type) ~= -1 then
		return true
	end

	return false
end

function m.GetRandomDressUpRotateList()
	local isOpen = false

	if PlayerModule.PlayerInfo.dressUpRotateSwitch then
		isOpen = PlayerModule.PlayerInfo.dressUpRotateSwitch > 0
	end

	local dressUpRotateList = PlayerModule.PlayerInfo.dressUpRotateList or {}

	return isOpen, dressUpRotateList
end

function m.Shutdown()
	m.RemoveListeners()

	m.allRandomSecretaryData = {}
	m.selectSouls = {}
	m.selectTypes = {}
end

function m.DressUpRotateSwitch(value)
	net_player.dressUpRotateSwitch(value)
end

function m.DressUpRotateList(ids)
	net_player.dressUpRotateList(ids)
end

function m.DressUpRotateSwitchResult(value)
	if value > 0 then
		NoticeModule.ShowNotice(21043013)
	else
		NoticeModule.ShowNotice(21043014)
	end

	PlayerModule.PlayerInfo.dressUpRotateSwitch = value

	EventDispatcher.Dispatch(EventID.UpdateRandomSecretaryState)
end

function m.DressUpRotateListResult(ids)
	PlayerModule.PlayerInfo.dressUpRotateList = ids

	for i, v in pairs(m.allRandomSecretaryData) do
		v.isSelect = table.indexOf(PlayerModule.PlayerInfo.dressUpRotateList, v.cid) ~= -1
	end
end

RandomSecretaryModule = m
