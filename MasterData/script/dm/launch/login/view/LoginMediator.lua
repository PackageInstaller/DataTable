-- chunkname: @/tmp/or_script/lua_compile/dm/launch/login/view/LoginMediator.lua

local cjson = require("cjson.safe")

LoginMediator = class("LoginMediator", DmAreaViewMediator, _M)

LoginMediator:has("_loginSystem", {
	is = "r"
}):injectWith("LoginSystem")

local kBtnHandlers = {
	["main.btnPanel.announceBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickAnnounce"
	},
	["main.ageBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickAge"
	},
	["main.btnPanel.reloginBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickReboot"
	},
	["main.btnPanel.bugFeedback"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickBugFeedback"
	},
	["main.PrivacyPanel.Layout.CheckBox"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onCheckBoxCilck"
	},
	["main.PrivacyPanel.Layout.ReadyBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onReadyPrivacy"
	},
	["main.PrivacyPanel.Layout.UserBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onUserPrivacy"
	},
	["main.server.regionBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onSelectRegionClick"
	},
	["main.server.regionPanel.touchRegion_NA"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onSetRegion"
	},
	["main.server.regionPanel.touchRegion_EU"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onSetRegion"
	},
	["main.server.regionPanel.touchRegion_AS"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onSetRegion"
	}
}

function LoginMediator:initialize()
	super.initialize(self)
end

function LoginMediator:dispose()
	super.dispose(self)
end

function LoginMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_LOGIN, self, self.onSdkLogin)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SWITCH_ACCOUNT, self, self.onSdkLogin)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_LOGIN_REFRESH_SERVER, self, self.refreshServerPanel)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REQUEST_LOGIN_SUCC, self, self.loginSucc)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_LOGIN_ONQUEUE, self, self.showQueue)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_LOGIN_CANCEL_QUEUE, self, self.cancelQueue)
end

function LoginMediator:enterWithData(data)
	self:initMainUI()
	self:initAnim()
	self:animOver()
	AudioEngine:getInstance():playBackgroundMusic("Mus_Login_Scene")
	self:dispatch(Event:new(EVT_ENTER_LAUNCH_SCENE))
	cc.UserDefault:getInstance():setStringForKey("PV_FLASH_GUIDE_BATTLE", "true")

	local content = {
		point = "login_enter_login_view",
		type = "loginflow"
	}

	StatisticSystem:send(content)
	self._privacyPanel:setVisible(true)
end

function LoginMediator:animOver()
	local voiceMap = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Launch_Hero_Soud", "content")
	local randomTag = math.random(#voiceMap)

	dmAudio.play(voiceMap[randomTag], {}, nil, 2)

	if not GameConfigs.disabledSDKLogin then
		local function callback()
			if DisposableObject:isDisposed(self) then
				return
			end

			self._loginBtn:setTouchEnabled(true)

			if SDKHelper:isEnableSdk() then
				local content = {
					point = "login_sdk_login",
					type = "loginflow"
				}

				StatisticSystem:send(content)
				SDKHelper:login()
			elseif device.platform == "ios" then
				local account = self:getDefaultRid()

				if not account or #account <= 0 then
					self._loginSystem:iOSAccount(self._globalUrl, function(errorCode, response)
						account = response.data

						if account and #account > 0 then
							self._textField:setText(account)
							self:setDefaultRid(account)
						else
							self:dispatch(ShowTipEvent({
								tip = "get InvitationCode fail"
							}))
						end
					end)
				end
			end
		end

		if GameConfigs.globalSever then
			self._globalUrl = CommonUtils.GetGlobalServer()

			callback()
		else
			self:vmsRequest(callback)
		end
	else
		self._loginBtn:setTouchEnabled(true)
	end
end

function LoginMediator:initMainUI()
	local mainlayer = self:getView():getChildByFullName("main")
	local privacyPanel = mainlayer:getChildByFullName("PrivacyPanel")

	self._loginBtn = mainlayer:getChildByFullName("login_btn")

	self._loginBtn:addTouchEventListener(function(sender, eventType)
		self:loginClick(sender, eventType)
	end)
	self._loginBtn:setTouchEnabled(false)

	self._accountStr = ""

	self:setAccountPanel()

	if SDKHelper:isEnableSdk() then
		self._accountPanel:setVisible(false)
	end

	self._test_btn = mainlayer:getChildByFullName("test_btn")

	if self._test_btn then
		self._test_btn:setOpacity(50)
		self._test_btn:setVisible(DEBUG ~= 0 or app.pkgConfig.showDebugBox == 1)
		self._test_btn:addClickEventListener(function()
			local view = self:getInjector():getInstance("TestView")
			local event = ViewEvent:new(EVT_SHOW_POPUP, view)

			self:dispatch(event)
		end)
	end

	self._announceBtn = mainlayer:getChildByFullName("btnPanel.announceBtn")

	self._announceBtn:setVisible(false)
	self._announceBtn:getChildByFullName("text"):enableOutline(cc.c4b(47, 47, 47, 204), 2)

	self._reloginBtn = mainlayer:getChildByFullName("btnPanel.reloginBtn")

	self._reloginBtn:setVisible(false)
	self._reloginBtn:getChildByFullName("text"):enableOutline(cc.c4b(47, 47, 47, 204), 2)

	self._bugFeedback = mainlayer:getChildByFullName("btnPanel.bugFeedback")

	self._bugFeedback:setVisible(false)

	self._ageBtn = mainlayer:getChildByFullName("ageBtn")
	self._logo = mainlayer:getChildByFullName("logo")

	self._logo:setVisible(false)

	local version = mainlayer:getChildByFullName("version")
	local curVersion = app:getAssetsManager():getCurrentVersion()

	if curVersion == 0 then
		curVersion = "dev"
	end

	local versionStr = "(" .. curVersion .. ")"
	local baseVersion = app.pkgConfig.packJobId

	if baseVersion then
		versionStr = baseVersion .. versionStr
	end

	version:setString(Strings:get("Setting_Text10", {
		num = versionStr
	}))

	local noticeNode = mainlayer:getChildByFullName("Node_notice")
	local textLink = noticeNode:getChildByFullName("Text_warm_tipslink")
	local contentsData = Strings:get("CopyrightInfo7")
	local label = ccui.RichText:createWithXML(contentsData, {})
	local x = textLink:getContentSize().width

	label:setAnchorPoint(cc.p(0, 0))
	label:renderContent()
	label:setContentSize(textLink:getContentSize())
	label:addTo(textLink):offset(-200, -8)
	label:setTouchEnabled(true)
	textLink:setString("")
	label:setOpenUrlHandler(function(url)
		cc.Application:getInstance():openURL(url)
	end)
	self:getView():getChildByFullName("main.Node_notice"):setVisible(true)
	self:initPrivacy()
end

function LoginMediator:initPrivacy()
	local mainlayer = self:getView():getChildByFullName("main")

	self._privacyPanel = mainlayer:getChildByFullName("PrivacyPanel")

	local layout = self._privacyPanel:getChildByFullName("Layout")
	local privacyText1 = layout:getChildByFullName("Text1")
	local privacyText2 = layout:getChildByFullName("Text2")
	local privacyText3 = layout:getChildByFullName("Text3")
	local readyBtn = layout:getChildByFullName("ReadyBtn")
	local userBtn = layout:getChildByFullName("UserBtn")
	local layoutSize = layout:getContentSize()

	self._checkBox = layout:getChildByFullName("CheckBox.CheckIcon")

	privacyText2:setPositionX(privacyText1:getPositionX() + privacyText1:getContentSize().width + 5)
	readyBtn:setContentSize(privacyText2:getContentSize())
	readyBtn:setPosition(privacyText2:getPosition())

	layoutSize.width = 40 + privacyText1:getContentSize().width + privacyText2:getContentSize().width

	layout:setContentSize(layoutSize)
	layout:center(layout:getParent():getContentSize())
	privacyText3:setPositionX(privacyText2:getPositionX() + privacyText2:getContentSize().width + 5)
	userBtn:setContentSize(privacyText3:getContentSize())
	userBtn:setPosition(privacyText3:getPosition())

	layoutSize.width = 40 + privacyText1:getContentSize().width + privacyText2:getContentSize().width + privacyText3:getContentSize().width

	layout:setContentSize(layoutSize)
	layout:center(layout:getParent():getContentSize())

	local value = cc.UserDefault:getInstance():getBoolForKey("loginAgreement")

	self._checkBox:setVisible(value)
	self._privacyPanel:setVisible(false)
end

function LoginMediator:getDefaultRid()
	return GameConfigs.rid or cc.UserDefault:getInstance():getStringForKey("default_rid")
end

function LoginMediator:setDefaultRid(id)
	cc.UserDefault:getInstance():setStringForKey("default_rid", id)
	cc.UserDefault:getInstance():flush()
end

function LoginMediator:setAccountPanel()
	self._accountPanel = self:getView():getChildByFullName("main.account")

	self._accountPanel:setVisible(true)

	if getCurrentLanguage() ~= GameLanguageType.CN then
		local TextField = self._accountPanel:getChildByFullName("account.TextField")

		TextField:setContentSize(cc.size(182.43, 36))

		local Text_1 = self._accountPanel:getChildByFullName("account.Text_1")

		Text_1:setPositionY(20)
	end

	local textField = convertTextFieldToEditBox(self._accountPanel:getChildByFullName("account.TextField"), true, MaskWordType.NAME)

	textField:setText(self:getDefaultRid())
	textField:setPlaceHolder(Strings:get("Login_EnterCode"))
	textField:setPlaceholderFontColor(cc.c3b(255, 255, 255))

	self._textField = textField
	self._serverPanel = self:getView():getChildByFullName("main.server")

	self._serverPanel:setVisible(false)

	self._serverStringTip = self._serverPanel:getChildByName("Text_2")
	self._regionPanel = self:getView():getChildByFullName("main.server.regionPanel")

	self._regionPanel:setVisible(false)

	self._regionBtn = self:getView():getChildByFullName("main.server.regionBtn")

	self._regionBtn:setVisible(false)

	self._localRegionSet = self._regionBtn:getChildByName("text")

	local serverDi = self._serverPanel:getChildByName("Image_server")

	self._serverText = self._serverPanel:getChildByName("Text_server")
	self._imageHot = self._serverPanel:getChildByName("imageHot")

	serverDi:setTouchEnabled(false)
	self._serverPanel:setTouchEnabled(true)
	self._serverPanel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Open_2", false)

			local view = self:getInjector():getInstance("LoginServerView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}))
		end
	end)
end

function LoginMediator:refreshServerPanel()
	self._serverData = self._loginSystem:getCurServer()

	self._serverText:setString(self._serverData:getName())
	self._imageHot:loadTexture(ServerStateImgNames[self._serverData:getState()], 1)
end

function LoginMediator:onSdkLogin(event)
	local data = event:getData()

	if data and (data.errorCode == "loginSuccess" or data.errorCode == "switchAccountSuccess") then
		self:onGlobalLogin(data.errorCode, data.message, "")
	elseif SDKHelper and SDKHelper:isEnableSdk() then
		SDKHelper:reportLoginError({
			errorCode = "errorCode"
		})
	end
end

function LoginMediator:onGlobalLogin(errorCode, message, sdkId)
	if self._globalUrl ~= nil then
		local content = {
			point = "login_request_global_server",
			type = "loginflow"
		}

		StatisticSystem:send(content)

		if SDKHelper and SDKHelper:isEnableSdk() then
			SDKHelper:reportByServerList("gameGetServerListBegin", self._globalUrl)
		end

		self._loginSystem:requestLogin(self._globalUrl, SDKHelper:getGlobalData(sdkId))
	else
		self:dispatch(ShowTipEvent({
			tip = "global url is nil"
		}))
	end
end

function LoginMediator:vmsRequest(callback)
	local curVersion = app:getAssetsManager():getLatestVersion()

	if not curVersion or curVersion == -1 then
		curVersion = "dev"
	end

	local content = {
		point = "login_get_global_url",
		type = "loginflow"
	}

	StatisticSystem:send(content)
	self._loginSystem:vmsRequest((app.pkgConfig and app.pkgConfig.captainUrl and app.pkgConfig.captainUrl ~= "" or nil) and app.pkgConfig.captainUrl, curVersion, function(vmsErrorCode, vmsResponse)
		if vmsErrorCode == 200 and vmsResponse.data and vmsResponse.data.webApiRoot and vmsResponse.data.webApiRoot ~= "" then
			self._globalUrl = CommonUtils.GetGlobalServer()

			if vmsResponse.data.targetV then
				self._targetV = tonumber(vmsResponse.data.targetV)
			end

			callback()
		end

		if LOGIN_DEBUG then
			dump(vmsErrorCode, "vms errorCode:")
			dump(vmsResponse, "vms response:")
		end
	end)
end

function LoginMediator:loginSucc()
	local serverList = self._loginSystem:getServerList()

	if #serverList < 1 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("LOG_NO_SERVERLIST")
		}))

		return
	end

	self._loginBtn:addTouchEventListener(function(sender, eventType)
		self:enterGameClick(sender, eventType)
	end)
	self._accountPanel:setVisible(false)
	self._serverPanel:setVisible(true)
	self:refreshServerPanel()

	if device.platform == "ios" then
		self._reloginBtn:setVisible(true)
	end

	if not app.pkgConfig.packJobId then
		local baseVersion = 1

		if tonumber(baseVersion) > 14430 and self._loginSystem:getZhengeSdkId() == "6" then
			self._reloginBtn:getChildByFullName("text"):setString("帐户注销")
			self._reloginBtn:setVisible(true)
		end

		self._announceBtn:setVisible(true)

		if tonumber(baseVersion) > 14430 and self._loginSystem:getZhengeSdkId() == "5" then
			self._bugFeedback:setVisible(true)
		end

		local serverNum = self:getGlobalServerNum()

		self._regionBtn:setVisible(serverNum > 1)
		self._serverStringTip:setVisible(serverNum <= 1)

		if serverNum > 1 then
			local localRegion = CommonUtils.GetServerRegion()

			self._localRegionSet:setString(Strings:get("server_region_" .. localRegion:lower()))
		end
	end
end

function LoginMediator:showQueue(event)
	if self._isQueue then
		return
	end

	local queueData = event:getData()

	if queueData and queueData.full then
		-- block empty
	end

	self._isQueue = true

	local view = self:getInjector():getInstance("loginQueueView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		data = queueData
	}, nil))

	local netClient = self:getInjector():getInstance("GameServerAgent")
	local waitingHandler = netClient:getWaitingHandler()

	waitingHandler:handleWaitingEvent(WaitingEvent.kConnectSucc)
end

function LoginMediator:cancelQueue()
	if self._isQueue then
		local netClient = self:getInjector():getInstance("GameServerAgent")

		if netClient and netClient:getClient() then
			netClient:getClient():close()
		end

		self._isQueue = false
	end
end

function LoginMediator:showQueue(event)
	if self._isQueue then
		return
	end

	local queueData = event:getData()

	if queueData and queueData.full then
		-- block empty
	end

	self._isQueue = true

	local view = self:getInjector():getInstance("loginQueueView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		data = queueData
	}, nil))

	local netClient = self:getInjector():getInstance("GameServerAgent")
	local waitingHandler = netClient:getWaitingHandler()

	waitingHandler:handleWaitingEvent(WaitingEvent.kConnectSucc)
end

function LoginMediator:cancelQueue()
	if self._isQueue then
		local netClient = self:getInjector():getInstance("GameServerAgent")

		if netClient and netClient:getClient() then
			netClient:getClient():close()
		end

		self._isQueue = false
	end
end

function LoginMediator:sdkLogin()
	local content = {
		point = "login_sdk_login",
		type = "loginflow"
	}

	StatisticSystem:send(content)
	SDKHelper:login()
end

function LoginMediator:login()
	local value = cc.UserDefault:getInstance():getBoolForKey("loginAgreement")

	if not value then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Privacy_Tip_Text")
		}))

		return
	end

	if SDKHelper:isEnableSdk() then
		self:sdkLogin()

		return
	end

	self._accountStr = GameConfigs.rid or self._textField:getText()

	if self._accountStr == "" then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("LOGIN_UI7")
		}))

		return
	end

	if not self:checkAccountStr() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("LOGIN_UI8")
		}))

		return
	end

	if GameConfigs.disabledSDKLogin then
		local globalServer = CommonUtils.GetGlobalServer(self._globalUrl)

		if globalServer then
			self._loginSystem:requestLogin(globalServer, SDKHelper:getGlobalData(self._accountStr or ""))
		else
			self._accountPanel:setVisible(false)
			self._serverPanel:setVisible(true)
			self._loginBtn:addTouchEventListener(function(sender, eventType)
				self:enterGameClick(sender, eventType)
			end)

			local data = {
				sec_list = TEST_SERVER,
				uid = self._accountStr
			}

			self._loginSystem:getLogin():sync(data)
			self:refreshServerPanel()
		end
	else
		if IS_FORCE_UPDATE then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("FORCE_UPDATE")
			}))

			return
		end

		self:onGlobalLogin("loginSuccess", "", self._accountStr or "")
	end

	self:setDefaultRid(self._accountStr)
end

function LoginMediator:loginClick(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)
		self:login()
	end
end

function LoginMediator:checkAccountStr()
	return string.match(self._accountStr, "%w+") == self._accountStr
end

function LoginMediator:enterGameClick(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._checkBox and not self._checkBox:isVisible() then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Privacy_Tip_Text")
			}))

			return
		end

		AudioEngine:getInstance():playEffect("Se_Click_Login", false)

		if IS_FORCE_UPDATE then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("FORCE_UPDATE")
			}))

			return
		end

		if GameConfigs.disabledSDKLogin then
			local rid = self._accountStr .. "_" .. (self._serverData:getSecId() or "1")

			self._loginSystem:setPlayerRid(rid)
			self:connectGameServer()
		else
			local version = app:getAssetsManager():getCurrentVersion()

			if not self._targetV then
				if self._targetV ~= ((GameConfigs.globalSever or nil) and self._targetV) then
					REBOOT()

					return
				end

				local uid = self._loginSystem:getUid()
				local sec = self._serverData:getSecId()
				local rid = tostring(uid) .. "_" .. tostring(sec)

				self._loginSystem:setPlayerRid(rid)
				self:connectGameServer()
			end
		end
	end
end

function LoginMediator:connectGameServer()
	local content = {
		point = "login_connect_game_server",
		type = "loginflow"
	}

	StatisticSystem:send(content)

	if device.platform ~= "mac" and device.platform ~= "windows" then
		local pid = self._loginSystem:getPlayerRid()

		dpsBugTracer.setUserId(pid)
		cc.UserDefault:getInstance():setStringForKey("playerRid", tostring(pid))
	end

	local netClient = self:getInjector():getInstance("GameServerAgent")

	if netClient and netClient:getClient() then
		netClient:getClient():close()
	end

	local injector = self:getInjector()
	local gameContext = injector:getInstance("GameContext")

	gameContext:loadModuleByName("beforeLoading")
	gameContext:loadModuleByName("gameplay")

	local connected = netClient:connect(self._serverData:getIp(), self._serverData:getPort(), function()
		local content = {
			point = "login_request_player_info",
			type = "loginflow"
		}

		StatisticSystem:send(content)
		self._loginSystem:requestPlayerInfo(function()
			self:beforeLoading()
		end)
	end)

	if not connected then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("LOGIN_CONNECT_FAIL")
		}))
	end
end

function LoginMediator:beforeLoading()
	local actionPanel = self:getView():getChildByName("actionPanel")

	actionPanel:setLocalZOrder(100)
	actionPanel:getChildByFullName("LoginBtnAnim"):setVisible(false)

	if self._whaleAnim then
		self._whaleAnim:gotoAndPlay(0)
	end

	self._bgAnim:gotoAndPlay(91)
	self._bgAnim:addCallbackAtFrame(113, function()
		self:launchLoading()
	end)
	self._bgAnim:addEndCallback(function()
		self._bgAnim:stop()
	end)
end

function LoginMediator:launchLoading()
	local function onCompleted()
		local settingSystem = self:getInjector():getInstance(SettingSystem)

		settingSystem:downloadPackage(function()
			self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, "mainScene"))
		end)
	end

	local widget = EnterGameLoadingWidget
	local var_40_0 = self:getInjector():getInstance("loadingView")
	local var_40_1 = {
		hideAnim = true,
		loadingTask = self:buildLoadingTask()
	}

	var_40_1.loadingWidget = self:getInjector():injectInto(widget:new())
	var_40_1.onCompleted = onCompleted
	var_40_1.bgAnim = self._bgAnim

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, var_40_1))
end

function LoginMediator:buildLoadingTask()
	resData = resData or {}

	local taskBuilder = timesharding.TaskBuilder:new()
	local task = taskBuilder:buildParalelTask(function()
		SEQUENCE(30)
		DO_ACTION(function()
			if SDKHelper:isEnableSdk() then
				local developSystem = self:getInjector():getInstance(DevelopSystem)
				local curServer = self._loginSystem:getCurServer()
				local player = developSystem:getPlayer()
				local clubSystem = self:getInjector():getInstance(ClubSystem)
				local params = {
					serverId = tostring(curServer:getSecId()),
					serverName = tostring(curServer:getName()),
					createTime = tostring(player:getCreateTime()),
					roleName = tostring(player:getNickName()),
					roleId = tostring(player:getRid()),
					vipLevel = tostring(player:getVipLevel()),
					roleLevel = tostring(player:getLevel()),
					roleCombat = tostring(developSystem:getCombat()),
					ip = tostring(self._serverData:getIp()),
					port = tostring(self._serverData:getPort())
				}

				if clubSystem:getHasJoinClub() then
					params.clubId = tostring(clubSystem:getClubId())
					params.clubName = tostring(clubSystem:getName())
					params.clubTitle = tostring(clubSystem:getPositionName())
					params.clubLevel = tostring(clubSystem:getLevel())
				end

				SDKHelper:reportLogin(params)
			end
		end, 1)
		DO_ACTION(function()
			local pushSystem = self:getInjector():getInstance(PushSystem)

			pushSystem:listenBeforeLogin()
		end, 1)
		DO_ACTION(function()
			if SDKHelper:isEnableSdk() then
				local payOffSystem = self:getInjector():getInstance(PayOffSystem)

				payOffSystem:payInit()
			end
		end, 1)
		DO_ACTION(function()
			local injector = self:getInjector()
			local gameContext = injector:getInstance("GameContext")

			gameContext:loadModuleByName("battle")
		end, 1)
		ADD_TASK(1, timesharding.CustomTask:new(function(task)
			local mcLibrary = cc.MCLibrary:getInstance()

			mcLibrary:loadDefinitionsFromFile("asset/anim/zhuxianhuo.mclib", 1)
			mcLibrary:loadDefinitionsFromFile("asset/anim/zhuxianyun.mclib", 1)

			local textureCache = cc.Director:getInstance():getTextureCache()

			textureCache:addImage("asset/anim/zhuxianyunimage.png")
			textureCache:addImage("asset/anim/zhuxianhuoimage.png")

			local spriteFrameCache = cc.SpriteFrameCache:getInstance()

			spriteFrameCache:addSpriteFrames("asset/anim/zhuxianyunimage.plist")
			spriteFrameCache:addSpriteFrames("asset/anim/zhuxianhuoimage.plist")
			delayCallByTime(1000, function()
				task:finish()
			end)
		end))
		ADD_TASK(1, timesharding.CustomTask:new(function(task)
			local mailSystem = self:getInjector():getInstance(MailSystem)

			mailSystem:requestUnreadMailCnt(false, function()
				task:finish()
			end)
		end))
		ADD_TASK(1, timesharding.CustomTask:new(function(task)
			local friendSystem = self:getInjector():getInstance(FriendSystem)

			friendSystem:requestFriendsMainInfo(function()
				task:finish()
			end)
		end))
		ADD_TASK(1, timesharding.CustomTask:new(function(task)
			local petRaceSystem = self:getInjector():getInstance(PetRaceSystem)

			petRaceSystem:requestData(function()
				task:finish()
			end, true)
		end))
		ADD_TASK(1, timesharding.CustomTask:new(function(task)
			local taskSystem = self:getInjector():getInstance(TaskSystem)
			local params = {
				taskType = {
					TaskType.kDaily,
					TaskType.kBranch,
					TaskType.kStage,
					TaskType.kStageArena
				}
			}

			taskSystem:requestTaskList(params, function()
				task:finish()
			end)
		end))
		ADD_TASK(1, timesharding.CustomTask:new(function(task)
			local maskWordSystem = self:getInjector():getInstance(MaskWordSystem)

			maskWordSystem:requestMaskWord(function()
				task:finish()
			end, true)
		end))
		ADD_TASK(1, timesharding.CustomTask:new(function(task)
			self._loginSystem:getPatFaceDataToSave(function()
				task:finish()
			end, true)
		end))

		if self._loginSystem:getLoginUrl() then
			ADD_TASK(1, timesharding.CustomTask:new(function(task)
				self._loginSystem:getAnnounceDataToSave(function()
					task:finish()
				end, true)
			end))
		end

		ADD_TASK(1, timesharding.CustomTask:new(function(task)
			BattleLoader:preloadBattleCache()
			BattleLoader:preloadBattleDataConfig()
			delayCallByTime(1000, function()
				task:finish()
			end)
		end))
		DO_ACTION(function()
			local settingSystem = self:getInjector():getInstance(SettingSystem)

			settingSystem:autoDownloadPackage()
		end, 1)
		DO_ACTION(function()
			local systemKeeper = self:getInjector():getInstance("SystemKeeper")
			local unlock, tips = systemKeeper:isUnlock("RTPK")

			if unlock then
				local RTPKSystem = self:getInjector():getInstance(RTPKSystem)

				RTPKSystem:requestRTPKInfo(nil, false)
			end
		end, 1)
		DO_ACTION(function()
			local systemKeeper = self:getInjector():getInstance("SystemKeeper")
			local unlock, tips = systemKeeper:isUnlock("StageArena")

			if unlock then
				local leadStageSystem = self:getInjector():getInstance(LeadStageArenaSystem)

				leadStageSystem:requestGetSeasonInfo(nil, false)
			end
		end, 1)
		DO_ACTION(function()
			local systemKeeper = self:getInjector():getInstance("SystemKeeper")
			local unlock, tips = systemKeeper:isUnlock("ChessArena_System")

			if unlock then
				local arenaSystem = self:getInjector():getInstance(ArenaNewSystem)

				arenaSystem:requestGainChessArena(nil, false)
			end
		end, 1)
		DO_ACTION(function()
			local systemKeeper = self:getInjector():getInstance("SystemKeeper")
			local unlock, tips = systemKeeper:isUnlock("ChessArena_System")

			if unlock then
				local arenaSystem = self:getInjector():getInstance(ArenaNewSystem)

				arenaSystem:requestOfflineReport()
			end
		end, 1)
		DO_ACTION(function()
			local settingSystem = self:getInjector():getInstance(SettingSystem)

			settingSystem:requestActivityHeadFrameInfo()
		end, 1)
		END()
	end)

	task:setTimeLimitation(30)

	return task
end

function LoginMediator:showAnnounceView()
	if CommonUtils.GetSwitch("fn_announce_check_in") then
		local view = self:getInjector():getInstance("serverAnnounceViewNew")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			isLogin = true
		}, delegate))
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("HeroStory_Team_UI1")
		}))
	end
end

function LoginMediator:onClickAnnounce()
	self:showAnnounceView()
end

function LoginMediator:onClickReboot()
	local baseVersion = app.pkgConfig.packJobId

	if tonumber(baseVersion) > 14430 and self._loginSystem:getZhengeSdkId() == "6" then
		SDKHelper:logoff()
	end

	if SDKHelper and SDKHelper:isEnableSdk() and device.platform == "ios" then
		SDKHelper:userCenterByPwrdView()
	end
end

function LoginMediator:onClickBugFeedback()
	local data = {
		content = "客服联系邮箱：kaifazhe@52ttqy.net",
		title = Strings:get("Tip_Remind"),
		sureBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function LoginMediator:initAnim(callback)
	self._accountPanel:setOpacity(0)

	local limitBg = self._loginSystem:getLimitTimeBg()
	local actionPanel = self:getView():getChildByName("actionPanel")

	self._bgAnim = cc.MovieClip:create("zdh_xindenglu")

	self._bgAnim:addTo(actionPanel)
	self._bgAnim:setPosition(cc.p(568, 320))
	self._bgAnim:addCallbackAtFrame(90, function()
		self._bgAnim:gotoAndPlay(0)
	end)

	local bgNode = self._bgAnim:getChildByName("bg")

	if limitBg then
		bgNode:removeAllChildren()

		local bgConfig = ConfigReader:getRecordById("BackGroundPicture", limitBg)
		local bgAnim = cc.MovieClip:create(bgConfig.Flash1)

		bgAnim:addTo(bgNode):center(bgNode:getContentSize())
	end

	local isNewLoading = self._loginSystem:getIsNewLoading()

	if isNewLoading then
		local bgNode = self._bgAnim:getChildByName("donghua")

		bgNode:removeAllChildren()

		local loadingConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "AnniversaryLoading", "content")

		if loadingConfig.bg then
			local imageInfo = ConfigReader:getRecordById("BackGroundPicture", loadingConfig.bg)

			if imageInfo.Picture and imageInfo.Picture ~= "" then
				local bgImage = ccui.ImageView:create("asset/scene/" .. imageInfo.Picture .. ".jpg")

				bgImage:addTo(bgNode):center(bgNode:getContentSize())

				local flashId = imageInfo.Flash1

				if flashId and flashId ~= "" then
					local mc = cc.MovieClip:create(flashId)

					mc:addTo(bgNode):center(bgNode:getContentSize())

					local extFlashId = imageInfo.Flash2

					if extFlashId and extFlashId ~= "" then
						local extMc = cc.MovieClip:create(extFlashId)

						if extMc then
							extMc:addTo(bgNode):center(bgNode:getContentSize())
						end
					end
				end
			end
		else
			local bgAnim = cc.MovieClip:create("zong_KoreaAnniversariesLoading")

			bgAnim:addTo(bgNode):center(bgNode:getContentSize())
		end

		self._whaleAnim = nil
	else
		local anim1 = self._bgAnim:getChildByName("donghua")
		local anim2 = anim1:getChildByName("niao")
		local anim3 = anim2:getChildByName("niao1")
		local anim4 = anim2:getChildByName("niao2")
		local anim5 = anim1:getChildByName("jingyu")
		local anim6 = cc.MovieClip:create("yuyu_xindenglu")

		anim6:addTo(anim5):posite(150, -50)
		anim6:addEndCallback(function()
			anim6:stop()
		end)
		anim6:gotoAndPlay(0)

		self._whaleAnim = anim6

		local animPath = "asset/anim/jingyu.skel"

		if cc.FileUtils:getInstance():isFileExist(animPath) then
			local spineNode = sp.SkeletonAnimation:create(animPath)

			spineNode:playAnimation(0, "niao", true)
			spineNode:addTo(anim3)

			local spineNode = sp.SkeletonAnimation:create(animPath)

			spineNode:playAnimation(0, "niao", true)
			spineNode:addTo(anim4)

			local node = anim6:getChildByName("jingyu1")
			local spineNode = sp.SkeletonAnimation:create(animPath)

			spineNode:playAnimation(0, "jingyu", true)
			spineNode:addTo(node)
			spineNode:setPosition(cc.p(0, -180))
		end
	end

	local mc = cc.MovieClip:create("UI_denglu")

	mc:addCallbackAtFrame(10, function()
		self._accountPanel:runAction(cc.FadeIn:create(0.2))
	end)
	mc:addEndCallback(function()
		mc:stop()
	end)
	mc:addTo(actionPanel)
	mc:setPosition(cc.p(568, 320))
	mc:setName("LoginBtnAnim")
	self._logo:setVisible(true)
end

function LoginMediator:onCheckBoxCilck()
	local isVisible = self._checkBox:isVisible()

	self._checkBox:setVisible(not isVisible)
	cc.UserDefault:getInstance():setBoolForKey("loginAgreement", not isVisible)
end

function LoginMediator:onReadyPrivacy()
	if SDKHelper and SDKHelper:isEnableSdk() then
		SDKHelper:showPrivacypolicy()
	end
end

function LoginMediator:onUserPrivacy()
	if SDKHelper and SDKHelper:isEnableSdk() then
		SDKHelper:showUserAgreement()
	end
end

function LoginMediator:onClickAge()
	local view = cc.CSLoader:createNode("asset/ui/NativeContentView.csb")

	self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, nil, nil))

	local mediator = NativeContentViewMediator:new()

	mediator:setView(view)
	mediator:onRegister()
end

function LoginMediator:onSelectRegionClick()
	self._regionPanel:setVisible(not self._regionPanel:isVisible())
end

function LoginMediator:onSetRegion(sender)
	local senderKey = string.split(sender:getName(), "_")[2]

	CommonUtils.SetServerRegion(senderKey)
	self._loginSystem:setCurServer(nil)

	if GameConfigs.disabledSDKLogin then
		self:login()
	elseif SDKHelper and SDKHelper:isEnableSdk() then
		SDKHelper:logOut()
	end

	self._regionPanel:setVisible(false)
end

function LoginMediator:getGlobalServerNum()
	local num = 1
	local globalServer = CommonUtils.ParseGlobalServer()

	if type(globalServer) == "table" then
		num = #table.keys(globalServer)

		if GameConfigs.fn_europe_region_select and globalServer[GameConfigs.fn_europe_region_select] then
			num = 1
		end
	end

	return num
end
