-- chunkname: @IQIGame\\Module\\Soul\\SoulModule.lua

require("IQIGame.Module.Soul.SoulSpecialSpiritModule")

SoulModule = {
	spineNeedGreet = true,
	CandidateSoulCid = 0,
	soulDataDic = {},
	whisperResNeedUpdateSizes = {}
}

function SoulModule.Initialize()
	L2DModule.Instance:SetPathPrefix(UIGlobalApi.Live2DResRootPath)
end

function SoulModule.Shutdown()
	SoulModule.curSoulData = nil

	PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.Offline, PlayerModule.GetServerTime())

	SoulModule.whisperResNeedUpdateSizes = {}
end

function SoulModule.Reload(soulPODList)
	SoulSpecialSpiritModule.Init()

	local offlineSeconds = PlayerPrefsUtil.GetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.Offline, 0)

	if offlineSeconds == 0 then
		offlineSeconds = PlayerModule.GetServerTime()
	end

	PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.Offline, PlayerModule.GetServerTime())
	L2DModule.Instance:SetOfflineTime(offlineSeconds)
	L2DModule.Instance:SetLoginTime(PlayerModule.GetServerTime())

	local PODDic = {}

	for i, v in pairs(soulPODList) do
		PODDic[v.cid] = v
	end

	local sortNo = {}

	for i, v in pairsCfg(CfgSoulTable) do
		if v.SoulType == 1 then
			sortNo[#sortNo + 1] = v.Id
		end
	end

	local soulCid2NoDic = {}

	table.sort(sortNo, function(a, b)
		return a < b
	end)

	for i, v in ipairs(sortNo) do
		soulCid2NoDic[v] = i
	end

	for i, v in pairsCfg(CfgSoulTable) do
		if v.SoulType == 1 then
			SoulModule.CreateSoulData(v.Id, PODDic[v.Id], soulCid2NoDic[v.Id])

			sortNo[#sortNo + 1] = v.Id
		end
	end

	local selectedSoulCid = PlayerModule.PlayerInfo.baseInfo.showSoulCid

	if #soulPODList == 0 then
		selectedSoulCid = nil
	end

	SoulModule.SetCurSoulData(selectedSoulCid)
end

function SoulModule.CreateSoulData(soulCid, soulPOD, No)
	local soulData = SoulData.New()

	soulData:Initialize(soulCid, soulPOD, No)
	L2DModule.Instance:SetMoodState(soulData.soulCid, SoulModule.GetMoodState(soulData.soulCid, soulData.mood))
	L2DModule.Instance:SetLoveUIStyle(soulData.soulCid, soulData.favorLv)
	L2DModule.Instance:SetDailyDislike(soulData.soulCid, soulData.dailyDislike)

	SoulModule.soulDataDic[soulCid] = soulData
end

function SoulModule.CreateCustomSoulData(soulCid, soulCustomPOD)
	local soulData = SoulData.New()

	soulData:Initialize(soulCid, soulCustomPOD)

	return soulData
end

function SoulModule.Sort(tb1, tb2)
	if tb1.isUnlock == tb2.isUnlock then
		if tb1.lv == tb2.lv then
			if tb1:GetCfgSoulQuality().Quality == tb2:GetCfgSoulQuality().Quality then
				if tb1:GetCfgSoulQuality().QualityLevel == tb2:GetCfgSoulQuality().QualityLevel then
					return tb1.soulCid < tb2.soulCid
				end

				return tb1:GetCfgSoulQuality().QualityLevel > tb2:GetCfgSoulQuality().QualityLevel
			end

			return tb1:GetCfgSoulQuality().Quality > tb2:GetCfgSoulQuality().Quality
		end

		return tb1.lv > tb2.lv
	end

	return tb1.isUnlock
end

function SoulModule.SortFavorValue(tb1, tb2)
	local aq = tonumber(tb1.FavorValue)
	local bq = tonumber(tb2.FavorValue)

	return bq < aq
end

function SoulModule.BuildL2D(l2dBuilderComp, soulData, cfgDressData)
	l2dBuilderComp:StartBuild(soulData.soulCid, cfgDressData.SoulResID)
	l2dBuilderComp:SetParam("ParamRingOn", soulData.oathActivation and 1 or 0, nil)
end

function SoulModule.ChangeL2DSkin(l2dBuilderComp, soulData, cfgDressData)
	l2dBuilderComp:ChangeSkin(cfgDressData.SoulResID)
	l2dBuilderComp:SetParam("ParamRingOn", soulData.oathActivation and 1 or 0, nil)
end

function SoulModule.GetMaxSoulLv()
	return PlayerModule.PlayerInfo.baseInfo.pLv
end

function SoulModule.GetCanUpLv(curLv, maxLv, addExp)
	local cfgData = CfgSoulLevelTable[curLv]

	if PlayerModule.PlayerInfo.baseInfo.pLv < cfgData.NeedPlayerLv then
		return curLv
	elseif maxLv <= curLv then
		return maxLv
	else
		local needExp = cfgData.NextEXP
		local leftExp = addExp - needExp

		if leftExp >= 0 then
			return SoulModule.GetCanUpLv(curLv + 1, maxLv, leftExp)
		else
			return curLv
		end
	end
end

function SoulModule.GetCfgSoulFavor(soulCid, favorLv)
	for i, v in pairsCfg(CfgSoulFavorTable) do
		if v.SoulID == soulCid and v.FavorDegree == favorLv then
			return v
		end
	end

	return nil
end

function SoulModule.CheckExistCanUnlockSoul()
	for i, v in pairs(SoulModule.soulDataDic) do
		if v:CheckCanUnlock() == true then
			return true
		end
	end

	return false
end

function SoulModule.SetCurSoulData(soulCid)
	if SoulModule.curSoulData == nil or SoulModule.curSoulData.soulCid ~= soulCid then
		SoulModule.curSoulData = SoulModule.soulDataDic[soulCid]
		SoulModule.CandidateSoulCid = 0

		EventDispatcher.Dispatch(EventID.UpdateGirlOnDutyEvent, soulCid)
	end
end

function SoulModule.SetCandidateSoul(soulCid)
	SoulModule.CandidateSoulCid = soulCid

	SoulModule.ReqSoulChanged(soulCid)
end

function SoulModule.ChangeToCandidate()
	local candidate = SoulModule.CandidateSoulCid

	if candidate == 0 then
		return
	end

	SoulModule.SetCurSoulData(candidate)
end

function SoulModule.GetSoulData(soulCid)
	local ret = SoulModule.soulDataDic[soulCid]

	return ret
end

function SoulModule.GetSortedSoulDataList()
	local ret = {}

	for i, v in pairs(SoulModule.soulDataDic) do
		ret[#ret + 1] = v
	end

	table.sort(ret, SoulModule.Sort)

	return ret
end

function SoulModule.GetSortedUnlockSoulDataList()
	local ret = {}
	local sortedList = SoulModule.GetSortedSoulDataList()

	for i, v in ipairs(sortedList) do
		if v.isUnlock == true then
			ret[#ret + 1] = v
		end
	end

	return ret
end

function SoulModule.GetSortedUnlockSoulDataListOnNewGuide()
	local ret = {}
	local roleID = 20010012
	local roleData
	local sortedList = SoulModule.GetSortedSoulDataList()

	for i, v in ipairs(sortedList) do
		if v.isUnlock == true then
			if v.soulCid ~= roleID then
				ret[#ret + 1] = v
			else
				roleData = v
			end
		end
	end

	table.insert(ret, 1, roleData)

	return ret
end

function SoulModule.GetCanUnlockSoulIDList()
	local ret = {}

	for i, v in pairs(SoulModule.soulDataDic) do
		if v:CheckCanUnlock() == true then
			ret[#ret + 1] = v.soulCid
		end
	end

	return ret
end

function SoulModule.GetUnlockSoulDataDic()
	local ret = {}

	for i, v in pairs(SoulModule.soulDataDic) do
		if v.isUnlock == true then
			ret[v.soulCid] = v
		end
	end

	return ret
end

function SoulModule.GetFavorLv(soulID, favor)
	local numTab = {}

	for i, v in pairsCfg(CfgSoulFavorTable) do
		if v.SoulID == soulID then
			numTab[#numTab + 1] = v
		end
	end

	table.sort(numTab, SoulModule.SortFavorValue)

	for i = 1, #numTab do
		if favor >= numTab[i].FavorValue then
			return numTab[i].FavorDegree
		end
	end

	return 1
end

function SoulModule.CheckTalentGroupIsActivated(soulData, id)
	return table.indexOf(soulData.talentGroupCids, id) ~= -1
end

function SoulModule.CheckTalentIsActivated(soulData, id)
	return table.indexOf(soulData.talentCids, id) ~= -1
end

function SoulModule.CheckExistTalentCanActive(soulData, groupId)
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.SOUL_TALENT) == false then
		return false
	end

	if SoulModule.CheckTalentGroupIsActivated(soulData, groupId) then
		return false
	end

	local cfgGroupData = CfgSoulTalentGroupTable[groupId]

	if cfgGroupData.PreGroup == 0 or SoulModule.CheckTalentGroupIsActivated(soulData, cfgGroupData.PreGroup) then
		for i, v in pairsCfg(CfgSoulTalentTable) do
			if v.GroupId == groupId and not SoulModule.CheckTalentIsActivated(soulData, v.Id) and soulData.lv >= v.ActivationLv then
				if #v.PreTalent == 0 then
					return SoulModule.CheckIsEnoughToActivateTalent(v.Id)
				elseif SoulModule.CheckTalentIsActivated(soulData, v.PreTalent[1]) and SoulModule.CheckIsEnoughToActivateTalent(v.Id) then
					return true
				end
			end
		end

		return false
	else
		return false
	end
end

function SoulModule.CheckExistTalentGroupCanActive(soulData, groupCid)
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.SOUL_TALENT) == false then
		return false
	end

	if SoulModule.CheckTalentGroupIsActivated(soulData, groupCid) then
		return false
	end

	for i, v in pairsCfg(CfgSoulTalentTable) do
		if v.GroupId == groupCid and not SoulModule.CheckTalentIsActivated(soulData, v.Id) then
			return false
		end
	end

	local cfgGroupData = CfgSoulTalentGroupTable[groupCid]

	if soulData.lv < cfgGroupData.UnlockLv then
		return false
	end

	return true
end

function SoulModule.CheckIsEnoughToActivateTalent(talentCid)
	local ret = true
	local cfgTalent = CfgSoulTalentTable[talentCid]

	for m, n in pairs(cfgTalent.Cost) do
		if m % 2 ~= 0 then
			local id = n
			local needCount = cfgTalent.Cost[m + 1]

			if needCount > WarehouseModule.GetItemNumByCfgID(id) then
				ret = false

				break
			end
		end
	end

	return ret
end

function SoulModule.CheckSoulStarCanUp(soulData)
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.SOUL_UP_STAR) == false then
		return false
	end

	if soulData:CheckFullQuality() then
		return false
	end

	local ids = soulData:GetUpQualityLvItemIds()

	for i, v in ipairs(ids) do
		local ownCount = WarehouseModule.GetItemNumByCfgID(v)
		local needCount = soulData:GetCostCountOnStageItem(v)

		if ownCount < needCount then
			return false
		end
	end

	return true
end

function SoulModule.CheckSoulLvCanUp(soulData)
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.SOUL_UP_LV) == false then
		return false
	end

	if soulData.lv >= SoulModule.GetMaxSoulLv() then
		return false
	end

	local cfgData = CfgSoulLevelTable[soulData.lv]

	if PlayerModule.PlayerInfo.baseInfo.pLv < cfgData.NeedPlayerLv then
		return false
	end

	if soulData.exp >= CfgSoulLevelTable[soulData.lv].NextEXP then
		return false
	end

	local cfgData = CfgDiscreteDataTable[6506030]
	local curExp = soulData.exp
	local needExp = CfgSoulLevelTable[soulData.lv].NextEXP
	local totalExp = 0

	for i = 1, 4 do
		local startIndex = i + (i - 1)
		local ownCount = WarehouseModule.GetItemNumByCfgID(cfgData.Data[startIndex])
		local addExp = cfgData.Data[startIndex + 1]

		totalExp = totalExp + ownCount * addExp
	end

	if totalExp < needExp - curExp then
		return false
	end

	return true
end

function SoulModule.CheckSkillUpRedPoint(soulData, cfgSkillData, groupCid)
	if SkillModule.CheckSkillGroupUnlock(soulData, groupCid) then
		return SkillModule.CheckSkillCanUp(soulData, cfgSkillData)
	end

	return false
end

function SoulModule.CheckSoulStarUpRedPoint(soulData)
	return SoulModule.CheckSoulStarCanUp(soulData)
end

function SoulModule.CheckSoulLvUpRedPoint(soulData)
	return SoulModule.CheckSoulLvCanUp(soulData)
end

function SoulModule.CheckSoulListRedPoint(soulData)
	if soulData.isUnlock == false then
		return false
	end

	if SoulModule.CheckSoulStarUpRedPoint(soulData) then
		return true
	end

	return false
end

function SoulModule.CheckSkillTabRedPoint(soulData)
	for i, v in pairs(CfgSoulTable[soulData.soulCid].DefaultSkill) do
		local cfgGroupData = CfgSkillGroupTable[v]

		if SkillModule.CheckSkillGroupUnlock(soulData, cfgGroupData.Id) then
			for m, n in pairs(cfgGroupData.GroupSkills) do
				if SoulModule.CheckSkillUpRedPoint(soulData, CfgSkillTable[n], v) then
					return true
				end
			end
		elseif SkillModule.CheckSkillGroupCanUnlock(soulData, cfgGroupData) then
			return true
		end
	end

	return false
end

function SoulModule.CheckTalentTabRedPoint(soulData)
	for i, v in pairs(CfgSoulTable[soulData.soulCid].TalentGroupId) do
		if SoulModule.CheckExistTalentGroupCanActive(soulData, v) then
			return true
		end

		if SoulModule.CheckExistTalentCanActive(soulData, v) then
			return true
		end
	end

	return false
end

function SoulModule.CheckMainSoulRedPoint()
	if SoulModule.CheckExistCanUnlockSoul() then
		return true
	end

	for i, v in pairs(SoulModule.soulDataDic) do
		if SoulModule.CheckSoulListRedPoint(v) then
			return true
		end
	end

	return false
end

function SoulModule.CheckExistNeedRecover()
	local fullStartSoulDatum = {}

	for i, v in pairs(SoulModule.GetUnlockSoulDataDic()) do
		local cfgData = v:GetCfgSoulQuality()

		if cfgData.Quality == 5 then
			fullStartSoulDatum[#fullStartSoulDatum + 1] = v
		end
	end

	for i, v in pairs(fullStartSoulDatum) do
		local cfgData = CfgSoulTable[v.soulCid]
		local itemCid = cfgData.UnlockItem[1]
		local ownCount = WarehouseModule.GetItemNumByCfgID(itemCid)

		if ownCount > 0 then
			return true
		end
	end

	return false
end

function SoulModule.CheckSpRedPoint(soulData)
	if SoulModule.CheckSpAttRedPoint(soulData) then
		return true
	end

	if SoulModule.CheckAnySpSkillRedPoint(soulData) then
		return true
	end

	return false
end

function SoulModule.CheckSpAttRedPoint(soulData)
	return SoulModule.CheckSpCanActive(soulData.cfgSoulSpDataAttToActive, soulData)
end

function SoulModule.CheckSpSkillRedPoint(soulData, spSkillIndex)
	return SoulModule.CheckSpCanActive(soulData.cfgSoulSpDataSkillToActive[spSkillIndex], soulData)
end

function SoulModule.CheckAnySpSkillRedPoint(soulData)
	for i = 1, SoulSpecialSpiritModule.GetSpSkillNum() do
		if soulData.cfgSoulSpDataSkillToActive[i] ~= nil and SoulModule.CheckSpCanActive(soulData.cfgSoulSpDataSkillToActive[i], soulData) then
			return true
		end
	end

	return false
end

function SoulModule.CheckSpCanActive(cfgSpData, soulData)
	if cfgSpData == nil then
		return false
	end

	if soulData.lv < cfgSpData.NeedSoulLevel then
		return false
	end

	for i, v in ipairs(cfgSpData.Cost) do
		if i % 2 ~= 0 and WarehouseModule.GetItemNumByCfgID(v) < cfgSpData.Cost[i + 1] then
			return false
		end
	end

	if #cfgSpData.NeedSkillLv > 1 and SkillModule.GetSkillLv(cfgSpData.NeedSkillLv[1], soulData) < cfgSpData.NeedSkillLv[2] then
		return false
	end

	for i, v in ipairs(cfgSpData.PreSpirit) do
		if i % 2 ~= 0 then
			local needGroup = v
			local needLv = cfgSpData.PreSpirit[i + 1]

			if needGroup == 1 then
				if soulData.cfgSoulSpDataAtt == nil or needLv > soulData.cfgSoulSpDataAtt.Level then
					return false
				end
			elseif SoulSpecialSpiritModule.IsSpSkillGroup(needGroup) then
				local skillIndex = SoulSpecialSpiritModule.GetSpSkillIndex(needGroup)

				if soulData.CfgSoulSpecialSpirits[skillIndex] == nil or needLv > soulData.CfgSoulSpecialSpirits[skillIndex].Level then
					return false
				end
			end
		end
	end

	return true
end

function SoulModule.GetWhisperResTag(soulCid)
	if soulCid == nil then
		logError("soulCid不能为空")

		return nil
	end

	local cfgSoulMarryData = GirlModule.GetSoulOathData(soulCid)

	if cfgSoulMarryData == nil or cfgSoulMarryData.WhisperResTag == 0 then
		logError(string.format("找不到 soulCid: %s 对应的誓约数据，或誓约数据没有配置正确的WhisperResTag"))

		return nil
	end

	return cfgSoulMarryData.WhisperResTag
end

function SoulModule.ReqUpQuality(soulCid)
	local soulData = SoulModule.GetSoulData(soulCid)

	SoulModule.lastUpStarAtts = table.clone(soulData.atts)

	net_soul.evolution(soulCid)
end

function SoulModule.OnResultSoulEvolution(soul)
	SoulModule.soulDataDic[soul.cid]:OnEvolveSuccess(soul)
	EventDispatcher.Dispatch(EventID.EvolveSoulSuccess, soul)
end

function SoulModule.ReqAddExp(soulCid, id2CountDic)
	local soulData = SoulModule.GetSoulData(soulCid)

	SoulModule.lastUpSoul = soulData
	SoulModule.lastUpSoulLv = soulData.lv
	SoulModule.lastUpSoulAtts = table.clone(soulData.atts)

	net_soul.useSoulExpItem(soulCid, id2CountDic)
end

function SoulModule.OnReqAddExp()
	EventDispatcher.Dispatch(EventID.SoulExpAddSuccess, SoulModule.lastUpSoul)
end

function SoulModule.ReqUnlockSkill(soulCid, skillCid)
	SoulModule.lastUnlockSkillCid = skillCid

	net_soul.unlockSkill(soulCid, skillCid)
end

function SoulModule.OnReqUnlockSkill()
	NoticeModule.ShowNotice(21041008)
	EventDispatcher.Dispatch(EventID.SoulSkillUnlockSuccess, SoulModule.lastUnlockSkillCid)
end

function SoulModule.ReqActiveSpecialSpirit(soulData, cfgSpData)
	if cfgSpData == nil then
		return
	end

	if soulData.lv >= cfgSpData.NeedSoulLevel then
		for i, v in ipairs(cfgSpData.Cost) do
			if i % 2 ~= 0 and WarehouseModule.GetItemNumByCfgID(v) < cfgSpData.Cost[i + 1] then
				NoticeModule.ShowNoticeNoCallback(21059004)

				return
			end
		end

		if #cfgSpData.NeedSkillLv > 1 and SkillModule.GetSkillLv(cfgSpData.NeedSkillLv[1], soulData) < cfgSpData.NeedSkillLv[2] then
			return
		end

		net_soul.activeSpecialSpirit(soulData.soulCid, cfgSpData.Id)
	end
end

function SoulModule.OnReqActiveSpecialSpiritResult(soulCid, id)
	for i, v in pairsCfg(CfgSoulSpecialSpiritTable) do
		if v.Id == id then
			EventDispatcher.Dispatch(EventID.SoulSpiritActiveSuccess, v)

			return
		end
	end
end

function SoulModule.ReqUnlockSoul(soulID)
	net_soul.unlock(soulID)
end

function SoulModule.OnResultUnlockSoul(code)
	if code ~= 0 then
		EventDispatcher.Dispatch(EventID.SoulUnlockFailure)
	end
end

function SoulModule.OnUpdateSoul(data)
	local soulData = SoulModule.soulDataDic[data.cid]

	if soulData == nil then
		return
	end

	if soulData.isUnlock == true then
		soulData:OnUpdate(data)
	else
		if SoulModule.curSoulData == nil then
			SoulModule.SetCurSoulData(data.cid)
		end

		soulData:OnUpdate(data)
		EventDispatcher.Dispatch(EventID.SoulUnlockSuccess, data.cid)
	end

	EventDispatcher.Dispatch(EventID.SoulDataChange, data.cid)
end

function SoulModule.ReqResetTalent(soulCid)
	net_soul.resetTalent(soulCid)
end

function SoulModule.OnReqResetTalent(soulPOD, getItems)
	SoulModule.OnUpdateSoul(soulPOD)
	EventDispatcher.Dispatch(EventID.SoulTalentResetSuccess, soulPOD.cid)
end

function SoulModule.ReqActivateTalent(soulCid, talentCid)
	SoulModule.lastActivatedTalentCid = talentCid

	net_soul.activeTalent(soulCid, talentCid)
end

function SoulModule.OnResultActivateTalent(soul)
	SoulModule.soulDataDic[soul.cid]:OnUpdate(soul)
	EventDispatcher.Dispatch(EventID.ActivateTalentSuccess, SoulModule.lastActivatedTalentCid)
end

function SoulModule.ReqActiveTalentGroup(soulCid, groupCid)
	net_soul.activeTalentGroup(soulCid, groupCid)
end

function SoulModule.OnReqActiveTalentGroupResult(soul)
	SoulModule.soulDataDic[soul.cid]:OnUpdate(soul)
	EventDispatcher.Dispatch(EventID.ActivateGroupSuccess)
end

function SoulModule.ReqSoulChanged(soulCid)
	if PlayerModule.PlayerInfo.baseInfo.showSoulCid == soulCid then
		return
	end

	GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.SelectSoul))
	net_player.changeShowSoul(soulCid)
end

function SoulModule.ActivationSkillStrengthen(soulCid, skillCId, skillStrengthenCid)
	SoulModule.lastStrengthenSkillCid = skillCId

	net_soul.activationSkillStrengthen(soulCid, skillCId, skillStrengthenCid)
end

function SoulModule.ActivationSkillStrengthenResult()
	NoticeModule.ShowNotice(21041010)
	EventDispatcher.Dispatch(EventID.SoulSkillStrengthenUpSuccess, SoulModule.lastStrengthenSkillCid)
end

function SoulModule.ChangeShowSoulResult()
	RandomSecretaryModule.lastChangeSecretaryTime = PlayerModule.GetServerTime()

	NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, GirlUIApi:GetString("ChangeShowSoul"))
	SDKLoginModule.LogChangeShowGirl(0, SoulModule.curSoulData.soulCid, SoulModule.curSoulData.dressCid2D, SoulModule.curSoulData.dressCid3D)
end

function SoulModule.UpdateSoulMood(soulCid, oldMood, nowMood, type)
	local soulData = SoulModule.soulDataDic[soulCid]

	if soulData then
		soulData:OnUpdateMood(nowMood)
	end

	EventDispatcher.Dispatch(EventID.SoulUpdateMood, soulCid, oldMood, nowMood, type)
end

function SoulModule.GetMoodState(soulCid, mood)
	local state = 1

	for k, v in pairsCfg(CfgSoulMoodTable) do
		if v.SoulId == soulCid then
			for i = 1, #v.MoodLevelRange, 2 do
				local min = v.MoodLevelRange[i]
				local max = v.MoodLevelRange[i + 1]

				if min <= mood and mood <= max then
					state = math.ceil(i / 2)

					break
				end
			end
		end
	end

	return state
end

function SoulModule.GetMoodPer(soulCid, mood)
	local per = 0

	for k, v in pairsCfg(CfgSoulMoodTable) do
		if v.SoulId == soulCid then
			local max = v.MoodRange[2]

			per = mood / max
		end
	end

	return per
end

function SoulModule.UnlockWhenSoulExisted(soulCid)
	for cid, soulData in pairs(SoulModule.soulDataDic) do
		if cid == soulCid then
			soulData.insecureNotFirstUnlock = true

			break
		end
	end
end

function SoulModule.GetMySoulFeatures(soulCid)
	local soulData = SoulModule.GetSoulData(soulCid)

	return SoulModule.GetFeatures(soulCid, soulData.soulQualityCid)
end

function SoulModule.GetFeatures(soulCid, soulQualityCid)
	local qualityFeatureMap = {}
	local currentQuality, maxQuality

	for id, cfgSoulQualityData in pairsCfg(CfgSoulQualityTable) do
		if cfgSoulQualityData.SoulId == soulCid then
			qualityFeatureMap[cfgSoulQualityData.Quality] = cfgSoulQualityData.ADDSkillID

			if cfgSoulQualityData.Id == soulQualityCid then
				currentQuality = cfgSoulQualityData.Quality
			end

			if cfgSoulQualityData.NextLevel == 0 then
				maxQuality = cfgSoulQualityData.Quality
			end

			if maxQuality ~= nil then
				local notComplete = false

				for quality = 1, maxQuality do
					if qualityFeatureMap[quality] == nil then
						notComplete = true

						break
					end
				end

				if not notComplete then
					break
				end
			end
		end
	end

	local allFeatures = qualityFeatureMap[maxQuality]
	local featureUnlockQuality = {}

	for i = 1, #allFeatures do
		local skillCid = allFeatures[i]

		for quality, features in pairs(qualityFeatureMap) do
			local isUnlockAtThisQuality = table.indexOf(features, skillCid) ~= -1

			if isUnlockAtThisQuality then
				featureUnlockQuality[skillCid] = math.min(featureUnlockQuality[skillCid] or Constant.Number.IntMaxValue, quality)
			end
		end
	end

	return qualityFeatureMap[currentQuality], allFeatures, featureUnlockQuality
end
