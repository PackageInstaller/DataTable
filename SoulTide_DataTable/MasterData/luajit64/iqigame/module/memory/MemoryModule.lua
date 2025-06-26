-- chunkname: @IQIGame\\Module\\Memory\\MemoryModule.lua

require("IQIGame.Module.Memory.MemoryChapterInfo")
require("IQIGame.Module.Memory.MemoryStoryInfo")
require("IQIGame.Module.Memory.MemoryEndServerData")

MemoryModule = {
	dictMemoryFashionProgress = {},
	arrMemoryChapterMetaList = {}
}

function MemoryModule.ReloadData(data)
	MemoryModule.soulMemoryChapters = data
end

function MemoryModule.GetMemoryChapterInfoByCid(cid)
	if MemoryModule.arrMemoryChapterInfoList then
		for i, v in pairs(MemoryModule.arrMemoryChapterInfoList) do
			if v.cid == cid then
				return v
			end
		end
	end

	return nil
end

function MemoryModule.GetSoulMemoryChaptersBySoulID(soulCid)
	local data = {}

	for i, v in pairs(MemoryModule.soulMemoryChapters) do
		local cfgChapter = CfgSoulMemoryChapterTable[v.cid]

		if cfgChapter.SoulId == soulCid then
			table.insert(data, v)
		end
	end

	return data
end

function MemoryModule.UpdateSoulMemoryChapter(soulId, soulMemoryChapter)
	local result = false

	if MemoryModule.soulMemoryChapters then
		for i, v in pairs(MemoryModule.soulMemoryChapters) do
			if v.cid == soulMemoryChapter.cid then
				result = true
				MemoryModule.soulMemoryChapters[i] = soulMemoryChapter
			end
		end
	else
		MemoryModule.soulMemoryChapters = {}
	end

	if result == false then
		table.insert(MemoryModule.soulMemoryChapters, soulMemoryChapter)
	end

	MemoryModule.UpdateArrMemoryChapterInfoList(soulMemoryChapter)

	if MemoryModule.currentSoulChapterInfo and MemoryModule.currentSoulChapterInfo.cid == soulMemoryChapter.cid then
		MemoryModule.currentSoulChapterInfo:Initialize(soulMemoryChapter)
	end
end

function MemoryModule.UpdateGetReward(soulMemoryChapter)
	if MemoryModule.soulMemoryChapters then
		for i, v in pairs(MemoryModule.soulMemoryChapters) do
			if v.cid == soulMemoryChapter.cid then
				MemoryModule.soulMemoryChapters[i] = soulMemoryChapter
			end
		end
	end

	if MemoryModule.currentSoulChapterInfo and MemoryModule.currentSoulChapterInfo.cid == soulMemoryChapter.cid then
		MemoryModule.currentSoulChapterInfo:Initialize(soulMemoryChapter)
	end
end

function MemoryModule.UpdateArrMemoryChapterInfoList(soulMemoryChapter)
	if MemoryModule.arrMemoryChapterInfoList then
		for i, v in pairs(MemoryModule.arrMemoryChapterInfoList) do
			if v.cid == soulMemoryChapter.cid then
				v:Initialize(soulMemoryChapter)
			end
		end
	end
end

function MemoryModule.OpenMemoryUI(soulCid)
	MemoryModule.currentSoulID = soulCid

	MemoryModule.RequestSoulMemoeryChapter(soulCid)

	local haveList = MemoryModule.arrMemoryChapterInfoList

	if haveList == nil or #haveList <= 0 or MemoryModule.currentSoulChapterInfo == nil then
		local metaFirstChapter = MemoryModule.GetSoulFistChapter(soulCid)
		local str = GirlUIApi:GetString("labMemoryLifeTxt", metaFirstChapter.UnlockFavorDegreeLevel)

		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, str)

		return
	end

	local soulData = SoulModule.GetSoulData(soulCid)

	UIModule.Open(Constant.UIControllerName.MemoryUI, Constant.UILayer.UI, soulData)
end

function MemoryModule.UpdateMemoryIsNew(soulId, cid, isNew)
	for i, v in pairs(MemoryModule.soulMemoryChapters) do
		if v.cid == cid then
			MemoryModule.soulMemoryChapters[i].isNew = isNew

			break
		end
	end
end

function MemoryModule.RequestSoulMemoeryChapter(soulCid)
	MemoryModule.ClearData()

	local soulMemoryChapters = MemoryModule.GetSoulMemoryChaptersBySoulID(soulCid)

	MemoryModule.arrMemoryChapterMetaList = {}

	for i, v in pairsCfg(CfgSoulMemoryChapterTable) do
		if soulCid == v.SoulId then
			table.insert(MemoryModule.arrMemoryChapterMetaList, v)
		end
	end

	table.sort(MemoryModule.arrMemoryChapterMetaList, MemoryModule.SortMemoryChapterMetaInfo)
	MemoryModule.GetSoulMemoryChapterResult(soulCid, soulMemoryChapters)
end

function MemoryModule.RequestActiveMemoryPiece(chapterCid, pieceID)
	net_soulMemory.activeMemoryPiece(chapterCid, pieceID)
end

function MemoryModule.RequestExperienceMemory(chapterCid)
	net_soulMemory.experienceMemory(chapterCid)
end

function MemoryModule.RequestGetRewards(chapterCid)
	net_soulMemory.getRewards(chapterCid)
end

function MemoryModule.RequestGetSoulMemoryDressProgress(memoryDressCid)
	return
end

function MemoryModule.RequestViewMemory(chapterId)
	net_soulMemory.viewMemory(chapterId)
end

function MemoryModule.RequestComposeMemoryDress(memoryDressCid)
	net_girl.composeMemoryDress(memoryDressCid)
end

function MemoryModule.GetSoulMemoryChapterResult(soulCid, soulMemoryChapters)
	if soulCid ~= MemoryModule.currentSoulID then
		logError("选择灵魂错误")

		return
	end

	MemoryModule.arrMemoryChapterInfoList = {}

	local memoryChapterInfo

	for i, v in pairs(soulMemoryChapters) do
		memoryChapterInfo = MemoryChapterInfo.New()

		memoryChapterInfo:Initialize(v)
		table.insert(MemoryModule.arrMemoryChapterInfoList, memoryChapterInfo)
	end

	table.sort(MemoryModule.arrMemoryChapterInfoList, MemoryModule.SortMemoryChapterInfo)

	if MemoryModule.currentSouldChapterIndex == nil then
		MemoryModule.SetLastChapter()
	elseif MemoryModule.currentSouldChapterIndex > #MemoryModule.arrMemoryChapterInfoList then
		MemoryModule.SetLastChapter()
	else
		MemoryModule.currentSoulChapterInfo = MemoryModule.arrMemoryChapterInfoList[MemoryModule.currentSouldChapterIndex]
	end

	EventDispatcher.Dispatch(EventID.MemoryChapterDataReadyEvent)
end

function MemoryModule.SetSoulMemoryChapterResult(soulCid, soulMemoryChapter)
	if MemoryModule.arrMemoryChapterInfoList == nil then
		MemoryModule.arrMemoryChapterInfoList = {}
	end

	local result = false
	local memoryChapterInfo = MemoryChapterInfo.New()

	memoryChapterInfo:Initialize(soulMemoryChapter)

	for i, v in pairs(MemoryModule.arrMemoryChapterInfoList) do
		if v.cid == soulMemoryChapter.cid then
			MemoryModule.arrMemoryChapterInfoList[i] = memoryChapterInfo
			result = true

			break
		end
	end

	if result == false then
		MemoryModule.arrMemoryChapterInfoList[#MemoryModule.arrMemoryChapterInfoList + 1] = memoryChapterInfo
	end
end

function MemoryModule.IsDressActive()
	local dressMeta = MemoryModule.GetCurrentCfgMemoryFashionData(MemoryModule.currentSoulID)
	local memoryDressCid = dressMeta.Id

	return MemoryModule.dictMemoryFashionProgress[memoryDressCid] == dressMeta.TotalProgress
end

function MemoryModule.IsGetReward()
	if MemoryModule.currentSoulChapterInfo.arrUnlockPiecesCidsList == nil then
		return false
	end

	local unlockCount = #MemoryModule.currentSoulChapterInfo.arrUnlockPiecesCidsList
	local cfgMemoryChapterInfo = CfgSoulMemoryChapterTable[MemoryModule.currentSoulChapterInfo.cid]
	local fragmentCount = #cfgMemoryChapterInfo.PieceIdList

	if unlockCount == fragmentCount then
		return not MemoryModule.currentSoulChapterInfo.isGetReward
	end

	return false
end

function MemoryModule.GetCurrentDressCId()
	local dressMeta = MemoryModule.GetCurrentCfgMemoryFashionData(MemoryModule.currentSoulID)

	return dressMeta.Id
end

function MemoryModule.GetMaxChapterId()
	local maxId = 0

	for i, v in pairsCfg(CfgSoulMemoryChapterTable) do
		if v.SoulId == MemoryModule.currentSoulID and maxId < v.Id then
			maxId = v.Id
		end
	end

	return maxId
end

function MemoryModule.ActiveMemoryFragmentResult(chapterCid, pieceCid, soulMemoryChapter)
	MemoryModule.UpdateSoulMemoryChapter(MemoryModule.currentSoulID, soulMemoryChapter)
	EventDispatcher.Dispatch(EventID.MemoryActiveMemoryFragmentSuccessEvent, pieceCid)
end

function MemoryModule.GetRewardsResultResult(chapterCid, showRewards, soulMemoryChapter, newSoulMemoryChapterPod)
	if newSoulMemoryChapterPod ~= nil then
		local memoryChapterInfo = MemoryChapterInfo.New()

		memoryChapterInfo:Initialize(newSoulMemoryChapterPod)
		MemoryModule.SetSoulMemoryChapterResult(MemoryModule.currentSoulID, memoryChapterInfo)
		MemoryModule.UpdateSoulMemoryChapter(MemoryModule.currentSoulID, newSoulMemoryChapterPod)
	end

	MemoryModule.UpdateGetReward(soulMemoryChapter)

	local cfgSoulMemoryDressData = MemoryModule.GetCurrentCfgMemoryFashionData(MemoryModule.currentSoulID)

	MemoryModule.RequestGetSoulMemoryDressProgress(cfgSoulMemoryDressData.Id)

	local itemList = {}

	for i, v in pairs(showRewards) do
		itemList[i] = {
			id = v.cid,
			num = v.num
		}

		EventDispatcher.Dispatch(EventID.MemoryGetRewardEvent)
	end

	MemoryModule.UpdateSoulMemoryChapter(MemoryModule.currentSoulID, soulMemoryChapter)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, showRewards)
	EventDispatcher.Dispatch(EventID.MemoryChapterDataReadyEvent)
end

function MemoryModule.ExperienceMemoryResult(chapterCid)
	local memoryInfo = MemoryModule.GetMemoryChapterInfoByCid(chapterCid)

	memoryInfo.isExperience = true

	local soulCid = memoryInfo.cfgChapter.SoulId

	if MemoryModule.soulMemoryChapters then
		for i, v in pairs(MemoryModule.soulMemoryChapters) do
			local cfgChapter = CfgSoulMemoryChapterTable[v.cid]

			if cfgChapter.SoulId == soulCid then
				v.isExperience = true
			end
		end
	end

	EventDispatcher.Dispatch(EventID.MemoryExperienceSuccessEvent)
end

function MemoryModule.GetSoulMemoryDressProgressResult(memoryDressCid, progress)
	MemoryModule.dictMemoryFashionProgress[memoryDressCid] = progress

	EventDispatcher.Dispatch(EventID.MemoryFashionDataRefreshEvent, memoryDressCid)
end

function MemoryModule.GetSoulMemoryDressProgressResult(progress)
	local dressMeta = MemoryModule.GetCurrentCfgMemoryFashionData(MemoryModule.currentSoulID)
	local memoryDressCid = dressMeta.Id

	MemoryModule.dictMemoryFashionProgress[memoryDressCid] = progress

	GirlModule.UpdateSoulMemoryDressProgress(MemoryModule.currentSoulID, memoryDressCid, progress)
	EventDispatcher.Dispatch(EventID.MemoryFashionDataRefreshEvent, memoryDressCid)
end

function MemoryModule.ComposeMemoryDressResult(memoryDressCid)
	MemoryModule.dictMemoryFashionProgress[memoryDressCid] = -1

	EventDispatcher.Dispatch(EventID.MemoryComposeDressSuccessEvent, memoryDressCid)
end

function MemoryModule.IsToPrevChapter()
	if MemoryModule.currentSouldChapterIndex > 1 then
		local index = MemoryModule.currentSouldChapterIndex - 1
		local l = MemoryModule.arrMemoryChapterInfoList[index]
		local data = SoulModule.GetSoulData(MemoryModule.currentSoulID)

		if l.cfgChapter.UnlockFavorDegreeLevel <= data.favorLv then
			return true, l, index
		end

		return false, l, index
	end

	return false
end

function MemoryModule.IsToNextChapter()
	if MemoryModule.currentSouldChapterIndex < #MemoryModule.arrMemoryChapterMetaList then
		local index = MemoryModule.currentSouldChapterIndex + 1
		local l = MemoryModule.arrMemoryChapterMetaList[index]
		local data = SoulModule.GetSoulData(MemoryModule.currentSoulID)

		if l.UnlockFavorDegreeLevel <= data.favorLv then
			return true, MemoryModule.arrMemoryChapterInfoList[index], index
		end

		return false, l, index
	end

	return false
end

function MemoryModule.SetToPrevChapter()
	local result, l, index = MemoryModule.IsToPrevChapter()

	if result then
		MemoryModule.currentSoulChapterInfo = l
		MemoryModule.currentSouldChapterIndex = index

		EventDispatcher.Dispatch(EventID.MemoryCurrentChapterChangedEvent)
	end
end

function MemoryModule.SetToNextChapter()
	local result, l, index = MemoryModule.IsToNextChapter()

	if result and l ~= nil then
		MemoryModule.currentSoulChapterInfo = l
		MemoryModule.currentSouldChapterIndex = index

		EventDispatcher.Dispatch(EventID.MemoryCurrentChapterChangedEvent)
	end
end

function MemoryModule.SetLastChapter()
	MemoryModule.currentSouldChapterIndex = nil
	MemoryModule.currentSoulChapterInfo = nil

	local data = SoulModule.GetSoulData(MemoryModule.currentSoulID)

	for i, v in ipairs(MemoryModule.arrMemoryChapterInfoList) do
		if v.cfgChapter.UnlockFavorDegreeLevel > data.favorLv then
			break
		end

		MemoryModule.currentSouldChapterIndex = i
		MemoryModule.currentSoulChapterInfo = v
	end
end

function MemoryModule.SortMemoryChapterInfo(info1, info2)
	if info1.cid < info2.cid then
		return true
	else
		return false
	end
end

function MemoryModule.SortMemoryMetaChapterInfo(info1, info2)
	if info1.Id < info2.Id then
		return true
	else
		return false
	end
end

function MemoryModule.SortMemoryChapterMetaInfo(info1, info2)
	if info1.Id < info2.Id then
		return true
	else
		return false
	end
end

function MemoryModule.IsCurrentChapterActived()
	if MemoryModule.currentSoulChapterInfo ~= nil then
		local cfgMemoryChapterInfo = CfgSoulMemoryChapterTable[MemoryModule.currentSoulChapterInfo.cid]

		if cfgMemoryChapterInfo ~= nil then
			for i = 1, #cfgMemoryChapterInfo.PieceIdList do
				local tmpFragmentCid = cfgMemoryChapterInfo.PieceIdList[i]
				local isFragmentUnlock = MemoryModule.IsMemoryFragmentUnlock(tmpFragmentCid)

				if not isFragmentUnlock then
					return false
				end
			end
		else
			return false
		end
	else
		return false
	end

	return true
end

function MemoryModule.GetSoulChapterListByFavorLv(soulId, soulLv)
	local list = {}

	for i, v in pairsCfg(CfgSoulMemoryChapterTable) do
		if v.SoulId == soulId and soulLv >= v.UnlockFavorDegreeLevel then
			table.insert(list, v)
		end
	end

	return list
end

function MemoryModule.GetSoulChpaterList(soulId)
	local list = {}

	for i, v in pairsCfg(CfgSoulMemoryChapterTable) do
		if v.SoulId == soulId then
			table.insert(list, v)
		end
	end

	return list
end

function MemoryModule.GetSoulFistChapter(soulId)
	local list = {}

	for i, v in pairsCfg(CfgSoulMemoryChapterTable) do
		if v.SoulId == soulId then
			table.insert(list, v)
		end
	end

	table.sort(list, MemoryModule.SortMemoryMetaChapterInfo)

	return list[1]
end

function MemoryModule.IsMemoryFragmentUnlock(fragmentCid)
	local memoryChapterInfo = MemoryModule.currentSoulChapterInfo

	if memoryChapterInfo.arrUnlockPiecesCidsList == nil then
		return false
	end

	for k, cid in pairs(memoryChapterInfo.arrUnlockPiecesCidsList) do
		if fragmentCid == cid then
			return true
		end
	end

	return false
end

function MemoryModule.GetCurrentCfgMemoryFashionData(soulID)
	for k, cfgSoulMemoryDressData in pairsCfg(CfgSoulMemoryDressTable) do
		if cfgSoulMemoryDressData.SoulId == soulID then
			return cfgSoulMemoryDressData
		end
	end

	return nil
end

function MemoryModule.GetTotalMemoryAdd(soulId)
	local table = {}
	local chapters = MemoryModule.GetSoulChpaterList(soulId)

	for i, v in pairs(chapters) do
		local tab = MemoryModule.GetCurrentCfgMemoryAdd(v.Id)

		for k, v1 in pairs(tab) do
			if table[k] ~= nil then
				table[k] = table[k] + v1
			else
				table[k] = v1
			end
		end
	end

	return table
end

function MemoryModule.GetCurrentCfgMemoryAdd(chapterCid)
	local tab = {}

	if chapterCid then
		local cfgMemoryChapterInfo = CfgSoulMemoryChapterTable[chapterCid]

		for i = 1, #cfgMemoryChapterInfo.PieceIdList do
			local fragmentCid = cfgMemoryChapterInfo.PieceIdList[i]
			local isUnlock = MemoryModule.IsMemoryFragmentUnlock(fragmentCid)

			if isUnlock then
				local cfgPiece = CfgSoulMemoryPieceTable[fragmentCid]

				for j = 1, #cfgPiece.AttributeType do
					local id = cfgPiece.AttributeType[j]
					local value = cfgPiece.AttributeNum[j]

					if tab[id] ~= nil then
						tab[id] = tab[id] + value
					else
						tab[id] = value
					end
				end
			end
		end
	end

	return tab
end

function MemoryModule.GetUnlockMemoryMinLv(soulCid)
	local chapters = MemoryModule.GetSoulChpaterList(soulCid)

	table.sort(chapters, function(tb1, tb2)
		return tb1.UnlockFavorDegreeLevel < tb2.UnlockFavorDegreeLevel
	end)

	local firstData = chapters[1]

	return firstData.UnlockFavorDegreeLevel
end

function MemoryModule.ClearData()
	MemoryModule.currentSouldChapterIndex = nil
	MemoryModule.arrMemoryChapterInfoList = nil
end
