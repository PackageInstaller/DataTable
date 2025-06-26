-- chunkname: @IQIGame\\Module\\Chapter\\BossChapter\\BossChapterModule.lua

BossChapterModule = {
	RewardCount = 0,
	ConsumeCount = 0,
	ChapterList = {},
	FinishDupList = {}
}

local bossChapterData = require("IQIGame.Module.Chapter.BossChapter.BossChapterData")

function BossChapterModule.Reload(DupPOD)
	BossChapterModule.ChapterList = {}
	BossChapterModule.FinishDupList = {}
	BossChapterModule.FinishConsumeChapterList = {}
	BossChapterModule.FinishRewardChapterList = {}

	local allCfgBossChapter = BossChapterModule.GetAllBossChapterByCfg()

	for k, v in pairs(allCfgBossChapter) do
		local chapterData

		if DupPOD ~= nil and DupPOD[v.Id] ~= nil then
			BossChapterModule.RefreshFinishDup(DupPOD[v.Id].passStatus)

			chapterData = bossChapterData.New(DupPOD[v.Id], BossChapterModule.GetResourcePassByChapterID(v.Id))
			BossChapterModule.FinishConsumeChapterList[v.Id] = DupPOD[v.Id].powerTime
			BossChapterModule.FinishRewardChapterList[v.Id] = DupPOD[v.Id].prizeTime
		else
			BossChapterModule.RefreshFinishDup({
				cid = 0
			})

			chapterData = bossChapterData.New({
				prizeTime = 0,
				powerTime = 0,
				cid = v.Id,
				passStatus = {}
			}, BossChapterModule.GetResourcePassByChapterID(v.Id))
		end

		table.insert(BossChapterModule.ChapterList, v.Id, chapterData)
	end
end

function BossChapterModule.GetAllResourceChapters()
	local chapterList = {}

	for k, v in pairs(BossChapterModule.ChapterList) do
		table.insert(chapterList, v)
	end

	table.sort(chapterList, function(a, b)
		return a.Index < b.Index
	end)

	return chapterList
end

function BossChapterModule.GetChapterDataWithTag(tag)
	local array = {}

	for _, v in pairs(BossChapterModule.ChapterList) do
		if v:GetCfg().Tag == tag then
			table.insert(array, v)
		end
	end

	table.sort(array, function(a, b)
		return a.Index < b.Index
	end)

	return array
end

function BossChapterModule.GetChapterDataWithType(type)
	local array = {}

	for _, v in pairs(BossChapterModule.ChapterList) do
		if v:GetCfg().Type == type then
			table.insert(array, v)
		end
	end

	table.sort(array, function(a, b)
		return a.Index < b.Index
	end)

	return array
end

function BossChapterModule.GetAllBossChapterByCfg()
	local chapterList = {}

	for k, v in pairsCfg(CfgBossChapterTable) do
		table.insert(chapterList, v)
	end

	table.sort(chapterList, function(a, b)
		return a.Id < b.Id
	end)

	return chapterList
end

function BossChapterModule.GetResourcePassByChapterID(chapterID)
	local passTable = {}

	for k, v in pairsCfg(CfgBossStageTable) do
		if v.ChapterId == chapterID then
			table.insert(passTable, v)
		end
	end

	table.sort(passTable, function(a, b)
		return a.Id < b.Id
	end)

	return passTable
end

function BossChapterModule.RefreshFinishDup(passStatus)
	for k, v in pairs(passStatus) do
		if v == 1 then
			table.insert(BossChapterModule.FinishDupList, k)
		end
	end
end

function BossChapterModule.GetNewUnLockPass(chapterID)
	local passList = BossChapterModule.ChapterList[chapterID]
	local index = 0

	for k, v in pairs(passList.passStatus) do
		if ConditionModule.Check(v:GetCfg().UnlockConditionId) then
			index = index + 1
		end
	end

	return index
end

function BossChapterModule.ReduceConsumeCount()
	BossChapterModule.ConsumeCount = 0

	for k, v in pairs(BossChapterModule.FinishConsumeChapterList) do
		BossChapterModule.ConsumeCount = BossChapterModule.ConsumeCount + v
	end

	return CfgDiscreteDataTable[43].Data[1] - BossChapterModule.ConsumeCount <= 0 and 0 or CfgDiscreteDataTable[43].Data[1] - BossChapterModule.ConsumeCount
end

function BossChapterModule.ReduceRewardCount()
	BossChapterModule.RewardCount = 0

	for k, v in pairs(BossChapterModule.FinishRewardChapterList) do
		BossChapterModule.RewardCount = BossChapterModule.RewardCount + v
	end

	return BossChapterModule.RewardCount
end

function BossChapterModule.ReduceStrength(strength)
	return strength * (CfgDiscreteDataTable[43].Data[2] * 0.01)
end

function BossChapterModule.GetMonsterTeam(monsterTeamId)
	local team = {}

	for k, v in pairs(CfgMonsterTeamTable[monsterTeamId].MonsterTeam) do
		if v ~= 0 then
			table.insert(team, v)
		end
	end

	return team
end

function BossChapterModule.GetChapterIsPass(chapterID)
	local passtable = BossChapterModule.ChapterList[chapterID].passStatus

	if passtable == nil then
		return false
	end

	for k, v in pairs(passtable) do
		if v ~= nil and v.Status == 1 then
			return true
		end
	end

	return false
end

function BossChapterModule.FristCondition()
	return UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_CHAPTER_BOOS)
end

function BossChapterModule.GetMarkWithScore(bossChapterId, score)
	local cfgBossChapter = CfgUtil.GetCfgBossChapterDataWithID(bossChapterId)

	if score == 0 then
		return "null"
	end

	local scoreArray = cfgBossChapter.PassedLevelScore
	local len = #scoreArray

	for i = 1, len do
		if score < scoreArray[i] then
			if i == 1 then
				return "D"
			elseif i == 2 then
				return "C"
			elseif i == 3 then
				return "B"
			elseif i == 4 then
				return "A"
			elseif i == 5 then
				return "S"
			elseif i == 6 then
				return "SS"
			elseif i == 7 then
				return "SSS"
			end
		end
	end

	return "SSS"
end

function BossChapterModule.EnterDup(passId, units, agentSkill)
	net_bossDup.enterDup(passId, units, agentSkill)
end

function BossChapterModule.NotifyDup(DupPOD)
	for k, v in pairs(DupPOD) do
		BossChapterModule.ChapterList[v.cid]:RefreshData(v, BossChapterModule.GetResourcePassByChapterID(v.cid))
		BossChapterModule.RefreshFinishDup(v.passStatus)

		BossChapterModule.FinishConsumeChapterList[v.cid] = v.powerTime
		BossChapterModule.FinishRewardChapterList[v.cid] = v.prizeTime
	end
end
