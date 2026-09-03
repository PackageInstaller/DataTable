-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/share/controller/ShareSystem.lua

ShareSystem = class("ShareSystem", Facade, _M)

ShareSystem:has("_shareService", {
	is = "r"
}):injectWith("ShareService")

SHARE_CAPTURE_NAME = "shareCaptureImage.png"
SHARE_CAPTURE_ROTATION_NAME = "shareCaptureRotationImage.png"
SHARE_ICON_NAME = "shareIconImage.png"
ShareEnterType = {
	KBuilding = "Building",
	KHeroHTest = "HeroHTest",
	KRecruitTen = "RecruitTen",
	KGalleryTest = "GalleryTest",
	KGallery = "Gallery",
	KHeroVTest = "HeroVTest",
	KHeroH = "HeroH",
	KRecruitOneHero = "RecruitOneHero",
	KHeroV = "HeroV"
}
ShareStatus = {
	KBegin = "1",
	KFailed = "3",
	KSucceed = "2"
}
ShareStatusString = {
	KBegin = Strings:get("Share_statusBegin"),
	KSucceed = Strings:get("Share_shareSucceed"),
	KFailed = Strings:get("Share_shareFailured")
}
ShareSource = {
	KWeChatZone = "WeChatZone",
	KWeChatFriend = "WeChatFriend",
	KNONE = "NONE"
}
ShareEnterContent = {
	[ShareEnterType.KGallery] = {
		btnScale = 0.7,
		btnPosition = cc.p(1024, 118),
		nodePosition = cc.p(1033, 549),
		adjustType = AdjustUtils.kAdjustType.Right + AdjustUtils.kAdjustType.Bottom
	},
	[ShareEnterType.KRecruitTen] = {
		btnScale = 0.7,
		btnPosition = cc.p(1030, 43),
		nodePosition = cc.p(1031, 86)
	},
	[ShareEnterType.KRecruitOneHero] = {
		btnScale = 0.7,
		btnPosition = cc.p(1001, 43),
		nodePosition = cc.p(1031, 86)
	},
	[ShareEnterType.KBuilding] = {
		btnScale = 0.7,
		textType = 1,
		btnPosition = cc.p(1, 235),
		nodePosition = cc.p(1031, 86),
		adjustType = AdjustUtils.kAdjustType.Left + AdjustUtils.kAdjustType.Bottom
	},
	[ShareEnterType.KHeroH] = {
		btnScale = 1,
		textType = 2,
		btnPosition = cc.p(1030, 100),
		nodePosition = cc.p(1031, 86),
		adjustType = AdjustUtils.kAdjustType.Right + AdjustUtils.kAdjustType.Bottom
	},
	[ShareEnterType.KHeroV] = {
		textType = 3,
		btnScale = 1,
		rotation = -90,
		btnPosition = cc.p(1035, 536),
		nodePosition = cc.p(1051, 535),
		adjustType = AdjustUtils.kAdjustType.Right + AdjustUtils.kAdjustType.Top
	},
	[ShareEnterType.KGalleryTest] = {
		test = true,
		btnScale = 0.7,
		btnPosition = cc.p(824, 118),
		nodePosition = cc.p(833, 549),
		adjustType = AdjustUtils.kAdjustType.Right + AdjustUtils.kAdjustType.Bottom
	},
	[ShareEnterType.KHeroHTest] = {
		test = true,
		btnScale = 1,
		textType = 2,
		btnPosition = cc.p(830, 100),
		nodePosition = cc.p(1031, 86),
		adjustType = AdjustUtils.kAdjustType.Right + AdjustUtils.kAdjustType.Bottom
	},
	[ShareEnterType.KHeroVTest] = {
		test = true,
		btnScale = 1,
		textType = 3,
		rotation = -90,
		btnPosition = cc.p(1035, 336),
		nodePosition = cc.p(1051, 535),
		adjustType = AdjustUtils.kAdjustType.Right + AdjustUtils.kAdjustType.Top
	}
}

function ShareSystem:initialize()
	super.initialize(self)
end

function ShareSystem:userInject(injector)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SHARE, self, self.onShareSdk)
end

function ShareSystem:onShareSdk(event)
	if event and event:getData() then
		local errorCode = event:getData().errorCode
		local message = event:getData().message
		local shareSource = ShareSource.KNONE

		if message and message.activityType then
			shareSource = message.activityType
		end

		if errorCode == "shareFailure" then
			self:requestShareLog(self._shareData.enterType, shareSource, ShareStatus.KFailed)
		elseif errorCode == "shareSuccess" then
			self:requestShareLog(self._shareData.enterType, shareSource, ShareStatus.KSucceed)
		elseif errorCode == "shareCancel" then
			self:requestShareLog(self._shareData.enterType, shareSource, ShareStatus.KFailed)
		end
	end

	self:stopTimer()
end

function ShareSystem:addShare(data, isTrigger)
	if not CommonUtils.GetSwitch("fn_share") then
		return
	end

	local resPath = "asset/ui/ShareBtn.csb"
	local shareNode = cc.CSLoader:createNode(resPath)

	shareNode:addTo(data.node):setName("shareNode" .. data.enterType)

	local config = ShareEnterContent[data.enterType]

	if not config.btnPosition then
		local btnPosition = cc.p(0, 0)

		shareNode:setPosition(config.btnPosition)

		if config.adjustType then
			AdjustUtils.adjustLayoutByType(shareNode, config.adjustType)
		end

		if config.rotation then
			shareNode:setRotation(config.rotation)
		end

		if config.btnScale then
			shareNode:getChildByName("btnImg"):setScale(config.btnScale)
		end

		local function shareCallFunc()
			self:stopTimer()

			self._shareData = data

			self:addCaptureView(data)
			shareNode:removeFromParent()

			local feedsContext = ConfigReader:getRecordById("ConfigValue", "FeedsContext").content
			local title = Strings:get(feedsContext.title)
			local context = Strings:get(feedsContext.context)
			local icon = feedsContext.icon
			local channelId = SDKHelper:getChannelID()

			if not icon[channelId] then
				local shareIcon = icon.normal

				shareIcon = icon[channelId] .. ".png"

				local feedsUrl = ConfigReader:getRecordById("ConfigValue", "FeedsUrl").content

				if not feedsUrl[channelId] then
					if not SDKHelper:isEnableSdk() and device.platform == "android" then
						return
					end

					if config.test then
						self:captureTestCallback(title, context, feedsUrl[channelId], icon[channelId])
					else
						self:captureCallback(data)
					end
				end
			end
		end

		mapButtonHandlerClick(nil, shareNode:getChildByName("shareBtn"), {
			func = shareCallFunc
		})

		if isTrigger then
			shareCallFunc()
		end
	end
end

function ShareSystem:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end
end

function ShareSystem:captureCallback(data)
	self:onCaptured(data, function(savePath, saveFileName)
		self:removeCapturedView(data)
		self:addRotationImage(data, saveFileName, function(fileName)
			local function checkTimeFunc()
				local fileUtils = cc.FileUtils:getInstance()

				if fileUtils:isFileExist(fileName) then
					self:stopTimer()

					local imageView = ccui.ImageView:create(fileName, ccui.TextureResType.localType)

					imageView:setPosition(cc.p(200, 200))
					imageView:setScale(0.5)

					local sendData = {
						imagePath = fileName
					}

					SDKHelper:systemShare(sendData)
				end
			end

			self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 0, false)
		end)
	end)
end

function ShareSystem:captureTestCallback(title, context, shareUrl, shareIcon)
	local sendData = {}

	if device.platform == "android" then
		sendData = {
			title = title,
			content = context,
			shareUrl = shareUrl
		}

		SDKHelper:systemShare(sendData)
	else
		self:addIconImage(shareIcon, function(fileName)
			sendData = {
				title = title,
				content = context,
				imagePath = fileName,
				shareUrl = shareUrl
			}

			SDKHelper:systemShare(sendData)
		end)
	end
end

function ShareSystem:addIconImage(shareIcon, callback)
	local imageView = ccui.ImageView:create(shareIcon, ccui.TextureResType.plistType)
	local size = imageView:getContentSize()

	imageView:setPosition(cc.p(size.width / 2, size.height / 2))

	local fileName = SHARE_ICON_NAME
	local callback = function(saveFileName)
		callback(saveFileName)
	end
	local d = {
		node = imageView,
		fileName = fileName,
		size = size,
		callback = callback
	}

	CommonUtils.renderTexture(d)
end

function ShareSystem:addRotationImage(data, saveFileName, callback)
	local config = ShareEnterContent[data.enterType]

	if config.rotation then
		local fileUtils = cc.FileUtils:getInstance()

		if fileUtils:isFileExist(saveFileName) then
			local imageView = ccui.ImageView:create(saveFileName, ccui.TextureResType.localType)
			local size = imageView:getContentSize()

			imageView:setRotation(math.abs(config.rotation))
			imageView:setAnchorPoint(0.5, 0.5)
			imageView:setPosition(cc.p(size.height / 2, size.width / 2))

			local d = {
				node = imageView,
				fileName = SHARE_CAPTURE_ROTATION_NAME,
				size = cc.size(size.height, size.width),
				callback = callback
			}

			CommonUtils.renderTexture(d)
		end
	else
		callback(saveFileName)
	end
end

function ShareSystem:setShareVisible(data)
	local node = data.node:getChildByFullName("shareNode" .. data.enterType)

	if node and not DisposableObject:isDisposed(node) then
		node:setVisible(data.status)
	end
end

function ShareSystem:addCaptureView(data)
	if data.preConfig then
		data.preConfig()
	end

	local view = self:getInjector():getInstance("ShareView")

	if view then
		view:addTo(data.node)
		AdjustUtils.adjustLayoutUIByRootNode(view)
		view:setPosition(0, 0)

		local gameContext = self:getInjector():getInstance("GameContext")
		local mediatorMap = gameContext:getMediatorMap()
		local mediator = mediatorMap:retrieveMediator(view)

		if mediator then
			view.mediator = mediator

			mediator:enterWithData(data)
		end

		self._shareView = view
	end
end

function ShareSystem:removeCapturedView(data)
	if data.endConfig then
		data.endConfig()
	end

	if self._shareView and self._shareView.mediator and not DisposableObject:isDisposed(self._shareView.mediator) then
		self._shareView:removeFromParent(true)

		self._shareView = nil
	end

	self:addShare(data)
end

function ShareSystem:onCaptured(data, callback)
	local d = {}

	table.copy(data, d)

	d.fileName = data.fileName or SHARE_CAPTURE_NAME
	d.callback = callback

	CommonUtils.captureNodeSystem(d)
end

function ShareSystem:onCaptureScreen(data, callback)
	local d = {}

	table.copy(data, d)

	d.fileName = data.fileName or SHARE_CAPTURE_NAME
	d.callback = callback

	CommonUtils.captureScreen(d)
end

function ShareSystem:showWaitingAnim(data, imageView, saveFileName)
	local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
	local topView = scene:getTopView()
	local topName = scene:getTopViewName()

	if topView then
		local fileUtils = cc.FileUtils:getInstance()
		local writablePath = fileUtils:getWritablePath()
		local isFileExistWritablePath = fileUtils:isFileExist(saveFileName)

		if isFileExistWritablePath then
			local imageView = ccui.ImageView:create(saveFileName, ccui.TextureResType.localType)

			imageView:addTo(topView)
			imageView:setScale(0.5)

			local winSize = cc.Director:getInstance():getWinSize()

			imageView:setPosition(cc.p(winSize.width / 2, winSize.height / 2))
		end
	end
end

function ShareSystem:requestShareLog(shareId, shareContentId, res, tipStr, callback)
	local params = {}

	params.shareId = shareId
	params.shareContentId = shareContentId
	params.res = res

	self._shareService:requestShareLog(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if tipStr then
				self:dispatch(ShowTipEvent({
					duration = 0.2,
					tip = tipStr
				}))
			end

			if callback then
				callback(response)
			end
		end
	end)
end
