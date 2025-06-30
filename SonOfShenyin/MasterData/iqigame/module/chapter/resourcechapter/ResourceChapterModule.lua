-- chunkname: @IQIGame\\Module\\Chapter\\ResourceChapter\\ResourceChapterModule.lua

ResourceChapterModule = {
	ChapterList = {},
	FinishDupList = {}
}

local resourceChapterData = require("IQIGame.Module.Chapter.ResourceChapter.ResourceChapterData")

function ResourceChapterModule.Reload(DailyDupPOD)
	ResourceChapterModule.ChapterList = {}
	ResourceChapterModule.FinishDupList = {}

	local allCfgBossChapter = ResourceChapterModule.GetAllBossChapterByCfg()

	for k, v in pairs(allCfgBossChapter) do
		local chapterData

		if DailyDupPOD ~= nil and DailyDupPOD[v.Id] ~= nil then
			ResourceChapterModule.RefreshFinishDup(DailyDupPOD[v.Id].passStatus)

			chapterData = resourceChapterData.New(DailyDupPOD[v.Id], ResourceChapterModule.GetResourcePassByChapterID(v.Id))
		else
			ResourceChapterModule.RefreshFinishDup({
				cid = 0
			})

			chapterData = resourceChapterData.New({
				extraReward = 0,
				cid = v.Id,
				passStatus = {}
			}, ResourceChapterModule.GetResourcePassByChapterID(v.Id))
		end

		table.insert(ResourceChapterModule.ChapterList, v.Id, chapterData)
	end

	ResourceChapterModule.FristCondition()
end

function ResourceChapterModule.GetDupPODByID(id)
	return ResourceChapterModule.ChapterList[id]
end

function ResourceChapterModule.GetAllResourceChapters()
	local chapterList = {}

	for k, v in pairs(ResourceChapterModule.ChapterList) do
		if v:SubStageIsUnLock() and v:IsOpen() then
			table.insert(chapterList, v)
		end
	end

	table.sort(chapterList, function(a, b)
		return a:GetCfg().Index < b:GetCfg().Index
	end)

	return chapterList
end

function ResourceChapterModule.GetAllBossChapterByCfg()
	local chapterList = {}

	for k, v in pairsCfg(CfgDailyDupChapterTable) do
		table.insert(chapterList, v)
	end

	table.sort(chapterList, function(a, b)
		return a.Id < b.Id
	end)

	return chapterList
end

function ResourceChapterModule.GetResourcePassByChapterID(chapterID)
	local passTable = {}

	for k, v in pairsCfg(CfgDailyDupStageTable) do
		if v.ChapterId == chapterID then
			table.insert(passTable, v)
		end
	end

	table.sort(passTable, function(a, b)
		return a.Id < b.Id
	end)

	return passTable
end

function ResourceChapterModule.RefreshFinishDup(passStatus)
	for k, v in pairs(passStatus) do
		if v == 1 then
			table.insert(ResourceChapterModule.FinishDupList, k)
		end
	end
end

function ResourceChapterModule.GetNewUnLockPass(passStatus)
	local index = 0

	for k, v in pairs(passStatus) do
		if ConditionModule.Check(v:GetCfg().UnlockConditionId) then
			index = index + 1
		end
	end

	return index
end

function ResourceChapterModule.FristCondition()
	return UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_DAILY_DUP)
end

function ResourceChapterModule.EnterDup(passId, fightCount, units, agentSkill)
	net_dailyDup.enterDup(passId, fightCount, units, agentSkill)
end

function ResourceChapterModule.SweepDup(passId, fightCount)
	net_dailyDup.sweepDup(passId, fightCount)
end

function ResourceChapterModule.SweepDupSucceed(code, shows)
	EventDispatcher.Dispatch(EventID.SweepDupResultEvent)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, shows)
end

function ResourceChapterModule.NotifyDup(DailyDupPOD)
	for k, v in pairs(DailyDupPOD) do
		ResourceChapterModule.ChapterList[v.cid]:RefreshData(v, ResourceChapterModule.GetResourcePassByChapterID(v.cid))
		ResourceChapterModule.RefreshFinishDup(v.passStatus)
	end
end
