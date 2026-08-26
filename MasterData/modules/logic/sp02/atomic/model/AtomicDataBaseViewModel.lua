-- chunkname: @modules/logic/sp02/atomic/model/AtomicDataBaseViewModel.lua

module("modules.logic.sp02.atomic.model.AtomicDataBaseViewModel", package.seeall)

local AtomicDataBaseViewModel = class("AtomicDataBaseViewModel", ListScrollModel)

function AtomicDataBaseViewModel:onInit()
	self:reInit()
end

function AtomicDataBaseViewModel:reInit()
	return
end

function AtomicDataBaseViewModel:initDatas()
	self:initPrefs()
	self:initTabList()

	self.curDataType = nil

	local dataType

	self:setCurDataType((not self.curDataType and self.tabList[1] or nil) and self.tabList[1].dataType)
end

function AtomicDataBaseViewModel:clear()
	AtomicDataBaseViewModel.super.clear(self)

	self.curDataType = nil
	self.tabList = nil
	self.unlockFlagDict = nil
	self.newFlagDict = nil
end

function AtomicDataBaseViewModel:initPrefs()
	self:initUnlockPrefs()
	self:initNewPrefs()
end

function AtomicDataBaseViewModel:initNewPrefs()
	if self.newFlagDict then
		return
	end

	local newFlag = AtomicController.instance:getPlayerPrefs(AtomicEnum.PlayerPrefsKey.AtomicDataBaseNewFlag, "")

	self.newFlagDict = {}

	local newFlagList = string.splitToNumber(newFlag, "#")

	for _, v in ipairs(newFlagList) do
		self.newFlagDict[v] = true
	end
end

function AtomicDataBaseViewModel:initUnlockPrefs()
	if self.unlockFlagDict then
		return
	end

	local unlockFlag = AtomicController.instance:getPlayerPrefs(AtomicEnum.PlayerPrefsKey.AtomicDataBaseUnlockFlag, "")

	self.unlockFlagDict = {}

	local unlockFlagList = string.splitToNumber(unlockFlag, "#")

	for _, v in ipairs(unlockFlagList) do
		self.unlockFlagDict[v] = true
	end
end

function AtomicDataBaseViewModel:initTabList()
	local tabList = {}
	local libraryList = AtomicConfig.instance:getLibraryList()
	local dict = {}

	for i, v in ipairs(libraryList) do
		local dataType = v.type

		if not dataType or dataType == 0 then
			dataType = 1
		end

		dict[dataType] = dict[dataType] or {}

		local data = {}

		data.id = v.id
		data.config = v
		data.unlock = self:isLibraryUnlock(v.id) and 0 or 1

		table.insert(dict[dataType], data)
	end

	for k, v in pairs(dict) do
		table.sort(v, SortUtil.keyLower("unlock", "id"))
		table.insert(tabList, {
			dataType = k,
			dataList = v
		})
	end

	self.tabList = tabList
end

function AtomicDataBaseViewModel:refreshDataList()
	local dataType = self:getCurDataType()
	local dataList = self:getDataList(dataType)

	self:setList(dataList)
end

function AtomicDataBaseViewModel:getDataList(dataType)
	for i, v in ipairs(self.tabList) do
		if v.dataType == dataType then
			return v.dataList
		end
	end

	return nil
end

function AtomicDataBaseViewModel:geTabList()
	return self.tabList
end

function AtomicDataBaseViewModel:setCurDataType(dataType)
	if self.curDataType == dataType then
		return false
	end

	self.curDataType = dataType

	local dataList = self:getDataList(dataType)

	if dataList then
		for _, v in ipairs(dataList) do
			if self:isLibraryUnlock(v.id) and self:isLibraryNew(v.id) then
				self.newFlagDict[v.id] = true
			end
		end

		self:saveLibraryNew()
	end

	self:refreshDataList()

	return true
end

function AtomicDataBaseViewModel:getCurDataType()
	return self.curDataType
end

function AtomicDataBaseViewModel:isTabSelected(dataType)
	return self.curDataType == dataType
end

function AtomicDataBaseViewModel:isTabNew(dataType)
	local dataList = self:getDataList(dataType)

	if not dataList then
		return false
	end

	for _, v in ipairs(dataList) do
		if self:isLibraryUnlock(v.id) and self:isLibraryNew(v.id) then
			return true
		end
	end

	return false
end

function AtomicDataBaseViewModel:isLibraryUnlock(id)
	local data = AtomicModel.instance:getData()

	return data:isLibraryUnlock(id)
end

function AtomicDataBaseViewModel:isLibraryNew(id)
	self:initNewPrefs()

	return not self.newFlagDict[id]
end

function AtomicDataBaseViewModel:clearLibraryNew(id)
	self:initNewPrefs()

	if self.newFlagDict[id] then
		return
	end

	self.newFlagDict[id] = true

	self:saveLibraryNew()
	AtomicDataBaseController.instance:notifyUpdateView()
end

function AtomicDataBaseViewModel:saveLibraryNew()
	local list = {}

	for k, v in pairs(self.newFlagDict) do
		if v then
			table.insert(list, k)
		end
	end

	local str = table.concat(list, "#")

	AtomicController.instance:setPlayerPrefs(AtomicEnum.PlayerPrefsKey.AtomicDataBaseNewFlag, str)
end

function AtomicDataBaseViewModel:isPlayedUnlockAnim(id)
	return self.unlockFlagDict and self.unlockFlagDict[id]
end

function AtomicDataBaseViewModel:setPlayedUnlockAnim(id)
	if not self.unlockFlagDict or self.unlockFlagDict[id] then
		return
	end

	self.unlockFlagDict[id] = true

	local list = {}

	for k, v in pairs(self.unlockFlagDict) do
		if v then
			table.insert(list, k)
		end
	end

	local str = table.concat(list, "#")

	AtomicController.instance:setPlayerPrefs(AtomicEnum.PlayerPrefsKey.AtomicDataBaseUnlockFlag, str)
end

function AtomicDataBaseViewModel:playScrollOpenAnim()
	for _, scrollView in ipairs(self._scrollViews) do
		if scrollView.playOpenAnimation then
			scrollView:playOpenAnimation()
		end
	end
end

function AtomicDataBaseViewModel:isDataBaseHasNew()
	local libraryList = AtomicConfig.instance:getLibraryList()

	for i, v in ipairs(libraryList) do
		if self:isLibraryUnlock(v.id) and self:isLibraryNew(v.id) then
			return true
		end
	end

	return false
end

AtomicDataBaseViewModel.instance = AtomicDataBaseViewModel.New()

return AtomicDataBaseViewModel
