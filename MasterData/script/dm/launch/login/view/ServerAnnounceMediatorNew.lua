-- chunkname: @/tmp/or_script/lua_compile/dm/launch/login/view/ServerAnnounceMediatorNew.lua

ServerAnnounceMediatorNew = class("ServerAnnounceMediatorNew", DmPopupViewMediator, _M)

ServerAnnounceMediatorNew:has("_loginSystem", {
	is = "r"
}):injectWith("LoginSystem")
require("dm.downloader.Downloader")

local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	},
	btn_skip = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickSkip"
	}
}
local redPointType = {
	KOneTime = 3,
	KNotShow = 1,
	KOneTimeEveryDay = 2
}

function ServerAnnounceMediatorNew:initialize()
	super.initialize(self)
end

function ServerAnnounceMediatorNew:dispose()
	super.dispose(self)
end

function ServerAnnounceMediatorNew:onRemove()
	super.onRemove(self)
end

function ServerAnnounceMediatorNew:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ANNOUNCE_REFRESH_SERVER, self, self.onRefreshAnnounceEvent)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PATFACE_REFRESH_SERVER, self, self.onRefreshPatfaceEvent)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PV_REFRESH_SERVER, self, self.onRefreshPVEvent)
end

function ServerAnnounceMediatorNew:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")

	self._main:getChildByName("view_bg"):setTouchEnabled(true)

	self._btnUpModel = self:getView():getChildByName("btn_up")

	self._btnUpModel:setVisible(false)

	self._btnLeftModel = self:getView():getChildByName("btn_left")

	self._btnLeftModel:setVisible(false)

	self._centerType1 = self:getView():getChildByName("centerType1")

	self._centerType1:setVisible(false)

	self._centerType2 = self:getView():getChildByName("centerType2")

	self._centerType2:setVisible(false)

	self._centerType3 = self:getView():getChildByName("centerType3")

	self._centerType3:setVisible(false)

	self._centerType4 = self:getView():getChildByName("centerType4")

	self._centerType4:setVisible(false)

	self._activityLayout = self._main:getChildByName("activityLayout")
	self._listViewLeft = self._activityLayout:getChildByName("ListView_left")

	self._listViewLeft:setScrollBarEnabled(false)

	self._listViewCenter = self._activityLayout:getChildByName("ListView_center")

	self._listViewCenter:setScrollBarEnabled(false)

	self._skipBtn = self:getView():getChildByName("btn_skip")

	self._skipBtn:setVisible(false)

	self._pvPanel = self:getView():getChildByName("pv")

	self._pvPanel:setVisible(false)

	self._listViewUp = self._main:getChildByName("ListView_up")

	self._listViewUp:setScrollBarEnabled(false)
	self._listViewUp:setVisible(false)

	self.btnUpTable = {}
	self.btnLeftTable = {}
	self.loadTaskTable = {}

	self:mapEventListeners()
end

function ServerAnnounceMediatorNew:enterWithData(data)
	self.isLogin = data.isLogin

	if not self.isLogin then
		self.relativeFolderPath = cc.FileUtils:getInstance():getWritablePath() .. "AnnounceDir"
		self.playerRid = self:getInjector():getInstance("DevelopSystem"):getPlayer():getRid()
		self._downloader = Downloader:getInstance()
		self.pvFolderPath = cc.FileUtils:getInstance():getWritablePath() .. "PVDir"
	end

	self._data = data
	self._curShowType = ""

	self:setupView()
end

function ServerAnnounceMediatorNew:setupView()
	local AnnounceDate = {}

	if self.isLogin then
		AnnounceDate = {
			{
				type = "system",
				data = {}
			}
		}

		self._listViewUp:setVisible(true)
	else
		self.playerRid = self:getInjector():getInstance("DevelopSystem"):getPlayer():getRid()
		AnnounceDate = {
			{
				type = "activity",
				data = {}
			},
			{
				type = "activityPV",
				data = {}
			},
			{
				type = "system",
				data = {}
			}
		}
	end

	self:setUpList(AnnounceDate)
end

function ServerAnnounceMediatorNew:setUpList(AnnounceDate)
	for k, v in pairs(AnnounceDate) do
		local layout = ccui.Widget:create()
		local cell = self._btnUpModel:clone()

		cell:setVisible(true)

		if v.type == "activity" then
			cell:getChildByName("btn_up_lbl"):setString(Strings:get("Frame_UI_2") .. Strings:get("LOGIN_UI4"))
		elseif v.type == "system" then
			cell:getChildByName("btn_up_lbl"):setString(Strings:get("LOGIN_UI1"))
		elseif v.type == "activityPV" then
			cell:getChildByName("btn_up_lbl"):setString(Strings:get("BoardTitle_Tab_1"))
			self:addPVRedPoint(cell)
		end

		local cellSize = cell:getContentSize()

		cell:addTo(layout):posite(cellSize.width / 2, cellSize.height / 2)

		cell.data = v

		layout:setContentSize(cellSize)

		local function callFunc(sender, eventType)
			self:changBtnUp(sender, 0)
		end

		cell:setTag(tonumber(k))
		layout:setTag(tonumber(k))
		mapButtonHandlerClick(nil, cell, {
			func = callFunc
		})
		table.insert(self.btnUpTable, cell)
		self._listViewUp:pushBackCustomItem(layout)
	end

	self._listViewUp:setTouchEnabled(#self.btnUpTable > 4)
	self:changBtnUp(self.btnUpTable[1])
end

function ServerAnnounceMediatorNew:changBtnUp(sender, isDeductTime)
	if not sender then
		return
	end

	for k, cell in pairs(self.btnUpTable) do
		local lbl = cell:getChildByName("btn_up_lbl")

		if cell:getTag() == sender:getTag() then
			cell:setTouchEnabled(false)
			cell:loadTexture("gg_btn_s_xz.png", ccui.TextureResType.plistType)

			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(22, 22, 22, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(88, 88, 88, 255)
				}
			}

			lbl:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
				x = 0,
				y = -1
			}))
			self._listViewCenter:removeAllChildren()
			self._listViewLeft:removeAllChildren()

			if cell.data.type == "system" then
				self._curShowType = "system"

				self:setSystemView()
			elseif cell.data.type == "activity" then
				self._curShowType = "activity"

				self:setActivityView(isDeductTime)
			elseif cell.data.type == "activityPV" then
				self._curShowType = "activityPV"

				if cell.redPoint then
					cell.redPoint:setVisible(false)
				end

				self:setPVView(isDeductTime)
			end
		else
			cell:setTouchEnabled(true)
			cell:loadTexture("gg_btn_s_wxz.png", ccui.TextureResType.plistType)

			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 246, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 246, 255, 255)
				}
			}

			lbl:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
				x = 0,
				y = -1
			}))
		end
	end
end

function ServerAnnounceMediatorNew:onRefreshAnnounceEvent()
	local _data = self._loginSystem:getAnnounceSaveData()

	if _data then
		self.btnLeftTable = {}

		if not _data.data then
			return
		end

		self._listViewLeft:pushBackCustomItem(self:getLeftListCell(_data.data, 1))
		self._listViewCenter:setTouchEnabled(true)
		self._listViewCenter:pushBackCustomItem(self:getCenterType3Cell(_data.data))
	end
end

function ServerAnnounceMediatorNew:removeBtnUp(type)
	for i, v in pairs(self.btnUpTable) do
		if type == v.data.type then
			table.remove(self.btnUpTable, i)
		end
	end
end

function ServerAnnounceMediatorNew:setSystemView()
	if self._loginSystem:getLoginUrl() then
		if self._data.isDeductTime == 1 then
			self:onRefreshAnnounceEvent()
		else
			local params = {}

			self._loginSystem:getAnnounceData(params, function(errorCode, responseData)
				return
			end)
		end
	end
end

function ServerAnnounceMediatorNew:onRefreshPatfaceEvent()
	if self._curShowType == "activity" then
		local response = self._loginSystem:getPatFaceSaveData()

		self._listViewUp:setVisible(true)

		if self.isLogin then
			response = {
				data = {}
			}
		end

		if response then
			table.sort(response, function(a, b)
				return a.priority < b.priority
			end)

			if #response == 0 then
				self._listViewUp:removeChildByTag(1, true)
				self:removeBtnUp("activity")
				self:changBtnUp(self.btnUpTable[1])

				return
			end

			self.btnLeftTable = {}

			for k, v in pairs(response) do
				if not v.redDot then
					local redPointType = redPointType.KOneTimeEveryDay
					local layout = self:getLeftListCell(v.mainbody, k, v, redPointType)

					self._listViewLeft:pushBackCustomItem(layout)
				end
			end

			self:selectLifeCell(1)
		end

		local response = self._loginSystem:getPvSaveData()

		if #response == 0 then
			self._listViewUp:removeChildByTag(2, true)
			self:removeBtnUp("activityPV")
		end
	elseif self._curShowType == "activityPV" then
		self:onRefreshPVEvent()
	end
end

function ServerAnnounceMediatorNew:setActivityView(isDeductTime)
	if self.isLogin then
		self:onRefreshPatfaceEvent()

		return
	end

	if self._data.isDeductTime == 1 then
		self:onRefreshPatfaceEvent()
	else
		local params = {
			isDeductTime = isDeductTime and isDeductTime or self._data.isDeductTime
		}

		self._loginSystem:getPatFaceData(params, function(response)
			return
		end)
	end
end

function ServerAnnounceMediatorNew:addRedPoint(curRedPointType, redPointAnnounceKey, cell, pos)
	pos = pos or {}
	redPointAnnounceKey = tonumber(redPointAnnounceKey) and tonumber(redPointAnnounceKey) or 0

	if curRedPointType == redPointType.KNotShow then
		return
	end

	if curRedPointType == redPointType.KOneTimeEveryDay then
		local curDayTime = TimeUtil:getTimeByDateForTargetTimeInToday({
			sec = 0,
			min = 0,
			hour = 5
		})

		if curDayTime < redPointAnnounceKey then
			return
		end
	end

	if redPointAnnounceKey > 0 and curRedPointType == redPointType.KOneTime then
		return
	end

	local redPoint = RedPoint:createDefaultNode()

	redPoint:addTo(cell):posite(pos.x or 193, pos.y or 72)
	redPoint:setLocalZOrder(99900)

	cell.redPoint = redPoint
end

function ServerAnnounceMediatorNew:getLeftListCell(_data, k, activityData, curRedPointType)
	local layout = ccui.Widget:create()
	local cell = self._btnLeftModel:clone()

	cell:setVisible(true)

	local lbl = cell:getChildByName("btn_left_lbl")

	if _data.tag then
		_data.tag = _data.tag or ""
	end

	lbl:setString(_data.tag)

	if self.playerRid then
		if not cc.UserDefault:getInstance():getStringForKey(self.playerRid .. "redPointAnnounce" .. _data.tag) then
			local redPointAnnounceKey = 0

			if activityData and redPointAnnounceKey ~= 0 and curRedPointType then
				self:addRedPoint(curRedPointType, redPointAnnounceKey, cell)
			end

			local cellSize = cell:getContentSize()

			layout:setContentSize(cc.size(cellSize.width, cellSize.height - 10))
			cell:addTo(layout):posite(cellSize.width / 2, cellSize.height / 2)

			cell.data = activityData and activityData or _data

			local function callFunc(sender, eventType)
				self:changBtnLeft(sender)
			end

			mapButtonHandlerClick(nil, cell, {
				func = callFunc
			})
			cell:setTouchEnabled(activityData ~= nil)
			cell:setTag(tonumber(k))
			table.insert(self.btnLeftTable, cell)

			return layout
		end
	end
end

function ServerAnnounceMediatorNew:getCenterType3Cell(_data)
	local layout = ccui.Widget:create()
	local cell = self._centerType3:clone()
	local title_lbl1 = cell:getChildByName("title_lbl1")

	title_lbl1:setString(_data.title)

	local title_lbl2 = cell:getChildByName("title_lbl2")

	title_lbl2:setString("")

	local announce = _data.content
	local kWidth = cell:getContentSize().width
	local t = TextTemplate:new(announce)
	local params = {
		fontName = TTF_FONT_FZYH_R
	}

	announce = t:stringify(params)

	local contentText = ccui.RichText:createWithXML(announce, {})

	contentText:setAnchorPoint(cc.p(0, 1))
	contentText:renderContent(kWidth, 0)
	contentText:setTouchEnabled(true)

	local size = contentText:getContentSize()
	local height = size.height + 42

	contentText:addTo(cell):posite(title_lbl2:getPosition())
	layout:setContentSize(cc.size(kWidth, height))
	cell:setAnchorPoint(cc.p(0, 1))
	cell:addTo(layout):posite(0, height)
	cell:setVisible(true)
	contentText:setOpenUrlHandler(function(url)
		if url and string.find(url, "http") then
			cc.Application:getInstance():openURL(url)
		end
	end)

	return layout
end

function ServerAnnounceMediatorNew:selectLifeCell(index)
	if #self.btnLeftTable > 0 then
		self:changBtnLeft(self.btnLeftTable[index])
	end
end

function ServerAnnounceMediatorNew:changBtnLeft(sender)
	for k, cell in pairs(self.btnLeftTable) do
		if cell:getTag() == sender:getTag() then
			local data = sender.data

			cell:setTouchEnabled(false)
			cell:loadTexture("gg_btn_z_xz.png", ccui.TextureResType.plistType)

			self.loadTaskTable = {}

			self._listViewCenter:removeAllChildren()
			self:setCenterList(data)

			if cell.redPoint and cell.redPoint:isVisible() then
				cell.redPoint:setVisible(false)

				local curTime = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()

				cc.UserDefault:getInstance():setStringForKey(self.playerRid .. "redPointAnnounce" .. data.mainbody.tag, tostring(curTime))
			end
		else
			cell:setTouchEnabled(true)
			cell:loadTexture("gg_btn_z_wxz.png", ccui.TextureResType.plistType)
		end
	end
end

function ServerAnnounceMediatorNew:setCenterList(data)
	if data.type == 2 then
		self:setCenterType4(data)
	else
		if data.tpl == "1" then
			self:setCenterType1(data)
		elseif data.tpl == "2" then
			self:setCenterType2(data)
		end

		self:announceDownloadImg()
	end
end

function ServerAnnounceMediatorNew:setCenterType1(data)
	self._listViewCenter:setTouchEnabled(false)

	local cell = self._centerType1:clone()
	local btn_img = cell:getChildByName("btn_img")

	btn_img:setVisible(true)
	cell:setVisible(true)

	local function callFunc(sender, eventType)
		self._loginSystem:setIsShowAnnounce(false)

		local url = data.link

		if not url then
			return
		end

		if string.find(url, "http") then
			cc.Application:getInstance():openURL(url)
		else
			local param = {}

			self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
				url = url,
				extParams = param
			}))
		end
	end

	mapButtonHandlerClick(nil, cell, {
		func = callFunc
	})
	self._listViewCenter:pushBackCustomItem(cell)

	local fileUtils = cc.FileUtils:getInstance()

	if not fileUtils:isDirectoryExist(self.relativeFolderPath) then
		fileUtils:createDirectory(self.relativeFolderPath)
	end

	local storagePath = self.relativeFolderPath .. data.mainbody.images[1]

	if fileUtils:isFileExist(storagePath) then
		btn_img:loadTexture(storagePath, ccui.TextureResType.localType)

		return
	end

	local function loadEnd(isSuccess, storagePath)
		if isSuccess and not tolua.isnull(btn_img) and fileUtils:isFileExist(storagePath) then
			btn_img:loadTexture(storagePath, ccui.TextureResType.localType)
		end
	end

	local params = {
		loadEnd = loadEnd,
		urlPath = data.baseUrl .. data.mainbody.images[1]
	}

	self:addDownLoadTask(storagePath, params)
end

function ServerAnnounceMediatorNew:addDownLoadTask(storagePath, params)
	self.loadTaskTable[storagePath] = self.loadTaskTable[storagePath] or {}

	table.insert(self.loadTaskTable[storagePath], params)
end

function ServerAnnounceMediatorNew:setCenterType2(data)
	self._listViewCenter:setTouchEnabled(true)

	local cell = self._centerType2:clone()

	cell:setAnchorPoint(cc.p(0, 1))
	cell:setVisible(true)

	local btn_img = cell:getChildByName("bg_img")

	self._listViewCenter:pushBackCustomItem(cell)

	local titleLabel = cell:getChildByName("title_lbl1")

	titleLabel:setString(data.mainbody.title)

	local descLabel = cell:getChildByName("title_lbl2")

	descLabel:setString("")

	local announce = data.mainbody.content

	if announce then
		local t = TextTemplate:new(announce)
		local params = {
			fontName = TTF_FONT_FZYH_R
		}

		announce = t:stringify(params)

		local richText = ccui.RichText:createWithXML(announce, {})

		richText:setAnchorPoint(descLabel:getAnchorPoint())
		richText:setPosition(cc.p(descLabel:getPosition()))
		richText:addTo(descLabel:getParent())
		richText:renderContent(700, 0, true)
		richText:setTouchEnabled(true)
		richText:setOpenUrlHandler(function(url)
			if url and string.find(url, "http") then
				cc.Application:getInstance():openURL(url)
			end
		end)

		local addHeight = richText:getContentSize().height - richText:getPositionY()

		if self.btnLeftTable[#self.btnLeftTable].data ~= data then
			addHeight = addHeight + 50
		end

		local layout = ccui.Widget:create()

		layout:setContentSize(cc.size(cell:getContentSize().width, addHeight))
		self._listViewCenter:pushBackCustomItem(layout)
	end

	local fileUtils = cc.FileUtils:getInstance()

	if not fileUtils:isDirectoryExist(self.relativeFolderPath) then
		fileUtils:createDirectory(self.relativeFolderPath)
	end

	local storagePath = self.relativeFolderPath .. data.mainbody.images[1]

	if fileUtils:isFileExist(storagePath) then
		btn_img:loadTexture(storagePath, ccui.TextureResType.localType)

		return
	end

	local function loadEnd(isSuccess, storagePath)
		if isSuccess and not tolua.isnull(btn_img) and fileUtils:isFileExist(storagePath) then
			btn_img:loadTexture(storagePath, ccui.TextureResType.localType)
		end
	end

	local params = {
		loadEnd = loadEnd,
		urlPath = data.baseUrl .. data.mainbody.images[1]
	}

	self:addDownLoadTask(storagePath, params)
end

function ServerAnnounceMediatorNew:announceDownloadImg()
	if self._downloader then
		for storagePath, params in pairs(self.loadTaskTable) do
			local function onFileTaskSuccess(task)
				for k, v in pairs(params) do
					if v.loadEnd then
						v.loadEnd(true, storagePath)
					end
				end
			end

			local function onTaskError(task, errorCode, errorCodeInternal, errorStr)
				for k, v in pairs(params) do
					if v.loadEnd then
						v.loadEnd(false)
					end
				end
			end

			local taskInfo = {
				type = "file",
				identifier = storagePath,
				srcUrl = params[1].urlPath,
				storagePath = storagePath,
				onTaskError = onTaskError,
				onFileTaskSuccess = onFileTaskSuccess
			}

			self._downloader:addDownloadTask(taskInfo)
		end
	end
end

function ServerAnnounceMediatorNew:resetData()
	cc.FileUtils:getInstance():removeDirectory(self.relativeFolderPath)
	self._loginSystem:setIsShowAnnounce(false)
end

function ServerAnnounceMediatorNew:onClickClose(sender, eventType)
	self:resetData()
	self:close()
end

function ServerAnnounceMediatorNew:addPVRedPoint(cell)
	local response = self._loginSystem:getPvSaveData()

	if response and #response > 0 then
		local data = response[1]

		if not cc.UserDefault:getInstance():getStringForKey(self.playerRid .. "redPointAnnounce" .. data.mainbody.tag) then
			local redPointAnnounceKey = 0

			if redPointAnnounceKey ~= 0 then
				self:addRedPoint(data.redDot, redPointAnnounceKey, cell, cc.p(123, 33))
			end
		end
	end
end

function ServerAnnounceMediatorNew:setPVView(isDeductTime)
	if self._data.isDeductTime == 1 then
		self:onRefreshPatfaceEvent()
	else
		local params = {
			isDeductTime = isDeductTime and isDeductTime or self._data.isDeductTime
		}

		self._loginSystem:getPatFaceData(params, function(response)
			return
		end)
	end
end

function ServerAnnounceMediatorNew:onRefreshPVEvent()
	local response = self._loginSystem:getPvSaveData()

	if response then
		if #response == 0 then
			self._listViewUp:removeChildByTag(2, true)
			self:removeBtnUp("activityPV")
			self:changBtnUp(self.btnUpTable[1])

			return
		end

		self.btnLeftTable = {}

		self._listViewLeft:removeAllChildren()

		for k, v in pairs(response) do
			if not v.redDot then
				local redPointType = redPointType.KOneTimeEveryDay
				local layout = self:getLeftListCell(v.mainbody, k, v, redPointType)

				self._listViewLeft:pushBackCustomItem(layout)
			end
		end

		self:selectLifeCell(1)
	end
end

function ServerAnnounceMediatorNew:setCenterType4(data)
	self._listViewCenter:setTouchEnabled(false)

	local cell = self._centerType4:clone()

	cell:setVisible(true)
	self._listViewCenter:pushBackCustomItem(cell)

	local title_lbl1 = cell:getChildByName("title_lbl")

	title_lbl1:setString(data.mainbody.title)

	local btn_img = cell:getChildByName("btn_img")

	btn_img:setVisible(true)

	local playBtn = cell:getChildByName("btn_play")

	playBtn:setVisible(false)

	local function callFunc(sender, eventType)
		self:onClickPlayPV(data)
	end

	mapButtonHandlerClick(nil, playBtn, {
		func = callFunc
	})

	local fileUtils = cc.FileUtils:getInstance()

	if not fileUtils:isDirectoryExist(self.pvFolderPath) then
		fileUtils:createDirectory(self.pvFolderPath)
	end

	local storagePath = self.pvFolderPath .. data.mainbody.images[1]

	if fileUtils:isFileExist(storagePath) then
		btn_img:loadTexture(storagePath, ccui.TextureResType.localType)
	end

	local pvPath = self.pvFolderPath .. data.pvvideo

	if fileUtils:isFileExist(pvPath) then
		playBtn:setVisible(true)
	else
		self:pvLoadingText(cell)
	end
end

function ServerAnnounceMediatorNew:onClickPlayPV(data)
	AudioEngine:getInstance():pauseBackgroundMusic()

	local pvPath = self.pvFolderPath .. data.pvvideo

	self._pvPanel:setVisible(true)

	self._videoSprite = VideoSprite.create(pvPath, function(sprite, eventName)
		self:onClickSkip()
	end, nil, true)

	self._pvPanel:addChild(self._videoSprite)
	self._videoSprite:setPosition(cc.p(568, 320))
	self._skipBtn:setVisible(true)

	local size = self._videoSprite:getContentSize()
	local winSize = cc.Director:getInstance():getWinSize()
	local scale = math.max(winSize.height / size.height, winSize.width / size.width)

	self._videoSprite:setScale(scale)
end

function ServerAnnounceMediatorNew:onClickSkip()
	AudioEngine:getInstance():resumeBackgroundMusic()
	self._skipBtn:setVisible(false)
	self._pvPanel:setVisible(false)

	if self._videoSprite then
		self._videoSprite:getPlayer():pause(true)
		self._videoSprite:removeFromParent()

		self._videoSprite = nil
	end
end

function ServerAnnounceMediatorNew:pvLoadingText(cell)
	local text = Strings:get("BoardTitle_Tips", {
		fontName = TTF_FONT_FZYH_M
	})
	local contentText = ccui.RichText:createWithXML(text, {})

	contentText:setAnchorPoint(cc.p(0.5, 0.5))
	contentText:addTo(cell):center(cell:getContentSize())
	contentText:renderContent()

	local width = contentText:getContentSize().width

	contentText:renderContent(width, 0, true)

	function contentText.playTypeWriter(contentText)
		contentText:clipContent(0, 0)

		local count = 0
		local maxCount = contentText:getContentLength()

		local function show()
			if count > maxCount then
				count = 0
			end

			contentText:clipContent(0, count)

			count = count + 1
		end

		local action = cc.DelayTime:create(0.2)
		local action2 = cc.CallFunc:create(show)
		local waitAction = cc.Sequence:create(action, action2)

		contentText:runAction(cc.RepeatForever:create(waitAction))
	end

	contentText:playTypeWriter()
end
