-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/scene/flow/component/RetrieveAudioMgr.lua

module("logic.extensions.retrieve.scene.flow.component.RetrieveAudioMgr", package.seeall)

local M = class("RetrieveAudioMgr", ISceneFlowComp)
local kPlayListKey = "RetrievePlayListKey"
local kToPlayListKey = "RetrievePlayListKey"
local debugFlag = true

function M:onEnter()
	self:_setEvent(true)

	self._canPlay = false
	self._minTime = 1
	self._maxTime = 10
	self._orginAudioList = {}
	self._curPoolAudios = {}
	self._playList = {}
	self._toPlayList = {}
	self._hasLocalData = false
	self._isEndPlayVoice = false
end

function M:_loadLocalSetting()
	local localPlayList = PlayerLocalStorageModel.instance:getRetrievePlayList()
	local localToPlayList = PlayerLocalStorageModel.instance:getRetrieveToPlayList()

	self:_parseLocal2Table(localPlayList, localToPlayList)
end

function M:_parseLocal2Table(localPlayList, localToPlayList)
	self._playList = {}
	self._toPlayList = {}

	if localPlayList then
		local playArray = string.split(localPlayList, "#")

		if playArray and #playArray > 0 then
			for i = 1, #playArray do
				table.insert(self._playList, tonumber(playArray[i]))
			end
		end
	end

	if localToPlayList then
		local toPlayArray = string.split(localToPlayList, "#")

		if toPlayArray and #toPlayArray > 0 then
			for i = 1, #toPlayArray do
				table.insert(self._toPlayList, tonumber(toPlayArray[i]))
			end
		end
	end

	if #self._playList == 0 and #self._toPlayList == 0 then
		self._hasLocalData = false
	else
		self._hasLocalData = true
	end
end

function M:_saveTableToStr()
	if self._playList then
		local playListStr = ""

		for i = 1, #self._playList do
			playListStr = playListStr .. self._playList[i]

			if i ~= #self._playList then
				playListStr = playListStr .. "#"
			end
		end

		PlayerLocalStorageModel.instance:setRetrievePlayList(playListStr)
	end

	if self._toPlayList then
		local toPlayListStr = ""

		for i = 1, #self._toPlayList do
			toPlayListStr = toPlayListStr .. self._toPlayList[i]

			if i ~= #self._toPlayList then
				toPlayListStr = toPlayListStr .. "#"
			end
		end

		PlayerLocalStorageModel.instance:setRetrieveToPlayList(toPlayListStr)
	end
end

function M:onEnterDone()
	M.super.onEnterDone(self)
end

function M:onExit()
	self:_setEvent(false)
	removetimer(self._onRandomNextVoice, self)
end

function M:_setEvent(add)
	if add then
		RetrieveDispatcher:addEventListener(RetrieveEventType.Select_Pool, self._onSelectCardPool, self)
		RetrieveDispatcher:addEventListener(RetrieveEventType.Retrieve_Show_Phone, self._onShowPhone, self)
		RetrieveDispatcher:addEventListener(RetrieveEventType.Retrieve_Show_Phone_End, self._onEndShowPhone, self)
	else
		RetrieveDispatcher:removeEventListener(RetrieveEventType.Retrieve_Show_Phone, self._onShowPhone, self)
		RetrieveDispatcher:removeEventListener(RetrieveEventType.Retrieve_Show_Phone_End, self._onEndShowPhone, self)
		RetrieveDispatcher:removeEventListener(RetrieveEventType.Select_Pool, self._onSelectCardPool, self)
	end
end

function M:_onSelectCardPool(evt, lotteryData)
	if not lotteryData then
		printWarn("update audio failed ,reson: lottery data is nil")

		return
	end

	local curPoolId = lotteryData:getPoolId()

	self:_loadLocalSetting()

	local cfgList = RetrieveConfig.instance:getConfigList(ConfigName.LotteryAudio)

	self._curPoolAudios = {}
	self._orginAudioList = {}

	for _, cfg in pairs(cfgList) do
		if cfg.isOnline == 1 and (cfg.poolId == 0 or cfg.poolId == curPoolId) then
			self._curPoolAudios[cfg.code] = cfg
			self._orginAudioList[cfg.code] = cfg
		end
	end

	if self._playList then
		for i = 1, #self._playList do
			local playKey = self._playList[i]
			local audioCO = RetrieveConfig.instance:getConfigByKey(ConfigName.LotteryAudio, playKey)

			if audioCO and audioCO.isOnline == 1 and (audioCO.poolId == curPoolId or audioCO.poolId == 0) and self._curPoolAudios[playKey] then
				self._curPoolAudios[playKey] = nil
			end
		end
	end

	local tempToPlayList = {}

	if self._toPlayList then
		for i = 1, #self._toPlayList do
			local playKey = self._toPlayList[i]
			local audioCO = RetrieveConfig.instance:getConfigByKey(ConfigName.LotteryAudio, playKey)

			if audioCO and audioCO.isOnline == 1 and (audioCO.poolId == curPoolId or audioCO.poolId == 0) then
				table.insert(tempToPlayList, playKey)
			end
		end
	end

	self._toPlayList = tempToPlayList

	for _, cfg in pairs(self._curPoolAudios) do
		if cfg.package == RetrieveEnum.AudioPackage.Normal then
			local hasFind = false

			for i = 1, #self._toPlayList do
				if cfg.code == self._toPlayList[i] then
					hasFind = true
				end
			end

			if not hasFind then
				table.insert(self._toPlayList, cfg.code)
			end
		end
	end

	self:_checkIsEmpty()

	self._hasLocalData = true
end

function M:_onShowPhone()
	self._isEndPlayVoice = false
	self._canPlay = true

	self:_playVoice()

	local timeArray = ConstConfig.instance:getNumValuesByKey(ConstConfigKeyEnum.RetrieveRandomVoiceTime)

	if #timeArray >= 2 then
		self._minTime = timeArray[1]
		self._maxTime = timeArray[2]
	end
end

function M:_tryNextVoiceTimer()
	if self._isEndPlayVoice then
		return
	end

	local randomTime = math.random(self._minTime, self._maxTime)

	removetimer(self._onRandomNextVoice, self)
	settimer(randomTime, self._onRandomNextVoice, self, false)
end

function M:_onRandomNextVoice()
	self._canPlay = true

	self:_playVoice()
end

function M:_getRandomAudio()
	local totalWeight = 0
	local rangeTable = {}

	for code, cfg in pairs(self._curPoolAudios) do
		totalWeight = totalWeight + cfg.weight
		rangeTable[code] = totalWeight

		table.insert(rangeTable, {
			code = code,
			range = totalWeight
		})
	end

	local randomWeight = math.random(totalWeight)

	for index, info in ipairs(rangeTable) do
		if randomWeight <= info.range then
			return self._curPoolAudios[info.code]
		end
	end
end

function M:_playVoice()
	if self._canPlay then
		self._canPlay = false
	end

	local tempAudioCO = self:_getRandomAudio()

	if tempAudioCO then
		local isNormal = tempAudioCO.package == RetrieveEnum.AudioPackage.Normal

		if isNormal then
			local hasFind = false

			for i = 1, #self._playList do
				if tempAudioCO.code == self._playList[i] then
					hasFind = true
				end
			end

			if not hasFind then
				table.insert(self._playList, tempAudioCO.code)
			end

			table.removebyvalue(self._toPlayList, tempAudioCO.code)

			self._curPoolAudios[tempAudioCO.code] = nil

			self:_resetPlayerList()
			self:_saveTableToStr()
		end

		CriwareAudioFacade.instance:playVoiceByName(tempAudioCO.voiceName, nil, self._onPlayVoiceFinish, self)
	end
end

function M:_resetPlayerList()
	if #self._toPlayList <= 0 then
		self._toPlayList = {}
		self._toPlayList = TableUtil.deepCopy(self._playList)
		self._playList = {}

		table.clear(self._curPoolAudios)

		self._curPoolAudios = {}
		self._curPoolAudios = TableUtil.deepCopy(self._orginAudioList)
	end
end

function M:_checkIsEmpty()
	if #self._toPlayList <= 0 then
		table.clear(self._playList)

		self._playList = {}

		table.clear(self._curPoolAudios)

		self._curPoolAudios = {}
		self._curPoolAudios = TableUtil.deepCopy(self._orginAudioList)
	end
end

function M:_onPlayVoiceFinish()
	self:_tryNextVoiceTimer()
end

function M:_onEndShowPhone()
	self._isEndPlayVoice = true

	removetimer(self._onRandomNextVoice, self)
end

function M:onReturnScene()
	return
end

return M
