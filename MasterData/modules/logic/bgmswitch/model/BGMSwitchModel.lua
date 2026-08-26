-- chunkname: @modules/logic/bgmswitch/model/BGMSwitchModel.lua

module("modules.logic.bgmswitch.model.BGMSwitchModel", package.seeall)

local BGMSwitchModel = class("BGMSwitchModel", BaseModel)

BGMSwitchModel.InvalidBgmId = -1
BGMSwitchModel.RandomBgmId = 0

function BGMSwitchModel:onInit()
	self:reInit()
end

function BGMSwitchModel:reInit()
	self._playMode = BGMSwitchEnum.PlayMode.LoopOne
	self._playingState = BGMSwitchEnum.PlayingState.FoldPlaying
	self._selectType = BGMSwitchEnum.SelectType.All
	self._bgmInfos = {}
	self._filterTypes = {}
	self._isFilteredAllListDirty = true
	self._filteredAllBgmListSorted = {}
	self._filteredAllBgmListRandom = {}
	self._isUnfilteredAllListDirty = true
	self._unfilteredAllBgmListSorted = {}
	self._isFilteredFavoriteListDirty = true
	self._filteredFavoriteBgmListSorted = {}
	self._filteredFavoriteBgmListRandom = {}
	self._isUnfilteredFavoriteListDirty = true
	self._unfilteredFavoriteBgmListSorted = {}
	self._curBgm = BGMSwitchModel.RandomBgmId
	self._useBgmIdFromServer = BGMSwitchModel.RandomBgmId
	self._curMechineGear = BGMSwitchEnum.Gear.On1
	self._curAudioShowType = BGMSwitchEnum.BGMDetailShowType.Progress
	self._recordBgmInfos = {}
	self._pptEffectEgg2Id = nil
	self._eggIsTrigger = false
	self._egg2State = {
		false,
		false,
		false,
		false
	}
end

function BGMSwitchModel:setBgmInfos(infos)
	self._bgmInfos = {}

	for _, v in ipairs(infos) do
		local mo = BGMSwitchInfoMo.New()

		mo:init(v)

		local bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(v.bgmId)

		if bgmCo then
			self._bgmInfos[v.bgmId] = mo
		end
	end

	self._isFilteredAllListDirty = true
	self._isUnfilteredAllListDirty = true
	self._isFilteredFavoriteListDirty = true
	self._isUnfilteredFavoriteListDirty = true
end

function BGMSwitchModel:updateBgmInfos(infos)
	if not self._bgmInfos then
		return
	end

	for _, v in ipairs(infos) do
		if self._bgmInfos[v.bgmId] then
			self._bgmInfos[v.bgmId]:reset(v)
		else
			local mo = BGMSwitchInfoMo.New()

			mo:init(v)

			self._bgmInfos[v.bgmId] = mo
		end
	end

	self._isFilteredAllListDirty = true
	self._isUnfilteredAllListDirty = true
	self._isFilteredFavoriteListDirty = true
	self._isUnfilteredFavoriteListDirty = true
end

function BGMSwitchModel:hasUnreadBgm()
	for _, info in pairs(self._bgmInfos) do
		if not info.isRead then
			return true
		end
	end

	return false
end

function BGMSwitchModel:getBgmInfo(bgmId)
	return self._bgmInfos[bgmId]
end

function BGMSwitchModel:updateFilteredAllBgmsList()
	if not self._isFilteredAllListDirty then
		return
	end

	self._isFilteredAllListDirty = false
	self._filteredAllBgmListSorted = {}
	self._filteredAllBgmListRandom = {}

	if self:isFilterMode() then
		for _, v in pairs(self._bgmInfos) do
			local bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(v.bgmId)

			if self._filterTypes[bgmCo.audioType] ~= nil and self._filterTypes[bgmCo.audioType] == true then
				table.insert(self._filteredAllBgmListSorted, v.bgmId)
				table.insert(self._filteredAllBgmListRandom, v.bgmId)
			end
		end
	else
		for _, v in pairs(self._bgmInfos) do
			table.insert(self._filteredAllBgmListSorted, v.bgmId)
			table.insert(self._filteredAllBgmListRandom, v.bgmId)
		end
	end

	table.sort(self._filteredAllBgmListSorted, BGMSwitchModel._sortBgm)
	self:regenerateRandomList(self._filteredAllBgmListRandom, true)
end

function BGMSwitchModel:updateUnfilteredAllBgmsList()
	if not self._isUnfilteredAllListDirty then
		return
	end

	self._isUnfilteredAllListDirty = false
	self._unfilteredAllBgmListSorted = {}

	for _, v in pairs(self._bgmInfos) do
		table.insert(self._unfilteredAllBgmListSorted, v.bgmId)
	end

	table.sort(self._unfilteredAllBgmListSorted, BGMSwitchModel._sortBgm)
end

function BGMSwitchModel:updateFilteredFavoriteBgmsList()
	if not self._isFilteredFavoriteListDirty then
		return
	end

	self._isFilteredFavoriteListDirty = false
	self._filteredFavoriteBgmListSorted = {}
	self._filteredFavoriteBgmListRandom = {}

	if self:isFilterMode() then
		for _, v in pairs(self._bgmInfos) do
			if v.favorite then
				local bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(v.bgmId)

				if self._filterTypes[bgmCo.audioType] ~= nil and self._filterTypes[bgmCo.audioType] == true then
					table.insert(self._filteredFavoriteBgmListSorted, v.bgmId)
					table.insert(self._filteredFavoriteBgmListRandom, v.bgmId)
				end
			end
		end
	else
		for _, v in pairs(self._bgmInfos) do
			if v.favorite then
				table.insert(self._filteredFavoriteBgmListSorted, v.bgmId)
				table.insert(self._filteredFavoriteBgmListRandom, v.bgmId)
			end
		end
	end

	table.sort(self._filteredFavoriteBgmListSorted, BGMSwitchModel._sortBgm)
	self:regenerateRandomList(self._filteredFavoriteBgmListRandom, true)
end

function BGMSwitchModel:regenerateRandomList(bgmList, replaceHead)
	local numBgms = #bgmList

	if numBgms <= 0 then
		return nil
	end

	local prevHeadBgmId = bgmList[1]
	local prevTailBgmId = bgmList[numBgms]

	for index1 = 1, numBgms do
		local index2 = math.random(numBgms)

		bgmList[index1] = bgmList[index2]
		bgmList[index2] = bgmList[index1]
	end

	if replaceHead and prevTailBgmId == bgmList[1] or not replaceHead and prevHeadBgmId == bgmList[numBgms] then
		bgmList[1] = bgmList[numBgms]
		bgmList[numBgms] = bgmList[1]
	end

	return bgmList[1]
end

function BGMSwitchModel:updateUnfilteredFavoriteBgmsList()
	if not self._isUnfilteredFavoriteListDirty then
		return
	end

	self._isUnfilteredFavoriteListDirty = false
	self._unfilteredFavoriteBgmListSorted = {}

	for _, v in pairs(self._bgmInfos) do
		if v.favorite then
			table.insert(self._unfilteredFavoriteBgmListSorted, v.bgmId)
		end
	end

	table.sort(self._unfilteredFavoriteBgmListSorted, BGMSwitchModel._sortBgm)
end

function BGMSwitchModel:getFilteredAllBgmsSorted()
	self:updateFilteredAllBgmsList()

	return self._filteredAllBgmListSorted
end

function BGMSwitchModel:getFilteredAllBgmsRandom()
	self:updateFilteredAllBgmsList()

	return self._filteredAllBgmListRandom
end

function BGMSwitchModel:getUnfilteredAllBgmsSorted()
	self:updateUnfilteredAllBgmsList()

	return self._unfilteredAllBgmListSorted
end

function BGMSwitchModel:getFilteredFavoriteBgmsSorted()
	self:updateFilteredFavoriteBgmsList()

	return self._filteredFavoriteBgmListSorted
end

function BGMSwitchModel:getFilteredFavoriteBgmsRandom()
	self:updateFilteredFavoriteBgmsList()

	return self._filteredFavoriteBgmListRandom
end

function BGMSwitchModel:getUnfilteredFavoriteBgmsSorted()
	self:updateUnfilteredFavoriteBgmsList()

	return self._unfilteredFavoriteBgmListSorted
end

function BGMSwitchModel:getCurrentUsingBgmList()
	if self:isRandomMode() then
		if self:getBGMSelectType() == BGMSwitchEnum.SelectType.All then
			return self:getFilteredAllBgmsRandom()
		else
			return self:getFilteredFavoriteBgmsRandom()
		end
	elseif self:getBGMSelectType() == BGMSwitchEnum.SelectType.All then
		return self:getFilteredAllBgmsSorted()
	else
		return self:getFilteredFavoriteBgmsSorted()
	end

	return {}
end

function BGMSwitchModel:getCurrentServerUsingBgmList()
	local serverListType = self:getServerRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)

	if self:isRandomMode() then
		if serverListType == BGMSwitchEnum.SelectType.All then
			return self:getFilteredAllBgmsRandom()
		else
			return self:getFilteredFavoriteBgmsRandom()
		end
	elseif serverListType == BGMSwitchEnum.SelectType.All then
		return self:getFilteredAllBgmsSorted()
	else
		return self:getFilteredFavoriteBgmsSorted()
	end

	return {}
end

function BGMSwitchModel:getReportBgmAudioLength(bgmCo)
	if bgmCo == nil then
		return 0
	end

	local audioLength = bgmCo.audioLength

	if bgmCo.isReport == 1 then
		local currReport = WeatherController.instance:getCurrReport()

		if currReport ~= nil then
			audioLength = currReport.audioLength
		end
	end

	return audioLength
end

function BGMSwitchModel:getPlayingState()
	return self._playingState
end

function BGMSwitchModel:setPlayingState(state)
	self._playingState = state
end

function BGMSwitchModel:setEggHideState(state)
	self._eggShowState = state
end

function BGMSwitchModel:getEggHideState()
	return self._eggShowState
end

function BGMSwitchModel:setBgmFavorite(bgmId, favorite)
	if self._bgmInfos[bgmId] then
		self._bgmInfos[bgmId].favorite = favorite or not self._bgmInfos[bgmId].favorite
		self._isFilteredFavoriteListDirty = true
		self._isUnfilteredFavoriteListDirty = true
	end
end

function BGMSwitchModel:isBgmFavorite(bgmId)
	return (self._bgmInfos[bgmId] or nil) and (self._bgmInfos[bgmId].favorite or false)
end

function BGMSwitchModel._sortBgm(bgm1, bgm2)
	local aCo = BGMSwitchConfig.instance:getBGMSwitchCO(bgm1)
	local bCo = BGMSwitchConfig.instance:getBGMSwitchCO(bgm2)

	return aCo.sort < bCo.sort
end

function BGMSwitchModel:setBGMSelectType(type)
	self._selectType = type

	self:recordInfoByType(BGMSwitchEnum.RecordInfoType.ListType, self._selectType, false)
end

function BGMSwitchModel:getBGMSelectType()
	self._selectType = self:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)

	return self._selectType
end

function BGMSwitchModel:setCurBgm(bgmId)
	if bgmId == BGMSwitchModel.RandomBgmId then
		if self._playMode ~= BGMSwitchEnum.PlayMode.Random then
			self._playMode = BGMSwitchEnum.PlayMode.Random
			self._curBgm = self:getNextBgm(1, false)
		end
	else
		self._playMode = BGMSwitchEnum.PlayMode.LoopOne
		self._curBgm = bgmId
	end
end

function BGMSwitchModel:getCurBgm()
	return self._curBgm
end

function BGMSwitchModel:nextBgm(dist, usingServerSavedListType)
	self._curBgm = self:getNextBgm(dist, usingServerSavedListType)

	local listType = self:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)
	local serverListType = self:getServerRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)

	if usingServerSavedListType and serverListType ~= nil then
		listType = serverListType
	end

	local isRandomMode = self:isRandomMode()

	if usingServerSavedListType then
		isRandomMode = self:isRandomBgmId(self:getUsedBgmIdFromServer())
	end

	if isRandomMode and listType == BGMSwitchEnum.SelectType.Loved and #self:getFilteredFavoriteBgmsRandom() == 0 then
		listType = BGMSwitchEnum.SelectType.All
	end

	if isRandomMode then
		local currIndex = -1
		local numRandomBgms = -1

		if listType == BGMSwitchEnum.SelectType.All then
			currIndex = LuaUtil.indexOfElement(self:getFilteredAllBgmsRandom(), self._curBgm)
			numRandomBgms = #self:getFilteredAllBgmsRandom()
		else
			currIndex = LuaUtil.indexOfElement(self:getFilteredFavoriteBgmsRandom(), self._curBgm)
			numRandomBgms = #self:getFilteredFavoriteBgmsRandom()
		end

		if currIndex == 1 and dist >= 1 then
			self._curBgm = listType == BGMSwitchEnum.SelectType.All and self:regenerateRandomList(self:getFilteredAllBgmsRandom(), true) or self:regenerateRandomList(self:getFilteredFavoriteBgmsRandom(), true)
		elseif currIndex == numRandomBgms and dist <= -1 then
			self._curBgm = listType == BGMSwitchEnum.SelectType.All and self:regenerateRandomList(self:getFilteredAllBgmsRandom(), false) or self:regenerateRandomList(self:getFilteredFavoriteBgmsRandom(), false)
		end
	end

	return self._curBgm
end

function BGMSwitchModel:setUsedBgmIdFromServer(bgmId)
	self._useBgmIdFromServer = bgmId
end

function BGMSwitchModel:getUsedBgmIdFromServer()
	return self._useBgmIdFromServer
end

function BGMSwitchModel:getBgmIdByDistance(tab, element, dist)
	local num = #tab

	if num == 0 then
		return BGMSwitchModel.InvalidBgmId
	end

	local currIndex = LuaUtil.indexOfElement(tab, element)

	if currIndex == -1 then
		return tab[1]
	end

	currIndex = (currIndex + dist) % num

	if currIndex == 0 then
		currIndex = num
	elseif currIndex < 0 then
		currIndex = currIndex + num
	end

	return tab[currIndex]
end

function BGMSwitchModel:getNextBgm(dist, usingServerSavedListType)
	local bgmId = self._curBgm
	local listType = self:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)
	local serverListType = self:getServerRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)

	if usingServerSavedListType and serverListType ~= nil then
		listType = serverListType
	end

	local isRandomMode = self:isRandomMode()

	if usingServerSavedListType then
		isRandomMode = self:isRandomBgmId(self:getUsedBgmIdFromServer())
	end

	if isRandomMode and listType == BGMSwitchEnum.SelectType.Loved and #self:getFilteredFavoriteBgmsRandom() == 0 then
		listType = BGMSwitchEnum.SelectType.All
	end

	return listType == BGMSwitchEnum.SelectType.All and (isRandomMode and self:getBgmIdByDistance(self:getFilteredAllBgmsRandom(), bgmId, dist) or self:getBgmIdByDistance(self:getFilteredAllBgmsSorted(), bgmId, dist)) or isRandomMode and self:getBgmIdByDistance(self:getFilteredFavoriteBgmsRandom(), bgmId, dist) or self:getBgmIdByDistance(self:getFilteredFavoriteBgmsSorted(), bgmId, dist)
end

function BGMSwitchModel:isRandomMode()
	return self._playMode == BGMSwitchEnum.PlayMode.Random
end

function BGMSwitchModel:isLoopOneMode()
	return self._playMode == BGMSwitchEnum.PlayMode.LoopOne
end

function BGMSwitchModel:isLocalRemoteListTypeMatched()
	local localSelectType = self:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)
	local remoteSelectType = self:getServerRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)

	return localSelectType == remoteSelectType
end

function BGMSwitchModel:isLocalRemoteBgmIdMatched()
	local localUsedBgmId = self:getCurBgm()
	local remoteUsedBgmId = self:getUsedBgmIdFromServer()

	return ((self:isRandomMode() or nil) and BGMSwitchModel.RandomBgmId) == remoteUsedBgmId
end

function BGMSwitchModel:isValidBgmId(bgmId)
	return bgmId ~= nil and bgmId ~= BGMSwitchModel.RandomBgmId and bgmId ~= BGMSwitchModel.InvalidBgmId
end

function BGMSwitchModel:isRandomBgmId(bgmId)
	return bgmId == BGMSwitchModel.RandomBgmId
end

function BGMSwitchModel:getBGMPlayMode()
	return self._playMode
end

function BGMSwitchModel:setMechineGear(gear)
	self._curMechineGear = gear

	self:recordInfoByType(BGMSwitchEnum.RecordInfoType.BGMSwitchGear, self._curMechineGear, true)
end

function BGMSwitchModel:getMechineGear()
	self._curMechineGear = self:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.BGMSwitchGear)

	return self._curMechineGear
end

function BGMSwitchModel:machineGearIsNeedPlayBgm()
	return self._curMechineGear == BGMSwitchEnum.Gear.On1
end

function BGMSwitchModel:machineGearIsInSnowflakeScene()
	return self._curMechineGear == BGMSwitchEnum.Gear.On2 or self._curMechineGear == BGMSwitchEnum.Gear.On3
end

function BGMSwitchModel:setAudioCurShowType(type)
	self._curAudioShowType = type
end

function BGMSwitchModel:getAudioCurShowType()
	return self._curAudioShowType
end

function BGMSwitchModel:setEggIsTrigger(state)
	self._eggIsTrigger = state
end

function BGMSwitchModel:getEggIsTrigger()
	return self._eggIsTrigger
end

function BGMSwitchModel:setPPtEffectEgg2Id(id)
	self._pptEffectEgg2Id = id
end

function BGMSwitchModel:getPPtEffectEgg2Id()
	return self._pptEffectEgg2Id
end

function BGMSwitchModel:setFilterType(type, select)
	self._filterTypes[type] = select
	self._isFilteredAllListDirty = true
	self._isFilteredFavoriteListDirty = true
end

function BGMSwitchModel:getFilterTypeSelectState(type)
	return self._filterTypes[type]
end

function BGMSwitchModel:clearFilterTypes()
	self._filterTypes = {}
	self._isFilteredAllListDirty = true
	self._isFilteredFavoriteListDirty = true
end

function BGMSwitchModel:isFilterMode()
	for _, value in pairs(self._filterTypes) do
		if value ~= nil and value == true then
			return true
		end
	end

	return false
end

function BGMSwitchModel:getEggType2Sates()
	return self._egg2State
end

function BGMSwitchModel:getEggType2SateByIndex(index)
	return self._egg2State[index]
end

function BGMSwitchModel:setEggType2State(index, state)
	self._egg2State[index] = state
end

function BGMSwitchModel:recordInfoByType(recordType, info, isSave)
	self._recordBgmInfos[recordType] = info

	if isSave then
		self:_recordInfo(recordType, info)
	end
end

function BGMSwitchModel:_recordInfo(recordType, info)
	local recordInfo = {}

	for key, value in pairs(self._recordBgmInfos) do
		local serverValue = self:getServerRecordInfoByType(key)

		recordInfo[key] = serverValue and serverValue or value
	end

	recordInfo[recordType] = info

	local str = self:encodeRecordInfo(recordInfo)

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.BGMViewInfo, str)
end

function BGMSwitchModel:encodeRecordInfo(recordInfos)
	local str = ""

	for key, value in pairs(recordInfos) do
		str = str .. key .. ":" .. value .. "|"
	end

	return str
end

function BGMSwitchModel:decodeRecordInfo(str)
	local recordInfo = {}
	local decodeData = string.split(str, "|")

	for i = 1, #decodeData do
		if decodeData[i] then
			local data = string.split(decodeData[i], ":")

			if data and #data > 1 then
				recordInfo[tonumber(data[1])] = tonumber(data[2])
			end
		end
	end

	return recordInfo
end

function BGMSwitchModel:getRecordInfoByType(recordType)
	if self._recordBgmInfos and #self._recordBgmInfos <= 0 and not self._recordBgmInfos[recordType] then
		local recordInfo = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.BGMViewInfo)

		if recordInfo then
			self._recordBgmInfos = self:decodeRecordInfo(recordInfo)
		end
	end

	if not self._recordBgmInfos[recordType] then
		if recordType == BGMSwitchEnum.RecordInfoType.ListType then
			return BGMSwitchEnum.SelectType.All
		end

		if recordType == BGMSwitchEnum.RecordInfoType.BGMSwitchGear then
			return BGMSwitchEnum.Gear.On1
		end
	end

	return self._recordBgmInfos[recordType]
end

function BGMSwitchModel:getServerRecordInfoByType(recordType)
	local recordInfo = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.BGMViewInfo)

	if recordInfo then
		local recordBgmInfos = self:decodeRecordInfo(recordInfo)

		if recordBgmInfos[recordType] then
			return recordBgmInfos[recordType]
		end
	end

	if recordType == BGMSwitchEnum.RecordInfoType.ListType then
		return BGMSwitchEnum.SelectType.All
	end

	if recordType == BGMSwitchEnum.RecordInfoType.BGMSwitchGear then
		return BGMSwitchEnum.Gear.On1
	end
end

function BGMSwitchModel:markRead(bgmId)
	local bgmInfoMO = self._bgmInfos[bgmId]

	if bgmInfoMO then
		bgmInfoMO.isRead = true
	end
end

function BGMSwitchModel:getUnReadCount()
	local count = 0

	for _, bgmInfoMO in pairs(self._bgmInfos) do
		if not bgmInfoMO.isRead then
			count = count + 1
		end
	end

	return count
end

BGMSwitchModel.instance = BGMSwitchModel.New()

return BGMSwitchModel
