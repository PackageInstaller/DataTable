-- chunkname: @modules/logic/sp01/library/AssassinLibraryModel.lua

module("modules.logic.sp01.library.AssassinLibraryModel", package.seeall)

local AssassinLibraryModel = class("AssassinLibraryModel", BaseModel)

function AssassinLibraryModel:onInit()
	self._statusMap = {}
	self._hasReadLibraryIdMap = {}
	self._hasReadLibraryIds = {}
	self._hasPlayUnlockAnimList = nil
	self._isLoadLocalData = false
end

function AssassinLibraryModel:reInit()
	self:onInit()
end

function AssassinLibraryModel:loadHasReadLibraryIdsFromLocal()
	if self._isLoadLocalData then
		return
	end

	local hasReadLibraryIdStr = PlayerPrefsHelper.getString(self:_getLibraryHasReadIdMapKey(), "")
	local hasReadLibraryIds = string.splitToNumber(hasReadLibraryIdStr, "#")

	for _, libraryId in ipairs(hasReadLibraryIds) do
		self:setLibraryStatus(libraryId, AssassinEnum.LibraryStatus.Unlocked)
	end

	self._isLoadLocalData = true
end

function AssassinLibraryModel:updateLibraryInfos(unlockLibraryIds)
	self:loadHasReadLibraryIdsFromLocal()

	for _, libraryId in ipairs(unlockLibraryIds) do
		local preStatus = self:getLibraryStatus(libraryId)
		local isNew = preStatus == AssassinEnum.LibraryStatus.Locked or preStatus == AssassinEnum.LibraryStatus.New

		if isNew then
			if not AssassinEnum.LibraryStatus.New then
				local newStatus = AssassinEnum.LibraryStatus.Unlocked

				self:setLibraryStatus(libraryId, newStatus)
			end
		end
	end
end

function AssassinLibraryModel:switch(actId, libType)
	self._actId = actId
	self._libType = libType
end

function AssassinLibraryModel:getCurActId()
	return self._actId
end

function AssassinLibraryModel:getCurLibType()
	return self._libType
end

function AssassinLibraryModel:getLibraryStatus(libraryId)
	return self._statusMap[libraryId] or AssassinEnum.LibraryStatus.Locked
end

function AssassinLibraryModel:setLibraryStatus(libraryId, newStatus)
	if newStatus == AssassinEnum.LibraryStatus.Unlocked and not self._hasReadLibraryIdMap[libraryId] then
		self._hasReadLibraryIdMap[libraryId] = true

		table.insert(self._hasReadLibraryIds, libraryId)
	end

	self._statusMap[libraryId] = newStatus
end

function AssassinLibraryModel:readLibrary(libraryId)
	local status = self:getLibraryStatus(libraryId)

	if status == AssassinEnum.LibraryStatus.Locked then
		return
	end

	self:setLibraryStatus(libraryId, AssassinEnum.LibraryStatus.Unlocked)

	if status == AssassinEnum.LibraryStatus.New then
		self:saveLocalHasReadLibraryIds()
		AssassinController.instance:dispatchEvent(AssassinEvent.UpdateLibraryReddot)
	end
end

function AssassinLibraryModel:readTypeLibrarys(actId, libType)
	local libraryCoList = AssassinConfig.instance:getLibraryConfigs(actId, libType)

	if not libraryCoList then
		return
	end

	for _, libraryCo in ipairs(libraryCoList) do
		self:readLibrary(libraryCo.id)
	end
end

function AssassinLibraryModel:saveLocalHasReadLibraryIds()
	local hasReadLibraryIdStr = table.concat(self._hasReadLibraryIds, "#")

	PlayerPrefsHelper.setString(self:_getLibraryHasReadIdMapKey(), hasReadLibraryIdStr)
end

function AssassinLibraryModel:_getLibraryHasReadIdMapKey()
	return PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.AssassinLibraryHasReadIdMap)
end

function AssassinLibraryModel:isAnyLibraryNewUnlock()
	for _, status in pairs(self._statusMap) do
		if status == AssassinEnum.LibraryStatus.New then
			return true
		end
	end

	return false
end

function AssassinLibraryModel:getNewUnlockLibraryIdMap(actId)
	local type2ReddotMap = {}
	local actLibraryDict = AssassinConfig.instance:getActLibraryConfigDict(actId)

	for type, libraryList in pairs(actLibraryDict) do
		type2ReddotMap[type] = false

		for _, libraryCo in ipairs(libraryList) do
			if self:getLibraryStatus(libraryCo.id) == AssassinEnum.LibraryStatus.New then
				type2ReddotMap[type] = true

				break
			end
		end
	end

	return type2ReddotMap
end

function AssassinLibraryModel:isUnlockAllLibrarys(actId, libraryType)
	local libraryList = AssassinConfig.instance:getLibraryConfigs(actId, libraryType)

	for _, libraryCo in ipairs(libraryList or {}) do
		local status = self:getLibraryStatus(libraryCo.id)

		if status == AssassinEnum.LibraryStatus.Locked then
			return false
		end
	end

	return true
end

function AssassinLibraryModel:isLibraryNeedPlayUnlockAnim(libraryId)
	local status = self:getLibraryStatus(libraryId)

	if status == AssassinEnum.LibraryStatus.Locked then
		return
	end

	return not self:_isUnlockAnimMapContains(libraryId)
end

function AssassinLibraryModel:_isUnlockAnimMapContains(libraryId)
	if not self._hasPlayUnlockAnimList then
		local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.AssassinLibraryHasPlayUnlockAnimIds)
		local saveStr = PlayerPrefsHelper.getString(key, "")

		self._hasPlayUnlockAnimList = string.splitToNumber(saveStr, "#")
	end

	return tabletool.indexOf(self._hasPlayUnlockAnimList, libraryId) ~= nil
end

function AssassinLibraryModel:markLibraryHasPlayUnlockAnim(libraryId)
	if not self:_isUnlockAnimMapContains(libraryId) then
		table.insert(self._hasPlayUnlockAnimList, libraryId)

		local unlockIdStr = table.concat(self._hasPlayUnlockAnimList, "#")
		local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.AssassinLibraryHasPlayUnlockAnimIds)

		PlayerPrefsHelper.setString(key, unlockIdStr)
	end
end

AssassinLibraryModel.instance = AssassinLibraryModel.New()

return AssassinLibraryModel
