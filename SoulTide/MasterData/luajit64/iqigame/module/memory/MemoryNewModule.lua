-- chunkname: @IQIGame\\Module\\Memory\\MemoryNewModule.lua

MemoryNewModule = {
	isCurrentOpen = false,
	dictMemoryStoryInfo = {},
	arrMemoryStoryInfoList = {}
}

function MemoryNewModule.ReloadData(data)
	MemoryNewModule.soulNewStorys = data

	MainTipsModule.CheckTownNewStory()
end

function MemoryNewModule.UpdateSoulNewStory(soulNewStory)
	local result = false

	if MemoryNewModule.soulNewStorys then
		for i, v in pairs(MemoryNewModule.soulNewStorys) do
			if v.cid == soulNewStory.cid then
				MemoryNewModule.soulNewStorys[i] = soulNewStory
				result = true

				break
			end
		end
	else
		MemoryNewModule.soulNewStorys = {}
	end

	if result == false then
		table.insert(MemoryNewModule.soulNewStorys, soulNewStory)
	end

	local memoryStoryInfo = MemoryStoryInfo.New()

	memoryStoryInfo:Initialize(soulNewStory.cid)
	memoryStoryInfo:SetData(soulNewStory)
	TownModule.UpdateTownAreaSoulNewStory(memoryStoryInfo)
	MemoryNewModule.UpdateSoulNewStoryResult(soulNewStory)
	MainTipsModule.CheckTownNewStory()
	EventDispatcher.Dispatch(EventID.MemoryStoryDataReadyEvent)
end

function MemoryNewModule.GetStoryInfoByCid(cid)
	for i, v in pairs(MemoryNewModule.arrMemoryStoryInfoList) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function MemoryNewModule.GetCurrentSoulTotalStoryNum()
	return #MemoryNewModule.arrMemoryStoryInfoList
end

function MemoryNewModule.GetMaxNewStoryNum(soulCid)
	local maxNum = 0

	for k, cfgSoulNewStoryData in pairsCfg(CfgSoulNewStoryTable) do
		if cfgSoulNewStoryData.SoulId == soulCid then
			maxNum = maxNum + 1
		end
	end

	return maxNum
end

function MemoryNewModule.GetUnlockNewStoryMinLv(soulCid)
	local tab = {}

	for k, cfgSoulNewStoryData in pairsCfg(CfgSoulNewStoryTable) do
		if cfgSoulNewStoryData.SoulId == soulCid then
			table.insert(tab, cfgSoulNewStoryData)
		end
	end

	table.sort(tab, function(tb1, tb2)
		return tb1.UnlockFavorDegreeLevel < tb2.UnlockFavorDegreeLevel
	end)

	local firstData = tab[1]

	return firstData.UnlockFavorDegreeLevel
end

function MemoryNewModule.IsUnlockMemoryStoryInfo()
	for i, v in pairs(MemoryNewModule.dictMemoryStoryInfo) do
		if v.isUnlocked then
			return v.isUnlocked
		end
	end

	return false
end

function MemoryNewModule.GetFirstMemoryStoryInfo()
	for i, v in pairsCfg(CfgSoulNewStoryTable) do
		if v.SoulId == MemoryNewModule.currentSoulID and v.UnlockFavorDegreeLevel == 1 then
			return v
		end
	end

	return nil
end

function MemoryNewModule.GetUnlockMemoryStoryNum()
	local len = 0

	for i, v in pairs(MemoryNewModule.dictMemoryStoryInfo) do
		if v.isUnlocked and v:IsComplete() then
			len = len + 1
		end
	end

	return len
end

function MemoryNewModule.GetRewardMemoryStoryNum()
	local len = 0

	for i, v in pairs(MemoryNewModule.dictMemoryStoryInfo) do
		if v.isUnlocked and v:IsGetReward() then
			len = len + 1
		end
	end

	return len
end

function MemoryNewModule.GetChapterCost()
	for i, v in pairs(MemoryNewModule.dictMemoryStoryInfo) do
		return v.ChapterCost[0]
	end

	return 0
end

function MemoryNewModule.CheckRedNewMemory(soulId)
	if MemoryNewModule.soulNewStorys ~= nil then
		for i, v in pairs(MemoryNewModule.soulNewStorys) do
			local cfgSoulNewStoryData = CfgSoulNewStoryTable[v.cid]

			if cfgSoulNewStoryData.SoulId == soulId then
				local memoryStoryInfo = MemoryStoryInfo.New()

				memoryStoryInfo:Initialize(cfgSoulNewStoryData.Id)
				memoryStoryInfo:SetData(v)

				local state = memoryStoryInfo:StoryState()

				if state == 2 then
					return true
				end
			end
		end
	end

	return false
end

function MemoryNewModule.GetCanUnLockSoulNewStory(soulId)
	if MemoryNewModule.soulNewStorys ~= nil then
		for i, v in pairs(MemoryNewModule.soulNewStorys) do
			local cfgSoulNewStoryData = CfgSoulNewStoryTable[v.cid]

			if cfgSoulNewStoryData.SoulId == soulId then
				local memoryStoryInfo = MemoryStoryInfo.New()

				memoryStoryInfo:Initialize(cfgSoulNewStoryData.Id)
				memoryStoryInfo:SetData(v)

				local state = memoryStoryInfo:StoryState()

				if state == 2 then
					return memoryStoryInfo
				end
			end
		end
	end

	return nil
end

function MemoryNewModule.IsNewLockSoulStory()
	local soulDataList = SoulModule.GetSortedUnlockSoulDataList()

	for i, v in pairs(soulDataList) do
		local memoryStoryInfo = MemoryNewModule.GetCanUnLockSoulNewStory(v.soulCid)

		if memoryStoryInfo and memoryStoryInfo.cfgSoulNewStory.TownArea > 0 then
			return true
		end
	end

	return false
end

function MemoryNewModule.RequestGetSoulNewStory(soulCid)
	if MemoryNewModule.currentSoulID ~= soulCid then
		logError("选择灵魂错误")

		return
	end

	MemoryNewModule.dictMemoryStoryInfo = {}
	MemoryNewModule.arrMemoryStoryInfoList = {}

	local memoryStoryInfo

	for k, cfgSoulNewStoryData in pairsCfg(CfgSoulNewStoryTable) do
		if cfgSoulNewStoryData.SoulId == MemoryNewModule.currentSoulID then
			memoryStoryInfo = MemoryStoryInfo.New()

			memoryStoryInfo:Initialize(cfgSoulNewStoryData.Id)

			MemoryNewModule.dictMemoryStoryInfo[memoryStoryInfo.cid] = memoryStoryInfo

			table.insert(MemoryNewModule.arrMemoryStoryInfoList, memoryStoryInfo)
		end
	end

	for k, soulNewStoryPOD in pairs(MemoryNewModule.soulNewStorys) do
		memoryStoryInfo = MemoryNewModule.dictMemoryStoryInfo[soulNewStoryPOD.cid]

		if memoryStoryInfo then
			memoryStoryInfo:SetData(soulNewStoryPOD)
		end
	end

	EventDispatcher.Dispatch(EventID.MemoryStoryDataReadyEvent)
end

function MemoryNewModule.ExperienceNewStoryChapter(storyCid, chapterIndex)
	local cfg = CfgSoulNewStoryTable[storyCid]

	UIModule.Open(Constant.UIControllerName.GirlOpening, Constant.UILayer.UI, {
		1,
		function(tab)
			net_soulNewStory.experienceNewStoryChapter(tab[1], tab[2])
		end,
		{
			storyCid,
			chapterIndex
		},
		cfg.Name
	})
end

function MemoryNewModule.UpdateSoulNewStoryResult(soulNewStory)
	local memoryStoryInfo = MemoryNewModule.dictMemoryStoryInfo[soulNewStory.cid]

	if memoryStoryInfo == nil then
		memoryStoryInfo = MemoryStoryInfo.New()

		memoryStoryInfo:Initialize(soulNewStory.cid)
		memoryStoryInfo:SetData(soulNewStory)

		MemoryNewModule.dictMemoryStoryInfo[soulNewStory.cid] = memoryStoryInfo
	else
		memoryStoryInfo:SetData(soulNewStory)
	end
end

function MemoryNewModule.ExperienceNewStoryChapterResult(storyCid, chapterIndex)
	TownModule.RemoveTownAreaStory(storyCid)
end

function MemoryNewModule.NotifyCompleteNewStoryChapter(soulNewStory, showRewards, beginFavorLv, beginFavor, endFavorLv, endFavor)
	if MemoryNewModule.dictMemoryStoryInfo == nil then
		return
	end

	if MemoryNewModule.currentSoulID == nil then
		local cfgData = CfgSoulNewStoryTable[soulNewStory.cid]

		MemoryNewModule.currentSoulID = cfgData.SoulId
	end

	local memoryStoryInfo = MemoryNewModule.dictMemoryStoryInfo[soulNewStory.cid]

	if memoryStoryInfo == nil then
		memoryStoryInfo = MemoryStoryInfo.New()

		memoryStoryInfo:Initialize(soulNewStory.cid)
	end

	memoryStoryInfo:SetData(soulNewStory)

	local len

	len = soulNewStory.unlockChapters == nil and 0 or #soulNewStory.unlockChapters
	len = #soulNewStory.unlockChapters

	local len2 = #memoryStoryInfo.arrChapterList

	if len ~= len2 then
		logError("请求解锁章节，返回长度一样的unlockChapters " .. len)
	end

	memoryStoryInfo:SetData(soulNewStory)
	MemoryNewModule.UpdateSoulNewStory(soulNewStory)
	EventDispatcher.Dispatch(EventID.MemoryStoryChapterDataRefreshEvent)

	if beginFavor == endFavor and beginFavorLv == endFavorLv and (showRewards == nil or #showRewards == 0) then
		return
	end

	local soulData = SoulModule.GetSoulData(MemoryNewModule.currentSoulID)
	local cfgSoulFavor = soulData:GetCfgSoulFavor()

	if cfgSoulFavor and cfgSoulFavor.FullRankTip ~= "" and cfgSoulFavor.FullRankTip ~= nil then
		NoticeModule.ShowNoticeByType(1, cfgSoulFavor.FullRankTip)
	end

	local memoryEndData = MemoryEndServerData:New()

	memoryEndData:Init(soulNewStory, showRewards, beginFavor, endFavor, beginFavorLv, endFavorLv)
	UIModule.Open(Constant.UIControllerName.MemorySettlement, Constant.UILayer.UI, memoryEndData)
end

return MemoryNewModule
