-- chunkname: @modules/logic/udimo/model/UdimoModel.lua

module("modules.logic.udimo.model.UdimoModel", package.seeall)

local UdimoModel = class("UdimoModel", BaseModel)

function UdimoModel:onInit()
	self:clearData()
end

function UdimoModel:reInit()
	self:clearData()
end

function UdimoModel:clearData()
	self._playerCacheData = nil
	self._settingId = nil

	self:clearSceneData()
end

function UdimoModel:clearSceneData()
	self._interactPointDict = {}
	self._friendInteract = {}

	self:setPickedUpUdimoId()
	self:setResumeViewName()
end

function UdimoModel:_getPlayerCacheData()
	if not self._playerCacheData then
		local strCacheData = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.UdimoPrefsDataKey, "")

		if not string.nilorempty(strCacheData) then
			self._playerCacheData = cjson.decode(strCacheData)
		end

		self._playerCacheData = self._playerCacheData or {}
	end

	return self._playerCacheData
end

function UdimoModel:savePlayerCacheData()
	if not self._playerCacheData then
		return
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.UdimoPrefsDataKey, cjson.encode(self._playerCacheData))
end

function UdimoModel:setUdimoInfoByList(infoList)
	self:clear()

	if infoList then
		local list = GameUtil.rpcInfosToList(infoList, UdimoMO)

		self:setList(list)
	end
end

function UdimoModel:updateAllUdimoUseInfo(useUdimoIdList)
	if not useUdimoIdList then
		return
	end

	local useDict = {}

	for _, udimoId in ipairs(useUdimoIdList) do
		useDict[udimoId] = true
	end

	local udimoMOList = self:getList()

	for _, udimoMO in ipairs(udimoMOList) do
		local udimoId = udimoMO:getId()

		udimoMO:setUse(useDict[udimoId])
	end
end

function UdimoModel:setPickedUpUdimoId(uidmoId)
	self._pickedUpUdimoId = uidmoId
end

function UdimoModel:setCacheKeyData(key, data)
	local playerCacheData = self:_getPlayerCacheData()

	if not playerCacheData then
		return
	end

	playerCacheData[key] = data
end

function UdimoModel:setUdimoInteractPoint(interactId, udimoId)
	if not interactId then
		return
	end

	self._interactPointDict[interactId] = udimoId
end

function UdimoModel:setFriendInteractEmojiList(friendId, isClear)
	self._friendInteract = self._friendInteract or {}

	if isClear then
		self._friendInteract[friendId] = nil
	else
		local useBg = UdimoItemModel.instance:getUseBg()
		local emojiDataList = UdimoConfig.instance:getFriendEmojiDataList(useBg, friendId)

		self._friendInteract[friendId] = {
			index = 0,
			emojiDataList = emojiDataList
		}
	end
end

function UdimoModel:setUdimoSettingId(id)
	self._settingId = id

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.GameUdimoLockTimeSettingKey, self._settingId)
end

function UdimoModel:setResumeViewName(viewName)
	self._resumeViewName = viewName
end

function UdimoModel:isOpenUdimoFunc(isToast)
	local result = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Udimo)

	if not result and isToast then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Udimo))
	end

	return result
end

function UdimoModel:getUdimoMO(udimoId)
	return self:getById(udimoId)
end

function UdimoModel:isUnlockUdimo(udimoId)
	return UdimoHelper.hasUnlockItem(udimoId)
end

function UdimoModel:getUseUdimoCount()
	local count = 0
	local list = self:getList()

	for _, udimoMO in ipairs(list) do
		if udimoMO:getIsUse() then
			count = count + 1
		end
	end

	return count
end

function UdimoModel:getUseUdimoIdList()
	local result = {}
	local list = self:getList()

	for _, udimoMO in ipairs(list) do
		if udimoMO:getIsUse() then
			result[#result + 1] = udimoMO:getId()
		end
	end

	return result
end

function UdimoModel:isUseUdimo(udimoId)
	local udimoMO = self:getUdimoMO(udimoId)

	return udimoMO and udimoMO:getIsUse()
end

function UdimoModel:getUdimoGetTimeStr(udimoId)
	local result = ""
	local udimoMO = self:getUdimoMO(udimoId)

	if udimoMO then
		local heroId = UdimoConfig.instance:getUdimoHeroId(udimoId)
		local heroMO = HeroModel.instance:getByHeroId(heroId)
		local hasHero = heroMO and heroMO:isOwnHero()

		if hasHero then
			local time = udimoMO:getGetTime()

			if time then
				local localTime = ServerTime.timeInLocal(time / 1000)
				local timeStr = TimeUtil.timestampToString2(localTime)

				result = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v3a2_udimo_info_gettime"), timeStr)
			end
		else
			result = luaLang("v3a2_udimo_info_no_gettime")
		end
	end

	return result
end

function UdimoModel:getInfoList(udimoId)
	local list = {}
	local udimoMO = self:getUdimoMO(udimoId)

	if udimoMO then
		local dataList = udimoMO:getInfoDataList()
		local infoIdList = UdimoConfig.instance:getShowInfoIdList()

		for i, infoId in ipairs(infoIdList) do
			local data = dataList[i]

			if data then
				local langId = UdimoConfig.instance:getInfoLangId(infoId)
				local strLang = luaLang(langId)

				list[i] = {
					icon = UdimoConfig.instance:getInfoIcon(infoId),
					text = GameUtil.getSubPlaceholderLuaLangOneParam(strLang, data)
				}
			else
				logError(string.format("UdimoModel:getInfoList error, no data, udimoId:%s, infoId:%s", udimoId, infoId))
			end
		end
	end

	return list
end

function UdimoModel:getPickedUpUdimoId()
	return self._pickedUpUdimoId
end

function UdimoModel:getCacheKeyData(key)
	local result

	if key then
		local playerCacheData = self:_getPlayerCacheData()

		result = playerCacheData and playerCacheData[key]
	end

	return result
end

function UdimoModel:getInteractPointUdimo(interactId)
	return self._interactPointDict[interactId]
end

function UdimoModel:getUdimoInteractId(targetUdimoId)
	for interactId, udimoId in pairs(self._interactPointDict) do
		if udimoId == targetUdimoId then
			return interactId
		end
	end
end

function UdimoModel:canStartInteract(udimoId, interactId)
	local useBg = UdimoItemModel.instance:getUseBg()
	local friendId, friendUdimoId, friendInteractId = UdimoConfig.instance:getUdimoRelativeFriend(useBg, udimoId, interactId)
	local curInteractId = self:getUdimoInteractId(friendUdimoId)

	if curInteractId and curInteractId == friendInteractId then
		return friendId
	end
end

function UdimoModel:getNextFriendInteractEmoji(friendId)
	local emojiData
	local interactData = self._friendInteract[friendId]

	if interactData then
		local curIndex = interactData.index

		emojiData = interactData.emojiDataList[curIndex + 1]
		interactData.index = curIndex + 1
	end

	return emojiData
end

function UdimoModel:getUdimoSettingId()
	if not self._settingId then
		local defaultSetting = UdimoConfig.instance:getDefaultSettingId()

		self._settingId = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.GameUdimoLockTimeSettingKey, defaultSetting)
	end

	return self._settingId
end

function UdimoModel:getResumeViewName()
	return self._resumeViewName
end

UdimoModel.instance = UdimoModel.New()

return UdimoModel
