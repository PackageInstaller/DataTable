-- chunkname: @IQIGame\\Module\\TownLibrary\\TownLibraryModule.lua

TownLibraryModule = {
	npcTab = {},
	monsterTab = {},
	newsTab = {},
	alienEventTab = {},
	townStoryTab = {},
	EquipTab = {},
	SoulTab = {}
}

local TaskUIData = require("IQIGame.Module.Task.TaskUIData")
local TownLibraryNPCData = require("IQIGame.Module.TownLibrary.TownLibraryNPCData")
local TownLibraryNewsData = require("IQIGame.Module.TownLibrary.TownLibraryNewsData")
local TownLibraryMonsterData = require("IQIGame.Module.TownLibrary.TownLibraryMonsterData")
local TownLibraryMonsterResData = require("IQIGame.Module.TownLibrary.TownLibraryMonsterResData")
local TownLibraryEventData = require("IQIGame.Module.TownLibrary.TownLibraryEventData")
local TownLibraryEventResData = require("IQIGame.Module.TownLibrary.TownLibraryEventResData")
local TownLibraryStoryData = require("IQIGame.Module.TownLibrary.TownLibraryStoryData")
local TownLibraryStoryResData = require("IQIGame.Module.TownLibrary.TownLibraryStoryResData")
local TownLibraryEquipData = require("IQIGame.Module.TownLibrary.TownLibraryEquipData")
local TownLibrarySoulData = require("IQIGame.Module.TownLibrary.TownLibrarySoulData")

function TownLibraryModule.ReloadLibraryData(library)
	TownLibraryModule.LibraryPOD = library

	local isLock, value

	TownLibraryModule.EquipTab = {}

	for i, v in pairsCfg(CfgItemTable) do
		if v.Type == 3 and v.IsShow == true then
			isLock, value = TownLibraryModule.IsLockAndValue(v.Id, library.equipStar)

			local star = value == false and 0 or value
			local equipData = TownLibraryEquipData.New(v.Id, isLock, star)

			table.insert(TownLibraryModule.EquipTab, equipData)
		end
	end

	TownLibraryModule.SoulTab = {}

	for i, v in pairsCfg(CfgSoulTable) do
		if v.SoulType == 1 then
			isLock, value = TownLibraryModule.IsLockSoul(v.Id, library.souls)

			local soulData = TownLibrarySoulData.New(v.Id, isLock, value)

			table.insert(TownLibraryModule.SoulTab, soulData)
		end
	end

	TownLibraryModule.npcTab = {}

	for i, v in pairsCfg(CfgTownNpcBookTable) do
		if v.IsShow then
			isLock, value = TownLibraryModule.IsLockAndValue(v.Id, library.npc)

			local npcData = TownLibraryNPCData.New(v.Id, isLock, value)

			table.insert(TownLibraryModule.npcTab, npcData)
		end
	end

	TownLibraryModule.newsTab = {}

	for i, v in pairsCfg(CfgTownNewsBookTable) do
		isLock, value = TownLibraryModule.IsLockAndValue(v.Id, library.newsBook)

		local isGetReward = table.indexOf(library.getNewsBook, v.Id) ~= -1
		local newData = TownLibraryNewsData.New(v.Id, isLock, value, isGetReward)

		table.insert(TownLibraryModule.newsTab, newData)
	end

	TownLibraryModule.monsterTab = {}

	for i, v in pairsCfg(CfgTownMonsterBookTable) do
		local isMonsterLock, unlockMonster = TownLibraryModule.IsMonsterLockAndValue(v.Id, library.monster)
		local monsterData = TownLibraryMonsterData.New(v.Id, isMonsterLock, unlockMonster)

		table.insert(TownLibraryModule.monsterTab, monsterData)
	end

	TownLibraryModule.alienEventTab = {}

	for i, v in pairsCfg(CfgTownAlienEventBookTable) do
		local isEventLock, unlockEvents, alienRewards = TownLibraryModule.IsEventLockAndValue(v.Id, library.alienEvent, library.alienRewards)
		local monsterData = TownLibraryEventData.New(v.Id, isEventLock, unlockEvents, alienRewards)

		table.insert(TownLibraryModule.alienEventTab, monsterData)
	end

	TownLibraryModule.townStoryTab = {}

	for i, v in pairsCfg(CfgTownStoryBookTable) do
		if v.IsShow then
			if v.Type == 1 then
				local storyResTab = TownLibraryModule.GetTownStoryRes(v.Id, library.townStory)
				local storyData = TownLibraryStoryData.New(Constant.LibraryStoryType.TownStory, v.Id, storyResTab)

				table.insert(TownLibraryModule.townStoryTab, storyData)
			elseif v.Type == 2 then
				local storyMazeResTab = TownLibraryModule.GetMazeStoryRes(v.Id)
				local storyData = TownLibraryStoryData.New(Constant.LibraryStoryType.MazeStory, v.Id, storyMazeResTab)

				table.insert(TownLibraryModule.townStoryTab, storyData)
			elseif v.Type == 3 then
				local storyResTab = TownLibraryModule.GetTownStoryRes(v.Id, library.townStory)
				local storyData = TownLibraryStoryData.New(Constant.LibraryStoryType.ActionStory, v.Id, storyResTab)

				table.insert(TownLibraryModule.townStoryTab, storyData)
			end
		end
	end

	for i, v in pairsCfg(CfgTownNpcBookTable) do
		if v.IsShow then
			local storyNpcResTab = TownLibraryModule.GetNpcStoryRes(v.Id, library)
			local storyData = TownLibraryStoryData.New(Constant.LibraryStoryType.NPCStory, v.Id, storyNpcResTab)

			table.insert(TownLibraryModule.townStoryTab, storyData)
		end
	end

	for i, v in pairsCfg(CfgSoulTable) do
		if v.SoulType == 1 then
			local storySoulResTab = TownLibraryModule.GetSoulStoryRes(v.Id, library)
			local storyData = TownLibraryStoryData.New(Constant.LibraryStoryType.SoulStory, v.Id, storySoulResTab)

			table.insert(TownLibraryModule.townStoryTab, storyData)
		end
	end
end

function TownLibraryModule.GetSoulDataBySoulCid(soulCid)
	if TownLibraryModule.SoulTab then
		for i, v in pairs(TownLibraryModule.SoulTab) do
			if v.cfgID == soulCid then
				return v
			end
		end
	end

	return nil
end

function TownLibraryModule.GetStoryDataByType(type)
	local tab = {}

	for i, v in pairs(TownLibraryModule.townStoryTab) do
		if v.storyType == type then
			table.insert(tab, v)
		end
	end

	table.sort(tab, function(a, b)
		return a.cfgID < b.cfgID
	end)

	return tab
end

function TownLibraryModule.GetUnLockNPCRes()
	local num = 0
	local totalNum = 0

	for i, v in pairs(TownLibraryModule.npcTab) do
		num = num + v:GetUnlockEntryNum()
		totalNum = totalNum + v:GetEntryAndMax()
	end

	return num, totalNum
end

function TownLibraryModule.GetUnLockNewsRes()
	local num = 0
	local totalNum = #TownLibraryModule.newsTab

	for i, v in pairs(TownLibraryModule.newsTab) do
		if v.isLock == true then
			num = num + 1
		end
	end

	return num, totalNum
end

function TownLibraryModule.GetUnLockMonsterRes()
	local num = 0
	local totalNum = 0

	for i, v in pairs(TownLibraryModule.monsterTab) do
		num = num + v:GetUnlockEntryNum()
		totalNum = totalNum + v:GetEntryAndMax()
	end

	return num, totalNum
end

function TownLibraryModule.GetUnLockEventRes()
	local num = 0
	local totalNum = 0

	for i, v in pairs(TownLibraryModule.alienEventTab) do
		num = num + v:GetUnlockEntryNum()
		totalNum = totalNum + v:GetEntryAndMax()
	end

	return num, totalNum
end

function TownLibraryModule.GetUnLockStoryRes()
	local num = 0
	local totalNum = 0

	for i, v in pairs(TownLibraryModule.townStoryTab) do
		num = num + v:GetUnlockEntryNum()
		totalNum = totalNum + v:GetEntryAndMax()
	end

	return num, totalNum
end

function TownLibraryModule.GetUnLockMazesRes()
	local monsterNum, monsterTotal = TownLibraryModule.GetUnLockMonsterRes()
	local eventNum, eventTotal = TownLibraryModule.GetUnLockEventRes()
	local num = monsterNum + eventNum
	local totalNum = monsterTotal + eventTotal

	return num, totalNum
end

function TownLibraryModule.GetUnLockSoulRes()
	local num = 0
	local totalNum = #TownLibraryModule.SoulTab

	for i, v in pairs(TownLibraryModule.SoulTab) do
		if v.isLock then
			num = num + 1
		end
	end

	return num, totalNum
end

function TownLibraryModule.GetUnLockEquipmentRes()
	local num = 0
	local totalNum = #TownLibraryModule.EquipTab

	for i, v in pairs(TownLibraryModule.EquipTab) do
		if v.isLock then
			num = num + 1
		end
	end

	return num, totalNum
end

function TownLibraryModule.IsLockSoul(id, tab)
	local isLock = false
	local value

	if tab ~= nil then
		for k, v in pairs(tab) do
			if v.soulCid == id then
				isLock = true
				value = v.unlockPlate

				break
			end
		end
	end

	if value == nil then
		value = {}
	end

	return isLock, value
end

function TownLibraryModule.IsLockAndValue(id, tab)
	local isLock = false
	local value = false

	if tab ~= nil then
		for k, v in pairs(tab) do
			if k == id then
				isLock = true
				value = v

				break
			end
		end
	end

	return isLock, value
end

function TownLibraryModule.IsEventLockAndValue(id, tab, rewards)
	local isLock = false
	local unlockEvent = {}

	for i, cfgRes in pairsCfg(CfgTownAlienEventBookResTable) do
		if cfgRes.TownAlienEventID == id then
			for k, v in pairs(tab) do
				if k == cfgRes.Id then
					isLock = true

					local eventResData = TownLibraryEventResData.New(cfgRes.Id, true)

					table.insert(unlockEvent, eventResData)
				end
			end
		end
	end

	local alienRewards = {}

	for i, v in pairs(rewards) do
		if i == id then
			alienRewards = v.status

			break
		end
	end

	return isLock, unlockEvent, alienRewards
end

function TownLibraryModule.IsMonsterLockAndValue(id, tab)
	local isLock = false
	local unlockMonster = {}

	for i, cfgRes in pairsCfg(CfgTownMonsterBookResTable) do
		if cfgRes.TownMonsterID == id then
			for k, v in pairs(tab) do
				if k == cfgRes.Id then
					isLock = true

					local monsterResData = TownLibraryMonsterResData.New(cfgRes.Id, true, v)

					table.insert(unlockMonster, monsterResData)
				end
			end
		end
	end

	return isLock, unlockMonster
end

function TownLibraryModule.GetTownStoryRes(id, tab)
	local storyRes = {}

	for i, cfgRes in pairsCfg(CfgTownStoryBookResTable) do
		if cfgRes.TownAlienEventID == id then
			local resIsLock = false

			for k, v in pairs(tab) do
				if k == cfgRes.Id then
					resIsLock = true

					break
				end
			end

			local isShow = true

			if cfgRes.ShowCondition > 0 then
				local result = ConditionModule.Check(cfgRes.ShowCondition)

				if not result then
					isShow = false
				end
			end

			if isShow then
				local storyResData = TownLibraryStoryResData.New(cfgRes.Type, cfgRes.Id, resIsLock)

				if storyRes[cfgRes.Type] == nil then
					storyRes[cfgRes.Type] = {}
				end

				table.insert(storyRes[cfgRes.Type], storyResData)
			end
		end
	end

	return storyRes
end

function TownLibraryModule.GetMazeStoryRes(id)
	local storyRes = {}

	for i, cfgRes in pairsCfg(CfgTownMazeStoryBookResTable) do
		if cfgRes.TownAlienEventID == id then
			local resIsLock = PlayerModule.IsMazeFinished(cfgRes.GateProgress)
			local storyResData = TownLibraryStoryResData.New(Constant.LibraryStoryResType.MazeResType, cfgRes.Id, resIsLock)

			if storyRes[Constant.LibraryStoryResType.MazeResType] == nil then
				storyRes[Constant.LibraryStoryResType.MazeResType] = {}
			end

			table.insert(storyRes[Constant.LibraryStoryResType.MazeResType], storyResData)
		end
	end

	return storyRes
end

function TownLibraryModule.GetSoulStoryRes(soulID, libraryPOD)
	local storyRes = {}

	for i, cfgRes in pairsCfg(CfgTownStoryBookResTable) do
		if cfgRes.BelongTo == soulID then
			local resIsLock = false

			if libraryPOD.townStory then
				for k, v in pairs(libraryPOD.townStory) do
					if k == cfgRes.Id then
						resIsLock = true

						break
					end
				end
			end

			local isShow = true

			if cfgRes.ShowCondition > 0 then
				local result = ConditionModule.Check(cfgRes.ShowCondition)

				if not result then
					isShow = false
				end
			end

			if isShow then
				local storyResData = TownLibraryStoryResData.New(Constant.LibraryStoryResType.SoulShopResType, cfgRes.Id, resIsLock)

				if storyRes[cfgRes.Type] == nil then
					storyRes[cfgRes.Type] = {}
				end

				table.insert(storyRes[cfgRes.Type], storyResData)
			end
		end
	end

	local LibrarySoulPOD

	for i, v in pairs(libraryPOD.souls) do
		if v.soulCid == soulID then
			LibrarySoulPOD = v

			break
		end
	end

	for i, cfgRes in pairsCfg(CfgSoulNewStoryTable) do
		if cfgRes.SoulId == soulID then
			local resIsLock = false

			if LibrarySoulPOD and LibrarySoulPOD.newStroys then
				for k, v in pairs(LibrarySoulPOD.newStroys) do
					if v == cfgRes.Id then
						resIsLock = true

						break
					end
				end
			end

			local storyResData = TownLibraryStoryResData.New(Constant.LibraryStoryResType.SoulNewStoryResType, cfgRes.Id, resIsLock)

			if storyRes[Constant.LibraryStoryResType.SoulNewStoryResType] == nil then
				storyRes[Constant.LibraryStoryResType.SoulNewStoryResType] = {}
			end

			table.insert(storyRes[Constant.LibraryStoryResType.SoulNewStoryResType], storyResData)
		end
	end

	for i, cfgRes in pairsCfg(CfgDatingEventsTable) do
		if cfgRes.SoulId == soulID then
			local resIsLock = false

			if LibrarySoulPOD and LibrarySoulPOD.datings then
				for k, v in pairs(LibrarySoulPOD.datings) do
					if v == cfgRes.Id then
						resIsLock = true

						break
					end
				end
			end

			local storyResData = TownLibraryStoryResData.New(Constant.LibraryStoryResType.SoulDatingResType, cfgRes.Id, resIsLock)

			if storyRes[Constant.LibraryStoryResType.SoulDatingResType] == nil then
				storyRes[Constant.LibraryStoryResType.SoulDatingResType] = {}
			end

			table.insert(storyRes[Constant.LibraryStoryResType.SoulDatingResType], storyResData)
		end
	end

	return storyRes
end

function TownLibraryModule.GetNpcStoryRes(npcID, libraryPOD)
	local storyRes = {}

	for i, cfgRes in pairsCfg(CfgTownStoryBookResTable) do
		if cfgRes.Type == Constant.LibraryStoryResType.NpcShopResType and cfgRes.BelongTo == npcID then
			local resIsLock = false

			if libraryPOD.townStory then
				for k, v in pairs(libraryPOD.townStory) do
					if k == cfgRes.Id then
						resIsLock = true

						break
					end
				end
			end

			local isShow = true

			if cfgRes.ShowCondition > 0 then
				local result = ConditionModule.Check(cfgRes.ShowCondition)

				if not result then
					isShow = false
				end
			end

			if isShow then
				local storyResData = TownLibraryStoryResData.New(Constant.LibraryStoryResType.NpcShopResType, cfgRes.Id, resIsLock)

				if storyRes[Constant.LibraryStoryResType.NpcShopResType] == nil then
					storyRes[Constant.LibraryStoryResType.NpcShopResType] = {}
				end

				table.insert(storyRes[Constant.LibraryStoryResType.NpcShopResType], storyResData)
			end
		end
	end

	for i, cfgRes in pairsCfg(CfgTownNpcBookResTable) do
		if cfgRes.EntryId == 9 and cfgRes.NpcID == npcID then
			local resIsLock = false

			if libraryPOD.npc then
				for k, libraryNpcPOD in pairs(libraryPOD.npc) do
					if libraryNpcPOD and libraryNpcPOD.entrys then
						for j, num in pairs(libraryNpcPOD.entrys) do
							if j == cfgRes.Id then
								resIsLock = true

								break
							end
						end
					end
				end
			end

			local storyResData = TownLibraryStoryResData.New(Constant.LibraryStoryResType.NpcResBranchType, cfgRes.Id, resIsLock)

			if storyRes[Constant.LibraryStoryResType.NpcResBranchType] == nil then
				storyRes[Constant.LibraryStoryResType.NpcResBranchType] = {}
			end

			table.insert(storyRes[Constant.LibraryStoryResType.NpcResBranchType], storyResData)
		end
	end

	return storyRes
end

function TownLibraryModule.GetRedPoint(type)
	if type == Constant.LibraryTaskType.TaskTypeNews then
		for i, v in pairs(TownLibraryModule.newsTab) do
			if v:IsGetReward() then
				return true
			end
		end
	else
		local tab = TownLibraryModule.GetLibraryTask(type)

		for i, v in pairs(tab) do
			if v.CurrentNum >= v.TargetNum and v.TaskStatus ~= TaskModule.TaskStatus.FINISH_TASK then
				return true
			end
		end
	end

	return false
end

function TownLibraryModule.GetLibraryTask(type)
	local ret = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.LIBRARY_TASK, {
		type
	})
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.LIBRARY_TASK, {
		type
	})

	for i = 1, #processing do
		local taskData = processing[i]
		local uiTaskData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

		table.insert(ret, uiTaskData)
	end

	for i = 1, #finished do
		local taskCid = finished[i]
		local cfgTaskData = CfgMainQuestTable[taskCid]

		if cfgTaskData.FinishIsShow == 1 then
			local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]
			local uiTaskData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

			table.insert(ret, uiTaskData)
		end
	end

	table.sort(ret, function(a, b)
		return a.cid < b.cid
	end)

	return ret
end

function TownLibraryModule.GetUnLockNews()
	local tab = {}

	for i, v in pairs(TownLibraryModule.newsTab) do
		if v.isLock then
			table.insert(tab, v)
		end
	end

	table.sort(tab, function(a, b)
		return a.cfgID < b.cfgID
	end)

	return tab
end

function TownLibraryModule.OpenLibrary(callBack)
	net_library.openLibrary()

	TownLibraryModule.callBack = callBack
end

function TownLibraryModule.ViewNewsBook(id)
	net_library.viewNewsBook(id)

	TownLibraryModule.LibraryPOD.newsBook[id] = true

	local newData

	for i, v in pairs(TownLibraryModule.newsTab) do
		if v.cfgID == id then
			v.isRead = true
			newData = v

			break
		end
	end

	EventDispatcher.Dispatch(EventID.UpdateLibraryNewsEvent, newData)
end

function TownLibraryModule.GetNewsBookRewards(id)
	net_library.getNewsBookRewards(id)
end

function TownLibraryModule.ViewNewsBookResult()
	return
end

function TownLibraryModule.OpenLibraryResult(library)
	TownLibraryModule.ReloadLibraryData(library)

	if TownLibraryModule.callBack then
		TownLibraryModule.callBack()
	end

	TownLibraryModule.callBack = nil
end

function TownLibraryModule.GetNewsBookRewardsResult(id, itemShows)
	if itemShows ~= nil then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShows)
	end

	local newData

	for i, v in pairs(TownLibraryModule.newsTab) do
		if v.cfgID == id then
			v.isGetReward = true
			newData = v

			break
		end
	end

	EventDispatcher.Dispatch(EventID.UpdateLibraryNewsEvent, newData)
end
