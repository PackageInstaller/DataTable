-- chunkname: @modules/logic/notice/model/NoticeModel.lua

module("modules.logic.notice.model.NoticeModel", package.seeall)

local NoticeModel = class("NoticeModel", ListScrollModel)

function NoticeModel:onInit()
	self._beforeloginNotices = {}
	self._norNotices = {}
	self._noticeUrl = {}
	self._hasOpenNoticeIdDict = {}
	self._hasOpenNoticeCount = 0
	self._cacheAssetItems = {}
	self._cacheSprite = {}
	self._cacheSpriteDefaultSize = {}
	self._loadedSpriteDict = {}
	self._loadingSprites = {}
	self._loadingSpriteCount = 0
	self._needLoadUrlList = {}
	self._loadTaskList = {}

	local noticeOpenIdsStr = PlayerPrefsHelper.getString(PlayerPrefsKey.NoticeAutoOpenIds, "")
	local noticeOpenIds = string.splitToNumber(noticeOpenIdsStr, "#")

	for _, id in ipairs(noticeOpenIds) do
		self._hasOpenNoticeIdDict[id] = true
	end

	self._hasOpenNoticeCount = #noticeOpenIds
	self._selectType = nil

	self:initRedDot()
end

function NoticeModel:initRedDot()
	self.redDotDict = {}

	local redDotStr = PlayerPrefsHelper.getString(PlayerPrefsKey.NoticeRedDotKey, nil)

	if not string.nilorempty(redDotStr) then
		for _, redDot in ipairs(string.split(redDotStr, ";")) do
			self.redDotDict[redDot] = true
		end
	end
end

function NoticeModel:buildRedDotKey(noticeMo)
	if not noticeMo then
		logWarn("noticeMo is nil")

		return nil
	end

	return tostring(noticeMo.gameId) .. tostring(noticeMo.id)
end

function NoticeModel:readNoticeMo(noticeMo)
	local noticeRedDot = self:buildRedDotKey(noticeMo)

	if not noticeRedDot then
		return
	end

	if self.redDotDict[noticeRedDot] then
		return
	end

	self.redDotDict[noticeRedDot] = true

	local redDotStr = ""

	for key, _ in pairs(self.redDotDict) do
		redDotStr = redDotStr .. key .. ";"
	end

	redDotStr = string.gsub(redDotStr, ";$", "")

	PlayerPrefsHelper.setString(PlayerPrefsKey.NoticeRedDotKey, redDotStr)
	NoticeController.instance:dispatchEvent(NoticeEvent.OnRefreshRedDot)
end

function NoticeModel:getNoticeMoIsRead(noticeMo)
	local noticeRedDot = self:buildRedDotKey(noticeMo)

	return noticeRedDot and self.redDotDict[noticeRedDot]
end

function NoticeModel:getNoticeTypeIsRead(noticeType)
	local noticeMoList = {}

	for _, noticeMO in ipairs(self._norNotices) do
		local now = ServerTime.now()

		if now > noticeMO.beginTime / 1000 and now < noticeMO.endTime / 1000 then
			for _, v in pairs(noticeMO.noticeTypes) do
				if noticeType == v then
					table.insert(noticeMoList, noticeMO)
				end
			end
		end
	end

	if #noticeMoList == 0 then
		return true
	end

	for _, noticeMo in ipairs(noticeMoList) do
		if not self:getNoticeMoIsRead(noticeMo) then
			return false
		end
	end

	return true
end

function NoticeModel:hasNotRedNotice()
	for _, noticeMO in ipairs(self._norNotices) do
		if noticeMO:isNormalStatus() and not self:getNoticeMoIsRead(noticeMO) then
			return true
		end
	end

	return false
end

function NoticeModel:onGetInfo(infoTable)
	self._beforeloginNotices = {}
	self._norNotices = {}

	for _, info in ipairs(infoTable) do
		if info.noticePositionTypes and next(info.noticePositionTypes) then
			local noticeMO = NoticeMO.New()

			noticeMO:init(info)

			for _, type in pairs(info.noticePositionTypes) do
				if type == NoticeEnum.NoticePositionType.BeforeLogin then
					table.insert(self._beforeloginNotices, noticeMO)
				elseif type == NoticeEnum.NoticePositionType.InGame then
					table.insert(self._norNotices, noticeMO)
				end
			end
		end
	end
end

function NoticeModel:checkNoticeOnlyIncludeType(noticeMo, type)
	if not noticeMo then
		return
	end

	if noticeMo.noticeTypes and #noticeMo.noticeTypes > 1 then
		return false
	end

	return noticeMo.noticeTypes and noticeMo.noticeTypes[1] == type
end

function NoticeModel:hadNewNotice()
	local list = self._norNotices

	for _, mo in ipairs(list) do
		if not self._hasOpenNoticeIdDict[mo.id] then
			return true
		end
	end

	return false
end

function NoticeModel:onOpenNoticeView()
	local list = self._norNotices

	for _, mo in ipairs(list) do
		self._hasOpenNoticeIdDict[mo.id] = true
	end

	local idList = {}

	for id, _ in pairs(self._hasOpenNoticeIdDict) do
		table.insert(idList, id)
	end

	if #idList > self._hasOpenNoticeCount then
		PlayerPrefsHelper.setString(PlayerPrefsKey.NoticeAutoOpenIds, table.concat(idList, "#"))
	end

	self._hasOpenNoticeCount = 999999999
end

function NoticeModel:addTestNoticeMO(noticeMO)
	table.insert(self._norNotices, noticeMO)
end

function NoticeModel:getNoticesByType(noticeType)
	local notices = {}

	for _, noticeMO in ipairs(self._norNotices) do
		local now = ServerTime.now()

		if now > noticeMO.beginTime / 1000 and now < noticeMO.endTime / 1000 then
			if noticeType == NoticeType.All then
				table.insert(notices, noticeMO)
			else
				for _, v in pairs(noticeMO.noticeTypes) do
					if noticeType == v then
						table.insert(notices, noticeMO)
					end
				end
			end
		end
	end

	return notices
end

function NoticeModel:getSelectType()
	return (self._selectType or nil) and (self._selectType or 1)
end

function NoticeModel:setSelectType(noticeType)
	self._selectType = noticeType
end

function NoticeModel:resetSelectType()
	self._selectType = nil
end

function NoticeModel:setAutoSelectType(noticeType)
	self.autoSelectType = noticeType
end

function NoticeModel:switchNoticeTypeByToggleId(toggleId)
	self:switchNoticeType(NoticeType.NoticeList[toggleId])
end

function NoticeModel:switchNoticeType(noticeType)
	noticeType = noticeType or NoticeType.All

	if noticeType == self._selectType then
		return
	end

	self:setSelectType(noticeType)
	self:resetLastSelectIndex()

	local list = {}

	for _, noticeMO in ipairs(self._norNotices) do
		local now = ServerTime.now()

		if now > noticeMO.beginTime / 1000 and now < noticeMO.endTime / 1000 then
			if noticeType == NoticeType.All then
				table.insert(list, noticeMO)
			else
				for _, v in pairs(noticeMO.noticeTypes) do
					if noticeType == v then
						table.insert(list, noticeMO)
					end
				end
			end
		end
	end

	table.sort(list, function(mo1, mo2)
		if mo1.isTop ~= mo2.isTop then
			return mo1.isTop > mo2.isTop
		end

		if mo1.order ~= mo2.order then
			return mo1.order > mo2.order
		end

		return mo1.id > mo2.id
	end)
	self:setList(list)
end

function NoticeModel:getNextUrlId()
	return #self._noticeUrl + 1
end

function NoticeModel:setNoticeUrl(id, url)
	self._noticeUrl[id] = url
end

function NoticeModel:getNoticeUrl(id)
	return self._noticeUrl[id]
end

function NoticeModel:hasBeforeLoginNotice()
	return self._beforeloginNotices and next(self._beforeloginNotices)
end

function NoticeModel:getBeforeLoginNoticeContent()
	return self._beforeloginNotices[1]:getContent()
end

function NoticeModel:getBeforeLoginNoticeTitle()
	return self._beforeloginNotices[1]:getTitle()
end

function NoticeModel:resetLastSelectIndex()
	for _, view in ipairs(self._scrollViews) do
		view.lastSelectIndex = -1
	end
end

function NoticeModel:getSpriteCache(filename)
	return self._cacheSprite[filename]
end

function NoticeModel:setSpriteCache(filename, sprite)
	self._cacheSprite[filename] = sprite
end

function NoticeModel:setLoadedSprite(filename)
	self._loadedSpriteDict[filename] = true
end

function NoticeModel:isLoaded(filename)
	return self._loadedSpriteDict[filename]
end

function NoticeModel:getSpriteCacheDefaultSize(filename)
	local sizeStr = self._cacheSpriteDefaultSize[filename]

	if string.nilorempty(sizeStr) then
		return nil, nil
	end

	local sizeList = string.splitToNumber(sizeStr, "*")

	return sizeList[1], sizeList[2]
end

function NoticeModel:setSpriteCacheDefaultSize(filename, width, height)
	if width > NoticeEnum.IMGMaxWidth then
		height = height / width * NoticeEnum.IMGMaxWidth
		width = NoticeEnum.IMGMaxWidth
	end

	self._cacheSpriteDefaultSize[filename] = string.format("%d*%d", width, height)
end

function NoticeModel:filenameInLoadingSprite(filename)
	return self._loadingSprites[filename] ~= nil
end

function NoticeModel:addLoadingSprite(filename)
	self._loadingSprites[filename] = true
	self._loadingSpriteCount = self._loadingSpriteCount + 1
end

function NoticeModel:removeLoadingSpriteCount(filename)
	self._loadingSprites[filename] = nil
	self._loadingSpriteCount = self._loadingSpriteCount - 1
end

function NoticeModel:getLoadingSpriteCount()
	return self._loadingSpriteCount
end

function NoticeModel:addAssetItem(assetItem)
	table.insert(self._cacheAssetItems, 1, assetItem)
end

function NoticeModel:addNeedLoadImageUrl(url)
	table.insert(self._needLoadUrlList, url)
end

function NoticeModel:popNeedLoadImageUrl()
	return table.remove(self._needLoadUrlList)
end

function NoticeModel:addLoadTask(taskFunc, taskObj)
	table.insert(self._loadTaskList, {
		taskFunc,
		taskObj
	})
end

function NoticeModel:removeLoadTask(taskFunc, taskObj)
	local removeIndex = 0

	for i, task in ipairs(self._loadTaskList) do
		if task[2] == taskObj and task[1] == taskFunc then
			removeIndex = i

			break
		end
	end

	table.remove(self._loadTaskList, removeIndex)
end

function NoticeModel:onCloseNoticeView()
	self:clear()
	NoticeContentListModel.instance:clear()
	self:setSelectType(nil)

	for i, task in ipairs(self._loadTaskList) do
		TaskDispatcher.cancelTask(task[1], task[2])
	end

	for i, sprite in ipairs(self._cacheSprite) do
		gohelper.destroy(sprite)
	end

	for i, assetItem in ipairs(self._cacheAssetItems) do
		assetItem:Release()
	end

	self._cacheSprite = {}
	self._cacheAssetItems = {}
	self._cacheSpriteDefaultSize = {}
	self._loadedSpriteDict = {}
	self._loadingSprites = {}
	self._loadingSpriteCount = 0
	self._needLoadUrlList = {}
	self._loadTaskList = {}
end

function NoticeModel:canAutoOpen()
	if not self:hadNewNotice() then
		return false
	end

	self:_initConstConfig()

	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.NoticePatKey)
	local autoOpenTimeStr = PlayerPrefsHelper.getString(key, "")
	local openTimeList = GameUtil.splitString2(autoOpenTimeStr, true, NoticeEnum.SecondSplitChar, NoticeEnum.FirstSplitChar)

	if not openTimeList or #openTimeList < self.configOpenCount then
		return true
	end

	local timeStamp = ServerTime.nowInLocal() - TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond
	local dt = os.date("*t", timeStamp)
	local year = dt.year
	local month = dt.month
	local day = dt.day
	local currentHour = dt.hour
	local hour = 0

	while currentHour >= hour + self.configTimeInterval do
		hour = hour + self.configTimeInterval
	end

	local newSaveTable = {}
	local count = 0

	for _, dayAndHour in ipairs(openTimeList) do
		local openYear, opeMonth, openDay, openHour = dayAndHour[1], dayAndHour[2]

		if openYear == year and opeMonth == month and openDay == day and hour <= openHour then
			count = count + 1

			table.insert(newSaveTable, string.format("%s%s%s%s%s%s%s", openYear, NoticeEnum.FirstSplitChar, opeMonth, NoticeEnum.FirstSplitChar, openDay, NoticeEnum.FirstSplitChar, openHour))
		end
	end

	PlayerPrefsHelper.setString(key, table.concat(newSaveTable, NoticeEnum.SecondSplitChar))

	return count < self.configOpenCount
end

function NoticeModel:_initConstConfig()
	if self.configTimeInterval then
		return
	end

	local constValue = lua_const.configDict[150].value
	local array = string.splitToNumber(constValue, "#")

	self.configTimeInterval, self.configOpenCount = array[1], array[2]
end

NoticeModel.instance = NoticeModel.New()

return NoticeModel
