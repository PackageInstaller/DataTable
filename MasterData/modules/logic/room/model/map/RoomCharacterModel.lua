-- chunkname: @modules/logic/room/model/map/RoomCharacterModel.lua

module("modules.logic.room.model.map.RoomCharacterModel", package.seeall)

local RoomCharacterModel = class("RoomCharacterModel", BaseModel)

function RoomCharacterModel:onInit()
	self:_clearData()
end

function RoomCharacterModel:reInit()
	self:_clearData()
end

function RoomCharacterModel:clear()
	RoomCharacterModel.super.clear(self)
	self:_clearData()
end

function RoomCharacterModel:_clearData()
	self._tempCharacterMO = nil
	self._canConfirmPlaceDict = nil
	self._allNodePositionList = nil
	self._cantWadeNodePositionList = nil
	self._canDragCharacter = false
	self._waterNodePositions = nil
	self._hideFaithFullMap = {}
	self._emptyBlockPositions = nil
	self._showBirthdayToastTipCache = nil
end

function RoomCharacterModel:initCharacter(infos)
	self:clear()

	if not infos or #infos <= 0 then
		return
	end

	for i, info in ipairs(infos) do
		local characterInfo = RoomInfoHelper.serverInfoToCharacterInfo(info)
		local tempPosition = RoomModel.instance:getCharacterPosition(characterInfo.heroId)

		if tempPosition then
			characterInfo.currentPosition = RoomCharacterHelper.reCalculateHeight(tempPosition)
		end

		local characterMO = RoomCharacterMO.New()

		characterMO:init(characterInfo)

		local roomCharacterConfig = RoomConfig.instance:getRoomCharacterConfig(characterMO.skinId)

		if roomCharacterConfig then
			self:_addCharacterMO(characterMO)
		end
	end

	self:_initHideFithData()
end

function RoomCharacterModel:addTempCharacterMO(heroId, position, skinId)
	if self._tempCharacterMO then
		return
	end

	self._tempCharacterMO = RoomCharacterMO.New()

	local characterInfo = RoomInfoHelper.generateTempCharacterInfo(heroId, position, skinId)

	self._tempCharacterMO:init(characterInfo)
	RoomCharacterController.instance:correctCharacterHeight(self._tempCharacterMO)
	self:_addCharacterMO(self._tempCharacterMO)
	self:clearCanConfirmPlaceDict()

	return self._tempCharacterMO
end

function RoomCharacterModel:getTempCharacterMO()
	return self._tempCharacterMO
end

function RoomCharacterModel:changeTempCharacterMO(position)
	if not self._tempCharacterMO then
		return
	end

	self._tempCharacterMO:setPosition(RoomCharacterHelper.reCalculateHeight(position))
end

function RoomCharacterModel:removeTempCharacterMO()
	if not self._tempCharacterMO then
		return
	end

	self:_removeCharacterMO(self._tempCharacterMO)

	self._tempCharacterMO = nil

	self:clearCanConfirmPlaceDict()
end

function RoomCharacterModel:placeTempCharacterMO()
	if not self._tempCharacterMO then
		return
	end

	RoomCharacterController.instance:correctCharacterHeight(self._tempCharacterMO)

	self._tempCharacterMO.characterState = RoomCharacterEnum.CharacterState.Map
	self._tempCharacterMO = nil

	self:clearCanConfirmPlaceDict()
end

function RoomCharacterModel:revertTempCharacterMO(heroId)
	if self._tempCharacterMO then
		return
	end

	self._tempCharacterMO = self:getCharacterMOById(heroId)

	if not self._tempCharacterMO then
		return
	end

	self._tempCharacterMO.characterState = RoomCharacterEnum.CharacterState.Revert
	self._revertPosition = self._tempCharacterMO.currentPosition

	self:clearCanConfirmPlaceDict()

	return self._tempCharacterMO
end

function RoomCharacterModel:removeRevertCharacterMO()
	if not self._tempCharacterMO then
		return
	end

	local heroId = self._tempCharacterMO.heroId

	self._tempCharacterMO:setPosition(RoomCharacterHelper.reCalculateHeight(self._revertPosition))

	self._tempCharacterMO.characterState = RoomCharacterEnum.CharacterState.Map
	self._tempCharacterMO = nil

	self:clearCanConfirmPlaceDict()

	return heroId, self._revertPosition
end

function RoomCharacterModel:unUseRevertCharacterMO()
	if not self._tempCharacterMO then
		return
	end

	self:_removeCharacterMO(self._tempCharacterMO)

	self._tempCharacterMO = nil

	self:clearCanConfirmPlaceDict()
end

function RoomCharacterModel:getRevertPosition()
	return self._revertPosition
end

function RoomCharacterModel:resetCharacterMO(heroId, position)
	local roomCharacterMO = self:getById(heroId)

	if not roomCharacterMO then
		return
	end

	roomCharacterMO:endMove()
	roomCharacterMO:setPosition(RoomCharacterHelper.reCalculateHeight(position))
end

function RoomCharacterModel:deleteCharacterMO(heroId)
	local roomCharacterMO = self:getById(heroId)

	if not roomCharacterMO then
		return
	end

	self:_removeCharacterMO(roomCharacterMO)
	self:setHideFaithFull(heroId, false)
end

function RoomCharacterModel:endAllMove()
	local roomCharacterMOList = self:getList()

	for i, roomCharacterMO in ipairs(roomCharacterMOList) do
		roomCharacterMO:endMove()
	end
end

function RoomCharacterModel:getConfirmCharacterCount()
	local list = self:getList()
	local count = 0

	for i, mo in ipairs(list) do
		if (mo.characterState == RoomCharacterEnum.CharacterState.Map or mo.characterState == RoomCharacterEnum.CharacterState.Revert) and mo:isPlaceSourceState() then
			count = count + 1
		end
	end

	return count
end

function RoomCharacterModel:getMaxCharacterCount(buildDegree, roomLevel)
	if not roomLevel then
		::label_19_0::

		local roomLevel = RoomMapModel.instance:getRoomLevel()
		local roomLevelConfig = RoomConfig.instance:getRoomLevelConfig(roomLevel)

		if roomLevelConfig then
			if not roomLevelConfig.characterLimit then
				local characterLimit = 0

				if not buildDegree then
					::label_19_1::

					local buildDegree = RoomMapModel.instance:getAllBuildDegree()
					local characterLimitAdd = RoomConfig.instance:getCharacterLimitAddByBuildDegree(buildDegree)

					characterLimit = characterLimit + characterLimitAdd

					return characterLimit
				end
			end
		end
	end
end

function RoomCharacterModel:refreshCanConfirmPlaceDict()
	self._canConfirmPlaceDict = not self._tempCharacterMO and {} or RoomCharacterHelper.getCanConfirmPlaceDict(self._tempCharacterMO.heroId, self._tempCharacterMO.skinId)
end

function RoomCharacterModel:isCanConfirm(hexPoint)
	if not self._canConfirmPlaceDict then
		self:refreshCanConfirmPlaceDict()
	end

	return self._canConfirmPlaceDict[hexPoint.x] and self._canConfirmPlaceDict[hexPoint.x][hexPoint.y]
end

function RoomCharacterModel:getCanConfirmPlaceDict()
	if not self._canConfirmPlaceDict then
		self:refreshCanConfirmPlaceDict()
	end

	return self._canConfirmPlaceDict
end

function RoomCharacterModel:clearCanConfirmPlaceDict()
	self._canConfirmPlaceDict = nil
end

function RoomCharacterModel:_refreshNodePositionList()
	self._allNodePositionList = {}

	local allList = ZProj.AStarPathBridge.GetNodePositions(RoomCharacterHelper.getTag(true))

	RoomHelper.cArrayToLuaTable(allList, self._allNodePositionList)

	self._cantWadeNodePositionList = {}

	local list = ZProj.AStarPathBridge.GetNodePositions(RoomCharacterHelper.getTag(false))

	RoomHelper.cArrayToLuaTable(list, self._cantWadeNodePositionList)
end

function RoomCharacterModel:getNodePositionList(canWade)
	if not self._allNodePositionList or not self._cantWadeNodePositionList then
		self:_refreshNodePositionList()
	end

	return (canWade or nil) and (self._allNodePositionList or self._cantWadeNodePositionList)
end

function RoomCharacterModel:clearNodePositionList()
	self._cantWadeNodePositionList = nil
	self._allNodePositionList = nil
end

function RoomCharacterModel:_addCharacterMO(mo)
	self:addAtLast(mo)
end

function RoomCharacterModel:_removeCharacterMO(mo)
	self:remove(mo)
end

function RoomCharacterModel:editRemoveCharacterMO(heroId)
	local mo = self:getById(heroId)

	if mo then
		self:_removeCharacterMO(mo)
	end
end

function RoomCharacterModel:getCharacterMOById(heroId)
	local mo = self:getById(heroId)

	if not mo and self._trainTempMO and self._trainTempMO.id == heroId then
		return self._trainTempMO
	end

	return mo
end

function RoomCharacterModel:updateCharacterFaith(roomHeroDatas)
	for i, roomHeroData in ipairs(roomHeroDatas) do
		local roomCharacterMO = self:getCharacterMOById(roomHeroData.heroId)

		if roomCharacterMO then
			roomCharacterMO.currentFaith = roomHeroData.currentFaith
			roomCharacterMO.currentMinute = roomHeroData.currentMinute
			roomCharacterMO.nextRefreshTime = roomHeroData.nextRefreshTime
		end
	end
end

function RoomCharacterModel:setCanDragCharacter(canDragCharacter)
	self._canDragCharacter = canDragCharacter
end

function RoomCharacterModel:canDragCharacter()
	return self._canDragCharacter
end

function RoomCharacterModel:_refreshWaterNodePositions()
	self._waterNodePositions = {}

	local waterNodePositionList = ZProj.AStarPathBridge.GetNodePositions(bit.lshift(1, RoomEnum.AStarLayerTag.Water))

	if waterNodePositionList then
		local iter = waterNodePositionList:GetEnumerator()

		while iter:MoveNext() do
			table.insert(self._waterNodePositions, iter.Current)
		end
	end
end

function RoomCharacterModel:getWaterNodePositions()
	if not self._waterNodePositions then
		self:_refreshWaterNodePositions()
	end

	return self._waterNodePositions
end

function RoomCharacterModel:setHideFaithFull(heroId, hide)
	if not hide and not self._hideFaithFullMap[heroId] then
		return
	end

	local tempHide = not not hide

	if tempHide ~= self._hideFaithFullMap[heroId] then
		self._hideFaithFullMap[heroId] = tempHide

		self:_saveFaithFullData(self._hideFaithFullMap)
	end
end

function RoomCharacterModel:isShowFaithFull(heroId)
	if self._hideFaithFullMap[heroId] then
		return false
	end

	return true
end

function RoomCharacterModel:_getFaithFullPrefsKey()
	return "room_character_faithfull_role#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function RoomCharacterModel:_initHideFithData()
	self._hideFaithFullMap = {}

	if self:_canUseFaithFull() then
		local numstr = PlayerPrefsHelper.getString(self:_getFaithFullPrefsKey(), "")
		local heroIds = string.splitToNumber(numstr, "#") or {}
		local needSave = false

		for _, heroId in ipairs(heroIds) do
			if self:getById(heroId) then
				self._hideFaithFullMap[heroId] = true
			else
				needSave = true
			end
		end

		if needSave then
			self:_saveFaithFullData(self._hideFaithFullMap)
		end
	end
end

function RoomCharacterModel:_saveFaithFullData(faithFillMap)
	if not self:_canUseFaithFull() or not faithFillMap then
		return
	end

	local str = ""
	local isFirst = true

	for k, v in pairs(faithFillMap) do
		if v == true then
			if isFirst then
				isFirst = false
				str = tostring(k)
			else
				str = str .. "#" .. tostring(k)
			end
		end
	end

	PlayerPrefsHelper.setString(self:_getFaithFullPrefsKey(), str)
end

function RoomCharacterModel:_canUseFaithFull()
	local gameMode = RoomModel.instance:getGameMode()

	return gameMode == RoomEnum.GameMode.Ob or gameMode == RoomEnum.GameMode.Edit
end

function RoomCharacterModel:getEmptyBlockPositions()
	if not self._emptyBlockPositions then
		self._emptyBlockPositions = {}

		local emptyMOList = RoomMapBlockModel.instance:getEmptyBlockMOList()

		for _, blockMO in ipairs(emptyMOList) do
			if blockMO.hexPoint then
				table.insert(self._emptyBlockPositions, HexMath.hexToPosition(blockMO.hexPoint, RoomBlockEnum.BlockSize))
			end
		end
	end

	return self._emptyBlockPositions
end

function RoomCharacterModel:isOnBirthday(heroId)
	local result = false

	if heroId then
		::label_43_0::

		local heroCo = HeroConfig.instance:getHeroCO(heroId)
		local roleBirthday = heroCo and heroCo.roleBirthday

		if not string.nilorempty(roleBirthday) then
			local curDate = SignInModel.instance:getCurDate()
			local birth = string.splitToNumber(heroCo.roleBirthday, "/")
			local birthday = {
				hour = 5,
				min = 0,
				sec = 0,
				year = curDate.year,
				month = birth[1],
				day = birth[2]
			}
			local localBirthdayTimestamp = os.time(birthday)
			local serverBirthdayTimestamp = localBirthdayTimestamp - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
			local birthdayDurationDay = CommonConfig.instance:getConstNum(ConstEnum.RoomBirthdayDurationDay)
			local endBirthdayTimestamp = serverBirthdayTimestamp + birthdayDurationDay * TimeUtil.OneDaySecond
			local now = ServerTime.now()

			if serverBirthdayTimestamp <= now and now < endBirthdayTimestamp then
				result = true
			end
		end

		return result
	end
end

function RoomCharacterModel:initShowBirthdayToastTipCache()
	local strCacheData = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.RoomBirthdayToastKey, "")

	if not string.nilorempty(strCacheData) then
		self._showBirthdayToastTipCache = cjson.decode(strCacheData)
	end

	self._showBirthdayToastTipCache = self._showBirthdayToastTipCache or {}
end

function RoomCharacterModel:isNeedShowBirthdayToastTip(heroId)
	local result = false

	if not heroId then
		return result
	end

	local hasCurDayPlay = false

	if not self._showBirthdayToastTipCache then
		self:initShowBirthdayToastTipCache()
	end

	local strHeroId = tostring(heroId)
	local lastToastTime = self._showBirthdayToastTipCache[strHeroId]

	if lastToastTime then
		local nowTime = ServerTime.now()

		hasCurDayPlay = TimeUtil.isSameDay(lastToastTime, nowTime - TimeDispatcher.DailyRefreshSecond)
	end

	local isOnBirthday = self:isOnBirthday(heroId)

	result = isOnBirthday and not hasCurDayPlay

	return result
end

function RoomCharacterModel:getPlaceCount()
	local count = 0
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo:isPlaceSourceState() then
			count = count + 1
		end
	end

	return count
end

function RoomCharacterModel:setHasShowBirthdayToastTip(heroId)
	if not heroId then
		return
	end

	if not self._showBirthdayToastTipCache then
		self:initShowBirthdayToastTipCache()
	end

	local recordTime = ServerTime.now() - TimeDispatcher.DailyRefreshSecond
	local strHeroId = tostring(heroId)

	self._showBirthdayToastTipCache[strHeroId] = recordTime

	local strJson = cjson.encode(self._showBirthdayToastTipCache)

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.RoomBirthdayToastKey, strJson)
end

function RoomCharacterModel:getTrainTempMO()
	self._trainTempMO = self._trainTempMO or RoomCharacterMO.New()

	return self._trainTempMO
end

RoomCharacterModel.instance = RoomCharacterModel.New()

return RoomCharacterModel
