-- chunkname: @IQIGame\\Module\\Chapter\\EquipChapter\\EquipChapterModule.lua

EquipChapterModule = {
	ChapterList = {},
	FinishDupList = {}
}

local equipChapterData = require("IQIGame.Module.Chapter.EquipChapter.EquipChapterData")

function EquipChapterModule.Reload(DupPOD)
	EquipChapterModule.ChapterList = {}
	EquipChapterModule.FinishDupList = {}

	local allCfgBossChapter = EquipChapterModule.GetAllEquipChapterByCfg()

	for k, v in pairs(allCfgBossChapter) do
		local chapterData

		if DupPOD ~= nil and DupPOD[v.Id] ~= nil then
			EquipChapterModule.RefreshFinishDup(DupPOD[v.Id].passStatus)

			chapterData = equipChapterData.New(DupPOD[v.Id], EquipChapterModule.GetResourcePassByChapterID(v.Id))
		else
			EquipChapterModule.RefreshFinishDup({
				cid = 0
			})

			chapterData = equipChapterData.New({
				extraReward = 0,
				cid = v.Id,
				passStatus = {}
			}, EquipChapterModule.GetResourcePassByChapterID(v.Id))
		end

		table.insert(EquipChapterModule.ChapterList, v.Id, chapterData)
	end
end

function EquipChapterModule.GetAllResourceChapters()
	local chapterList = {}

	for k, v in pairs(EquipChapterModule.ChapterList) do
		table.insert(chapterList, v)
	end

	table.sort(chapterList, function(a, b)
		return a.Index < b.Index
	end)

	return chapterList
end

function EquipChapterModule.GetAllEquipChapterByCfg()
	local chapterList = {}

	for k, v in pairsCfg(CfgEquipDupChapterTable) do
		table.insert(chapterList, v)
	end

	table.sort(chapterList, function(a, b)
		return a.Id < b.Id
	end)

	return chapterList
end

function EquipChapterModule.GetResourcePassByChapterID(chapterID)
	local passTable = {}

	for k, v in pairsCfg(CfgEquipDupStageTable) do
		if v.ChapterId == chapterID then
			table.insert(passTable, v)
		end
	end

	table.sort(passTable, function(a, b)
		return a.Id < b.Id
	end)

	return passTable
end

function EquipChapterModule.RefreshFinishDup(passStatus)
	for k, v in pairs(passStatus) do
		if v == 1 then
			table.insert(EquipChapterModule.FinishDupList, k)
		end
	end
end

function EquipChapterModule.GetNewUnLockPass(chapterID)
	local passList = EquipChapterModule.ChapterList[chapterID]
	local index = 0

	for k, v in pairs(passList.passStatus) do
		if ConditionModule.Check(v:GetCfg().UnlockConditionId) then
			index = index + 1
		end
	end

	return index
end

function EquipChapterModule.FristCondition()
	return UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_EQUIP_DUP)
end

function EquipChapterModule.EnterDup(passId, fightCount, units, agentSkill)
	net_equipDup.enterDup(passId, fightCount, units, agentSkill)
end

function EquipChapterModule.SweepDup(passId, fightCount)
	net_equipDup.sweepDup(passId, fightCount)
end

function EquipChapterModule.SweepDupSucceed(code, shows)
	EventDispatcher.Dispatch(EventID.SweepDupResultEvent)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, shows)
end

function EquipChapterModule.NotifyDup(DupPOD)
	for k, v in pairs(DupPOD) do
		EquipChapterModule.ChapterList[v.cid]:RefreshData(v, EquipChapterModule.GetResourcePassByChapterID(v.cid))
		EquipChapterModule.RefreshFinishDup(v.passStatus)
	end
end
