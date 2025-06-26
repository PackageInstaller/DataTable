-- chunkname: @IQIGame\\Module\\Girl\\GirlModule.lua

GirlModule = {
	girlPODs = {},
	callBack = Queue.New(),
	_SoulCidOathMap = {},
	_SoulCidMarryCfgMap = {}
}

local GirlOnDutySaveData = require("IQIGame.Module.Girl.GirlOnDutySaveData")

function net_girl.getGirlsResult(code, girls)
	GirlModule.girlPODs = girls

	SceneManager.ChangeScene(SceneID.Girl)
end

function GirlModule.Reload()
	GirlBackGroundModule.Reload()
	RandomSecretaryModule.Reload()
end

function GirlModule.Shutdown()
	GirlModule.girlPODs = {}
	GirlModule.soulOathPOD = nil

	GirlModule.callBack:Clear()
	GirlBackGroundModule.Shutdown()
	RandomSecretaryModule.Shutdown()
end

function GirlModule.TimerUpdate(top)
	return
end

function GirlModule.GetSoulGirlData(soulId)
	for i, v in pairs(GirlModule.girlPODs) do
		if v.soulCid == soulId then
			return v
		end
	end

	return nil
end

function GirlModule.GetSoulWhisperListData(soulCid)
	local tab = {}
	local openTab = {}

	for i, v in pairsCfg(CfgSoulWhisperListTable) do
		if v.SoulId == soulCid then
			table.insert(tab, v)

			local isUnlock = GirlModule.CheckWhisperUnlock(v.Id)

			if isUnlock then
				table.insert(openTab, v)
			end
		end
	end

	return tab, openTab
end

function GirlModule.CheckWhisperUnlock(whisperCID)
	if PlayerModule.PlayerInfo.unlockSoulWhispers and table.indexOf(PlayerModule.PlayerInfo.unlockSoulWhispers, whisperCID) ~= -1 then
		return true
	end

	local cfgData = CfgSoulWhisperListTable[whisperCID]

	return cfgData.IsUnlock
end

function GirlModule.UpdateDatingEvent(soulCid, datingRecord)
	for i, v in pairs(GirlModule.girlPODs) do
		if v.soulCid == soulCid then
			v.datingRecord = datingRecord

			break
		end
	end

	EventDispatcher.Dispatch(EventID.DatingEnd)
end

function GirlModule.IsDatingReverse(soulID)
	local data = GirlModule.GetSoulGirlData(soulID)

	return data.datingEvent
end

function GirlModule.RebateGift(soulID)
	local data = GirlModule.GetSoulGirlData(soulID)

	return data.feedback
end

function GirlModule.CheckRedMemory(soulId)
	local data = MemoryModule.GetSoulMemoryChaptersBySoulID(soulId)

	if data == nil then
		return false
	else
		for i, v in pairs(data) do
			if v.isExperience == false then
				local unlockCount = #v.unlockPieceCids
				local cfgMemoryChapterInfo = CfgSoulMemoryChapterTable[v.cid]
				local fragmentCount = #cfgMemoryChapterInfo.PieceIdList

				if unlockCount == fragmentCount then
					return true
				end
			end

			if v.isGetReward == false and v.isExperience then
				return true
			end
		end
	end

	return false
end

function GirlModule.GetLoveUIStyle(soulID, beginLevel, endLevel)
	local beginStyle, endStyle

	for i, v in pairsCfg(CfgSoulFavorTable) do
		if v.SoulID == soulID then
			if v.FavorDegree == beginLevel then
				beginStyle = v.LoveUIStyle
			elseif v.FavorDegree == endLevel then
				endStyle = v.LoveUIStyle
			end
		end
	end

	return beginStyle, endStyle
end

function GirlModule.GetSoulOathData(soulCid)
	if soulCid == nil or soulCid <= 0 then
		logError(string.format("soulCid: %s 非法。", tostring(soulCid)))

		return
	end

	local resultData = GirlModule._SoulCidMarryCfgMap[soulCid]

	if resultData ~= nil then
		return resultData
	end

	for i, cfgSoulMarryData in pairsCfg(CfgSoulMarryTable) do
		GirlModule._SoulCidMarryCfgMap[cfgSoulMarryData.SoulId] = cfgSoulMarryData

		if cfgSoulMarryData.SoulId == soulCid then
			resultData = cfgSoulMarryData
		end
	end

	if resultData == nil then
		logError(string.format("找不到soulCid: %s 对应的誓约数据。", soulCid))

		return
	end

	return resultData
end

function GirlModule.UpdateSoulMemoryDressProgress(soulId, progress)
	local data = GirlModule.GetSoulGirlData(soulId)

	data.memoryDressProgress = progress
end

function GirlModule.UpdateSoulMemoryDressProgress(soulId, dressMetaId, progress)
	local data = GirlModule.GetSoulGirlData(soulId)

	data.memoryDressProgress[dressMetaId] = progress
end

function GirlModule.UpDataDatingEvent(datingEvent)
	local cfgDatingEvent = CfgDatingEventsTable[datingEvent.cid]

	for i, v in pairs(GirlModule.girlPODs) do
		if v.soulCid == cfgDatingEvent.SoulID then
			local isNew = true

			for j, k in pairs(v.datingEvents) do
				if k.cid == datingEvent.cid then
					isNew = false
					GirlModule.girlPODs[i].datingEvents[j] = datingEvent
				end
			end

			if isNew == true then
				table.insert(GirlModule.girlPODs[i].datingEvents, datingEvent)
			end
		end
	end
end

function GirlModule.UpDataDatingEventView(eventID, isNew)
	for i, v in pairs(GirlModule.girlPODs) do
		for j, k in pairs(v.datingEvents) do
			if k.cid == eventID then
				k.isNew = isNew
			end
		end
	end
end

function GirlModule.Connective(soulMarryId)
	net_girl.connective(soulMarryId)
end

function GirlModule.ConnectiveResult(soulMarryId, soulCid, shows)
	local girlPod = GirlModule.GetSoulGirlData(soulCid)

	girlPod.activation = true

	local soulData = SoulModule.GetSoulData(soulCid)

	soulData.oathActivation = true

	GirlModule._UpdateSoulOathData(GirlModule.soulOathPOD, true)
	GirlModule._UpdateSoulOathData(GirlModule._SoulCidOathMap[soulCid], true)
	EventDispatcher.Dispatch(EventID.SoulCompleteOathSuccess, soulCid)
end

function GirlModule._UpdateSoulOathData(soulOathPOD, isOath)
	if soulOathPOD ~= nil then
		if isOath then
			soulOathPOD.dateData[5] = PlayerModule.GetServerTime() * 1000
		end

		soulOathPOD.activation = isOath
	end
end

function GirlModule.RequestSoulOath(soulCid, callBack)
	if callBack ~= nil then
		GirlModule.callBack:Enqueue(callBack)
	end

	net_girl.getSoulOath(soulCid)
end

function GirlModule.GetSoulOathResult(soulCid, pod)
	GirlModule.soulOathPOD = pod
	GirlModule._SoulCidOathMap[soulCid] = pod

	if GirlModule.callBack.Size > 0 then
		local callback = GirlModule.callBack:Dequeue()

		callback(soulCid, pod)
	end
end
