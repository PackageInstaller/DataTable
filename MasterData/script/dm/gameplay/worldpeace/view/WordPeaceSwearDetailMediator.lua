-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WordPeaceSwearDetailMediator.lua

WordPeaceSwearDetailMediator = class("WordPeaceSwearDetailMediator", DmAreaViewMediator, _M)

WordPeaceSwearDetailMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WordPeaceSwearDetailMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
WordPeaceSwearDetailMediator:has("_wordService", {
	is = "r"
}):injectWith("WorldPeaceService")
WordPeaceSwearDetailMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
WordPeaceSwearDetailMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {
	["Panel1.giftBg"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickGiftBtn"
	},
	["Panel1.praiseBg"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickPraiseBtn"
	},
	["Panel2.grabBg1"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickGrabBtn"
	},
	["Panel2.grabBg2"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickGrabBtn1"
	},
	["Panel2.praiseBg"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickPraiseBtn1"
	},
	["changeRoleBg.changeBtn"] = {
		ignoreClickAudio = true,
		func = "onClickChangeRoleBtn"
	},
	["changeRoleBg.randomBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRandomRoleBtn"
	},
	["changeRoleBg.infobtn"] = {
		ignoreClickAudio = true,
		func = "onClickInfoBtn"
	}
}

function WordPeaceSwearDetailMediator:initialize()
	super.initialize(self)
end

function WordPeaceSwearDetailMediator:dispose()
	super.dispose(self)

	if self._timeScheduler then
		self._timeScheduler:stop()

		self._timeScheduler = nil
	end
end

function WordPeaceSwearDetailMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_SWEAR_CHATBOSS_CONTENT_REFRESH, self, self.addMessage)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_SWEAR_CHATBOSS_TIME_REFRESH, self, self.refreshBtnTimes)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_SWEAR_CHOSSBOSS_REFRESH, self, self.refreshAllView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_SWEAR_GROUPINFO_REFRESH, self, self.refreshBottomView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_SWEAR_SYSTEMCHAT_REFRESH, self, self.refreshSystemChat)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_ENTERMAP, self, self.onClickBack)
end

function WordPeaceSwearDetailMediator:close()
	self:dismiss()
end

function WordPeaceSwearDetailMediator:doReset()
	if DisposableObject:isDisposed(self) then
		return
	end

	self._worldPeaceSystem:pullSwearData(function()
		if DisposableObject:isDisposed(self) then
			return
		end

		self:refreshAllView()
	end)
end

function WordPeaceSwearDetailMediator:enterWithData(data)
	data = data or {}
	self.___songli = 0
	self.___kuazan = 0
	self._data = data
	self._changeBossTotalTime = self._worldPeaceSystem:getRandomBossTotalTime()
	self._giftTotalTime1 = self._worldPeaceSystem:getGiftPhaseOneTotalTime()
	self._PriseTotalTime1 = self._worldPeaceSystem:getPrisePhaseOneTotalTime()
	self._phase = self._worldPeaceSystem:getChatStatue()

	self:setOtherClubId()
	self:setUpView()
	self:setupTopInfoWidget()
	self:initChatListView()
	self:refreshView()
end

function WordPeaceSwearDetailMediator:setOtherClubId()
	local matchGroup = self._worldPeaceSystem:getWorldPeace():getMatchGroup()
	local myClubId = self._clubSystem:getClubId()
	local otherGroup = {}

	for k, v in pairs(matchGroup) do
		if v.gId ~= myClubId then
			otherGroup[#otherGroup + 1] = v
		end
	end

	self._clubA = otherGroup[1]
	self._clubB = otherGroup[2]
end

local rankRes = {
	"swear_img_paiming01.png",
	"swear_img_paiming02.png",
	"swear_img_paiming03.png"
}
local campColor = {
	"#fd62ff",
	"#ffe26e",
	"#81cdff"
}

function WordPeaceSwearDetailMediator:setUpView()
	self._listView = self:getView():getChildByFullName("list")

	self._listView:setScrollBarEnabled(false)

	self._changeRoleBg = self:getView():getChildByFullName("changeRoleBg")
	self._rolePanel = self:getView():getChildByFullName("rolePanel")
	self._panel1 = self:getView():getChildByFullName("Panel1")
	self._panel2 = self:getView():getChildByFullName("Panel2")
	self._timeScheduler = LuaScheduler:getInstance():schedule(function(task, dt)
		self:update(dt)
	end, 0.03333333333333333, true)
	self._doRefreshSwitch = false
	self._splashView = self:getView():getChildByName("splash")

	self._splashView:setOpacity(0)
	self._splashView:setScaleY(0)
end

function WordPeaceSwearDetailMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kClubMapPotion
		},
		title = Strings:get("ClubMapBoss_Title04"),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function WordPeaceSwearDetailMediator:refreshSystemChat(event)
	local data = event:getData()

	if data.critLog and data.critLog.params then
		local messageWidget = self:createChatMessageWidget(data.critLog, false, true)

		self._listView:pushBackCustomItem(messageWidget)
		self._listView:jumpToBottom()

		if data.critLog.params.guildrank then
			self.__ssguide = data.critLog.params.guildrank
		end
	end
end

function WordPeaceSwearDetailMediator:watchRewards()
	local groupId = self._worldPeaceSystem:getWorldSwearChat():getGroupId()
	local groupData = self._worldPeaceSystem:getWorldSwearChat():getGroupData()

	self._showTips = self._showTips or {}
	self._showPanelTips = self._showPanelTips or {}

	local showReward

	function showReward()
		local animfinsh = self.___songli <= 0 and self.___kuazan <= 0

		if not animfinsh then
			return
		end

		if table.nums(self._showTips) <= 0 then
			return
		end

		if self.__tipsruning then
			return
		end

		local params = table.remove(self._showTips, 1)
		local rewards = params.rewards
		local rank = params.rank

		if rank > 6 then
			return
		end

		self.__tipsruning = true

		local splashView = self._splashView

		splashView:changeParent(self._myRoot):posite(-130, -50)

		local iconRoot = splashView:getChildByName("icon")
		local rank_ = splashView:getChildByName("rank")

		rank_:loadTexture("swear_img_pingfen" .. rank .. ".png", 1)
		iconRoot:removeAllChildren()

		for k, v in pairs(rewards) do
			local icon = IconFactory:createRewardIcon(v, {
				showAmount = true,
				isWidget = true
			})

			icon:addTo(iconRoot)
			icon:setScaleNotCascade(0.5)
			icon:offset((k - 1) * 100, 0)
		end

		rank_:ignoreContentAdaptWithSize(true)
		splashView:stopAllActions()
		splashView:setScaleY(0)
		splashView:setOpacity(0)

		local action1 = cc.ScaleTo:create(0.1, 1)
		local action2 = cc.FadeTo:create(0.1, 255)
		local action = cc.Spawn:create(action1, action2)
		local delay = cc.DelayTime:create(0.4)
		local action = cc.Sequence:create(action, delay, cc.CallFunc:create(function()
			local action2 = cc.FadeTo:create(0.1, 0)
			local delay = cc.DelayTime:create(0.1)
			local action = cc.Sequence:create(action2, delay, cc.CallFunc:create(function()
				self.__tipsruning = false

				showReward()
			end))

			splashView:runAction(action)
		end))

		splashView:runAction(action)
	end

	showReward()

	local showPanelReward

	;(function()
		local animfinsh = self.___songli <= 0 and self.___kuazan <= 0

		if not animfinsh then
			return
		end

		if table.nums(self._showPanelTips) <= 0 then
			return
		end

		if self.__tipspanelruning then
			return
		end

		local params = table.remove(self._showPanelTips, 1)
		local rewards = params.rewards
		local rank = params.rank

		self.__tipspanelruning = true

		local function closeCall()
			self.__tipspanelruning = false
		end

		local view = self:getInjector():getInstance("WordPeaceSwearTipsView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0,
			closeCaptureScreen = true,
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			rewards = rewards,
			rank = rank,
			parent = self,
			closeCall = closeCall
		}))
	end)()
end

function WordPeaceSwearDetailMediator:initChatListView()
	local chatList = self._worldPeaceSystem:getWorldSwearChat():getOwnChat()
	local chatBossId = self._worldPeaceSystem:getWorldSwearChat():getChatBossId()
	local chat = chatList[chatBossId]
	local chatList = {}

	for k, v in pairs(chat or {}) do
		chatList[k] = v
	end

	local critlog = self._worldPeaceSystem:getWorldSwearChat():getCritLog()
	local critlog = critlog[chatBossId]

	for k, v in pairs(critlog or {}) do
		chatList[#chatList + 1] = v
	end

	table.sort(chatList, function(a, b)
		return a.chatTime < b.chatTime
	end)

	self._pushmessageCommonds = {}

	self._listView:removeAllChildren()

	self._syncLoadMessage = coroutine.create(function()
		local time = os.clock()

		for i = 1, #chatList do
			local curChatData = chatList[i]

			if curChatData.params then
				local messageWidget = self:createChatMessageWidget(curChatData, false, true)

				self._listView:pushBackCustomItem(messageWidget)
			else
				local messageWidget = self:createChatMessageWidget(curChatData, false)
				local messageView = messageWidget:getView()

				self._listView:pushBackCustomItem(messageView)

				local curChatData = chatList[i]
				local messageWidget = self:createChatMessageWidget(curChatData, true)
				local messageView = messageWidget:getView()

				self._listView:pushBackCustomItem(messageView)
			end

			if os.clock() - time > 0.03333333333333333 then
				time = os.clock()

				coroutine.yield("unfinish")
			end

			self._listView:jumpToBottom()
		end

		coroutine.yield("finish")
	end)
end

function WordPeaceSwearDetailMediator:update(dt)
	coroutine.resume(self._syncLoadMessage)
	self:watchRewards()

	self._tickTime = self._tickTime or 0
	self._tickTime = self._tickTime + dt

	if self._tickTime > 3 then
		self._tickTime = 0
	else
		return
	end

	local gameServerAgent = DmGame:getInstance()._injector:getInstance(GameServerAgent)
	local remoteTimestamp_ = gameServerAgent:remoteTimestamp()

	if self._phase == WPChatStatue.kChat1 then
		local giftPhaseOneTimes = self._worldPeaceSystem:getWorldSwearChat():getGiftPhaseOneTimes()
		local remoteTimestamp = giftPhaseOneTimes.nextRefreshTime

		if remoteTimestamp / 1000 - remoteTimestamp_ < 0 and not self._doRefreshSwitch then
			self:doReset()

			self._doRefreshSwitch = true
		end
	elseif self._phase == WPChatStatue.kChat2 then
		local phaseTwoTimes = self._worldPeaceSystem:getWorldSwearChat():getPhaseTwoTimes()
		local remoteTimestamp = phaseTwoTimes.nextRefreshTime

		if remoteTimestamp / 1000 - remoteTimestamp_ < 0 and not self._doRefreshSwitch then
			self:doReset()

			self._doRefreshSwitch = true
		end
	end

	if self._phase == WPChatStatue.kChat1 then
		local phase = self._worldPeaceSystem:getChatStatue()

		if phase == WPChatStatue.kChat2 then
			self:refreshAllView()
		end
	end
end

function WordPeaceSwearDetailMediator:createChatMessageView(isBoss, isSystem)
	local resFile = isBoss and "asset/ui/WordPeaceChatWithBossLeft.csb" or isSystem and "asset/ui/WordPeaceChatWithBossSystem.csb" or "asset/ui/WordPeaceChatWithBossRight.csb"
	local view = ccui.Layout:create()
	local node = cc.CSLoader:createNode(resFile)

	node:setAnchorPoint(cc.p(0, 1))
	node:addTo(view):setName("main")

	return view
end

function WordPeaceSwearDetailMediator:createChatMessageWidget(param, isBoss, isSystem)
	local messageWidget
	local messageView = self:createChatMessageView(isBoss, isSystem)

	if isBoss then
		local chatBossId = self._worldPeaceSystem:getWorldSwearChat():getChatBossId()
		local bossCfg = ConfigReader:getRecordById("ClubMapBoss", chatBossId)
		local bossHeadId = bossCfg.HeroIcon
		local bossFrameId = bossCfg.HeadFrame
		local senderInfo = {
			headId = bossHeadId,
			frameId = bossFrameId,
			pointNum = param.addPoint
		}

		messageWidget = WordPeaceSwearBossMessageWidget:new(messageView)

		self:getInjector():injectInto(messageWidget)
		messageWidget:decorateView(param, senderInfo)
	elseif isSystem then
		local config = ConfigReader:getRecordById("Announce", tostring(param.msgId))
		local env = {}

		for k, v in pairs(param.params) do
			env[k] = v
		end

		if param.params.groupname then
			local campColor = {
				"#fd62ff",
				"#ffe26e",
				"#81cdff"
			}
			local worldPeaceSystem = DmGame:getInstance()._injector:getInstance("WorldPeaceSystem")
			local matchGroup = worldPeaceSystem:getWorldPeace():getMatchGroupChat()

			for k, v in pairs(matchGroup) do
				if v.name == param.params.groupname or v.gName == param.params.groupname then
					env.color1 = campColor[v.camp]
				end
			end
		end

		if param.params.groupname2 then
			local campColor = {
				"#fd62ff",
				"#ffe26e",
				"#81cdff"
			}
			local worldPeaceSystem = DmGame:getInstance()._injector:getInstance("WorldPeaceSystem")
			local matchGroup = worldPeaceSystem:getWorldPeace():getMatchGroupChat()

			for k, v in pairs(matchGroup) do
				if v.name == param.params.groupname2 or v.gName == param.params.groupname2 then
					env.color2 = campColor[v.camp]
				end
			end
		end

		if param.params.guildrank then
			local desc = {
				"S",
				"SS",
				"SSS"
			}

			env.guildrank = desc[param.params.guildrank - 5]
		end

		local content = Strings:get(config.Words[1], env)
		local contentRect = messageView:getChildByFullName("main.content.content_rect")

		contentRect:setString("")

		local t = TextTemplate:new(content)
		local str = t:stringify({
			size = 20,
			fontName = TTF_FONT_FZYH_M
		})
		local contentText = messageView:getChildByFullName("content_text")
		local contentText = ccui.RichText:createWithXML(str, {})

		contentText:setTouchEnabled(true)
		contentText:setSwallowTouches(false)

		local anchor = contentRect:getAnchorPoint()
		local pos = contentRect:getPosition()

		contentText:setAnchorPoint(anchor)

		local bg = messageView:getChildByFullName("main.bg")

		bg:getChildByName("Text_who"):setString(Strings:get("Chat_Label_System"))

		local disignW = 30
		local disignW = bg:getChildByName("Text_who"):getContentSize().width - disignW

		contentText:setName("content_text"):posite(70 + disignW, 20):addTo(contentRect:getParent())
		contentText:renderContent()

		local size = contentText:getContentSize()
		local maxWidth = 250

		contentText:renderContent(270 - disignW, 0, true)

		local realSize = contentText:getContentSize()

		bg:setContentSize(maxWidth + 90, realSize.height + 20)

		local setBubbleSizeY = 0
		local contentPanel = messageView:getChildByFullName("main.content")

		contentPanel:setContentSize(10, setBubbleSizeY)
		contentText:setPositionY(setBubbleSizeY * 0.5)
		messageView:setContentSize(cc.size(375, realSize.height + 30))

		local tureHei = contentText:getContentSize().height
		local designhei = 85.5 - tureHei

		messageView:getChildByName("main"):setPositionY(60)
		contentPanel:offset(0, 0 - designhei)
		bg:setPositionY(realSize.height + 50)
		bg:getChildByName("Text_who"):setPositionY(bg:getContentSize().height - 30)

		messageWidget = messageView
	else
		local player = self._developSystem:getPlayer()
		local rankContent = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Bride_RewardGrade", "content")
		local key = tostring(param.rank)
		local rankText = rankContent[key]
		local senderInfo = {
			headId = player:getHeadId(),
			frameId = player:getCurHeadFrame(),
			name = player:getNickName(),
			lv = player:getLevel(),
			rank = rankText
		}

		messageWidget = WordPeaceSwearSelfMessageWidget:new(messageView)

		self:getInjector():injectInto(messageWidget)
		messageWidget:decorateView(param, senderInfo)
	end

	return messageWidget
end

function WordPeaceSwearDetailMediator:addMessage(event)
	if DisposableObject:isDisposed(self) then
		return
	end

	local data = event:getData()
	local messageWidget = self:createChatMessageWidget(data, false)
	local messageView = messageWidget:getView()

	self._listView:pushBackCustomItem(messageView)

	local messageWidget = self:createChatMessageWidget(data, true)
	local messageView = messageWidget:getView()

	self._listView:pushBackCustomItem(messageView)
	self._listView:jumpToBottom()

	if data.rank then
		self._splashRank = data.rank
	end
end

function WordPeaceSwearDetailMediator:refreshBtnTimes()
	self._panel1:setVisible(self._phase == WPChatStatue.kChat1)
	self._panel2:setVisible(self._phase == WPChatStatue.kChat2)

	local bossRandomText = self._changeRoleBg:getChildByFullName("randomBtn.TextRandom")

	bossRandomText:setString(self._worldPeaceSystem:getWorldSwearChat():getChangeBossTimes().value .. "/" .. self._worldPeaceSystem:getRandomBossTotalTime())

	if self._phase == WPChatStatue.kChat1 then
		local giftPhaseOneTimes = self._worldPeaceSystem:getWorldSwearChat():getGiftPhaseOneTimes()
		local praisePhaseOneTimes = self._worldPeaceSystem:getWorldSwearChat():getPraisePhaseOneTimes()
		local todayGiftTimes = self._worldPeaceSystem:getWorldSwearChat():getTodayGiftTimes()
		local giftLeftTimeTxt = self._panel1:getChildByFullName("giftBg.giftBtn.TextLeftTime")

		giftLeftTimeTxt:setString(giftPhaseOneTimes.value)

		local ClubMapBoss_Gift_Price = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBoss_Gift_Price", "content")
		local giftBtnCnt = self._panel1:getChildByFullName("giftBg.giftBtn.cnt")

		if ClubMapBoss_Gift_Price[todayGiftTimes + 1] then
			if not ClubMapBoss_Gift_Price[todayGiftTimes + 1] then
				local diamondNum = ClubMapBoss_Gift_Price[#ClubMapBoss_Gift_Price]

				giftBtnCnt:setString(diamondNum)

				local praiseLeftTimeTxt = self._panel1:getChildByFullName("praiseBg.praiseBtn.TextLeftTime")

				praiseLeftTimeTxt:setString(praisePhaseOneTimes.value)

				local refreshTimeText = self._panel1:getChildByFullName("refreshTimeText")
				local remoteTimestamp = giftPhaseOneTimes.nextRefreshTime
				local timeStr = TimeUtil:getHMSByTimestamp(remoteTimestamp / 1000)

				refreshTimeText:setString(Strings:get("ClubMapBoss_Chat_UI17", {
					HH = (timeStr.hour < 10 or nil) and "0" .. timeStr.hour,
					mm = (timeStr.min < 10 or nil) and "0" .. timeStr.min
				}))
			end
		end
	elseif self._phase == WPChatStatue.kChat2 then
		local phaseTwoTimes = self._worldPeaceSystem:getWorldSwearChat():getPhaseTwoTimes()
		local praiseLeftTxt = self._panel2:getChildByFullName("leftTimeTxt")

		praiseLeftTxt:setString("x" .. phaseTwoTimes.value)

		local refreshTimeText = self._panel2:getChildByFullName("refreshTimeTxt")
		local remoteTimestamp = phaseTwoTimes.nextRefreshTime
		local timeStr = TimeUtil:getHMSByTimestamp(remoteTimestamp / 1000)

		refreshTimeText:setString(Strings:get("ClubMapBoss_Chat_UI17", {
			HH = (timeStr.hour < 10 or nil) and "0" .. timeStr.hour,
			mm = (timeStr.min < 10 or nil) and "0" .. timeStr.min
		}))

		local grab1LeftTxt = self._panel2:getChildByFullName("grabBg1.grabBtn.clubName")

		grab1LeftTxt:setString(self._clubA.name or self._clubA.groupName)
		grab1LeftTxt:setColor(GameStyle:stringToColor(campColor[self._clubA.camp]))

		local grab2LeftTxt = self._panel2:getChildByFullName("grabBg2.grabBtn.clubName")

		grab2LeftTxt:setString(self._clubB.name or self._clubB.groupName)
		grab2LeftTxt:setColor(GameStyle:stringToColor(campColor[self._clubB.camp]))
	else
		self._panel1:setVisible(false)
		self._panel2:setVisible(false)
	end
end

function WordPeaceSwearDetailMediator:refreshAllView()
	self._phase = self._worldPeaceSystem:getChatStatue()

	self:refreshRole()
	self:refreshBottomView()
	self:initChatListView()
	self:refreshBtnTimes()
end

function WordPeaceSwearDetailMediator:refreshView()
	self:refreshRole()
	self:refreshBottomView()
	self:refreshBtnTimes()
end

function WordPeaceSwearDetailMediator:collectWorldPos()
	local groupId = self._worldPeaceSystem:getWorldSwearChat():getGroupId()
	local groupData = self._worldPeaceSystem:getWorldSwearChat():getGroupData()
	local groupName = groupData[groupId].groupName
	local poses = {}

	for k, v in pairs(self._rewardList[groupName]) do
		poses[k] = cc.p(v:getParent():convertToWorldSpace(cc.p(v:getPosition())))
	end

	return poses
end

function WordPeaceSwearDetailMediator:refreshBottomView()
	local groupData = self._worldPeaceSystem:getWorldSwearChat():getGroupData()
	local chatBossId = self._worldPeaceSystem:getWorldSwearChat():getChatBossId()
	local bosses = self._worldPeaceSystem:getWorldSwearChat():getBosses()
	local matchGroup = self._worldPeaceSystem:getWorldPeace():getMatchGroup()

	self._worldPeaceSystem:setCampIndex(matchGroup)

	local groupInfoList = {}
	local targetBossInfo = bosses[chatBossId]

	for k, v in pairs(groupData) do
		local ret = {
			point = 0,
			isnull = true,
			sort = 1,
			name = v.groupName,
			bossRewards = {},
			gId = v.gId
		}

		if targetBossInfo and targetBossInfo.clubPointMap and targetBossInfo.clubPointMap[k] then
			ret.isnull = false
			ret.point = targetBossInfo.clubPointMap[k]
			ret.bossRewards = v.bossRewards[chatBossId]
			ret.name = v.groupName
		end

		for k_, v_ in pairs(matchGroup) do
			if k == v_.gId then
				ret.camp = v_.camp
			end
		end

		groupInfoList[#groupInfoList + 1] = ret
	end

	table.sort(groupInfoList, function(a, b)
		return a.point > b.point
	end)

	self._rewardList = self._rewardList or {}
	self.__diffRewards = self.__diffRewards or {}
	self._ownItem = {}

	local myClubId = self._clubSystem:getClubId()

	for k, v in pairs(groupInfoList) do
		local root = self:getView():getChildByName("cell0" .. k)
		local rank = root:getChildByName("rankicon")
		local title = root:getChildByName("title")
		local chat = root:getChildByName("chat")
		local score = root:getChildByName("cnt")
		local Text_1 = root:getChildByName("Text_1")
		local listView = root:getChildByName("ListView")

		listView:setScrollBarEnabled(false)
		listView:removeAllChildren()

		self._rewardList[v.name] = self._rewardList[v.name] or {}
		self.__diffRewards[v.name] = self.__diffRewards[v.name] or {}

		rank:ignoreContentAdaptWithSize(true)
		rank:loadTexture("asset/commonRaw/" .. rankRes[k])
		score:setString(v.point)
		title:setString("[" .. v.name .. "]")
		title:setColor(GameStyle:stringToColor(campColor[v.camp]))

		if myClubId == v.gId then
			self._myRoot = root
		end

		local clubSystem = DmGame:getInstance()._injector:getInstance(ClubSystem)
		local id = clubSystem:getClubInfoOj():getClubId()

		for k_, v_ in pairs(self._rewardList[v.name]) do
			local has = false

			for k__, v__ in pairs(v.bossRewards) do
				if v__.code == k_ then
					has = true
				end
			end

			if not has then
				v_._amount = 0
			end
		end

		local maxPerLine = 4
		local iconScale = 0.4
		local iconWidth = 55
		local iconHeight = 55
		local rowLayouts = {}

		for i, reward in pairs(v.bossRewards) do
			local icon = self._rewardList[v.name][reward.code]

			self._rewardList[v.name] = self._rewardList[v.name] or {}

			if not icon then
				icon = IconFactory:createRewardIcon(reward, {
					showAmount = true,
					isWidget = true
				})

				icon:setScale(iconScale)
				icon:setName(reward.code)
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
					needDelay = true
				})
				icon:setVisible(true)

				self._rewardList[v.name][reward.code] = icon
				self._rewardList[v.name][reward.code]._amount = reward.amount
				self.__diffRewards[v.name] = self.__diffRewards[v.name] or {}
				self.__diffRewards[v.name][reward.code] = {
					up = true,
					code = reward.code,
					amount = reward.amount,
					type = reward.type
				}
			elseif not tolua.isnull(icon) then
				local parent = icon:getParent()

				if parent and not tolua.isnull(parent) then
					icon:removeFromParent(false)
				end

				icon:setAmount(reward.amount)
				icon:setVisible(true)
				icon:setName(reward.code)

				if not icon:isVisible() then
					self.__diffRewards[v.name] = self.__diffRewards[v.name] or {}
					self.__diffRewards[v.name][reward.code] = {
						up = true,
						code = reward.code,
						amount = reward.amount,
						type = reward.type
					}
				end

				if not icon._amount then
					local oldAmount = 0

					if oldAmount < reward.amount and oldAmount > 0 then
						icon:removeChildByName("animplay")

						local node = cc.MovieClip:create("zeng_jianglijiantou")

						node:addTo(icon)
						node:play()
						node:offset(120, 0)
						node:setName("animplay")
						node:addEndCallback(function()
							node:removeFromParent()
						end)

						self.__diffRewards[v.name][reward.code] = {
							up = true,
							code = reward.code,
							amount = reward.amount - oldAmount,
							type = reward.type
						}
					elseif oldAmount > reward.amount and oldAmount > 0 then
						icon:removeChildByName("animplay")

						local node = cc.MovieClip:create("jian_jianglijiantou")

						node:addTo(icon)
						node:play()
						node:offset(120, 0)
						node:setName("animplay")
						node:addEndCallback(function()
							node:removeFromParent()
						end)
					end

					icon._amount = reward.amount
				end
			end

			local rowIndex = math.floor((i - 1) / maxPerLine)
			local posInRow = (i - 1) % maxPerLine

			if not rowLayouts[rowIndex] then
				local rowLayout = ccui.Layout:create()

				rowLayout:setContentSize(cc.size(listView:getContentSize().width, iconHeight))
				rowLayout:setAnchorPoint(cc.p(0, 0))

				rowLayouts[rowIndex] = rowLayout

				listView:pushBackCustomItem(rowLayout)
			end

			if icon and not tolua.isnull(icon) then
				local rowLayout = rowLayouts[rowIndex]

				rowLayout:addChild(icon)

				local x = posInRow * iconWidth + 30
				local y = rowLayout:getContentSize().height / 2

				icon:setPosition(cc.p(x, y))
			end
		end

		if self._rewardList[v.name] then
			for code, icon in pairs(self._rewardList[v.name]) do
				local isUsed = false

				for _, reward in pairs(v.bossRewards) do
					if reward.code == code then
						isUsed = true

						break
					end
				end

				if not isUsed and not tolua.isnull(icon) then
					icon:setVisible(false)
				end
			end
		end

		Text_1:setVisible(v.isnull)
		rank:setVisible(not v.isnull)
	end
end

function WordPeaceSwearDetailMediator:refreshRole(data)
	self.__diffRewards = {}

	local chatBossId = self._worldPeaceSystem:getWorldSwearChat():getChatBossId()
	local bossCfg = ConfigReader:getRecordById("ClubMapBoss", chatBossId)

	self._rolePanel:removeAllChildren()

	local roleModelId = ConfigReader:getDataByNameIdAndKey("HeroBase", bossCfg.Hero, "RoleModel")
	local img = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = roleModelId
	})

	img:addTo(self._rolePanel):posite(150, 80)
end

function WordPeaceSwearDetailMediator:onClickChangeRoleBtn()
	local view = self:getInjector():getInstance("WordPeaceChoseBossView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}))
end

function WordPeaceSwearDetailMediator:onClickRandomRoleBtn()
	local params = {
		bossId = ""
	}

	self._worldPeaceSystem:changeChatBoss(params, function()
		return
	end)
end

function WordPeaceSwearDetailMediator:onClickInfoBtn()
	local view = self:getInjector():getInstance("WordPeaceSwearRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Hero_EquipEnergyTranslate
	}, nil)

	self:dispatch(event)
end

function WordPeaceSwearDetailMediator:onClickGiftBtn()
	print("------送礼-------")

	local phaseOneTimes = self._worldPeaceSystem:getWorldSwearChat():getGiftPhaseOneTimes()

	if phaseOneTimes.value <= 0 then
		return self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_80642")
		}))
	end

	self.___songli = self.___songli or 0
	self.___songli = self.___songli + 1

	local gift = self:getView():getChildByFullName("Panel1.giftBg")
	local anim = cc.MovieClip:create("anniu_fx_common_qxnmazhan")

	anim:addTo(gift)
	anim:offset(90, 32)
	anim:setScaleX(0.85)
	anim:setPlaySpeed(1.5)
	anim:addEndCallback(function()
		anim:removeFromParent()
	end)
	anim:addCallbackAtFrame(5, function()
		local anim_ = cc.MovieClip:create("songli_qxnmazhan")
		local node = cc.Node:create()

		anim_:addTo(node)
		self:getView():addChild(node, 10)
		node:setPosition(568, 320)
		anim_:setPlaySpeed(1.5)
		anim_:addEndCallback(function()
			anim_:removeFromParent()
		end)

		self.___songli = self.___songli - 1
	end)

	local params = {
		type = WorldPeaceSwearBehaviorWithBoss.KGift
	}

	self._worldPeaceSystem:requestInteractWithBoss(params, function(data)
		if data.thisChat.rank > 6 then
			self._showPanelTips[#self._showPanelTips + 1] = {
				rank = data.thisChat.rank,
				rewards = data.clubRewards
			}
		else
			self._showTips[#self._showTips + 1] = {
				rank = data.thisChat.rank,
				rewards = data.clubRewards
			}
		end
	end)
end

function WordPeaceSwearDetailMediator:onClickPraiseBtn()
	print("------夸赞-------")

	local phaseOneTimes = self._worldPeaceSystem:getWorldSwearChat():getPraisePhaseOneTimes()

	if phaseOneTimes.value <= 0 then
		return self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_80642")
		}))
	end

	local gift = self:getView():getChildByFullName("Panel1.praiseBg")
	local anim = cc.MovieClip:create("anniu_fx_common_qxnmazhan")

	anim:addTo(gift)
	anim:offset(90, 45)
	anim:setScaleX(0.85)
	anim:setPlaySpeed(1.5)

	self.___kuazan = self.___kuazan or 0
	self.___kuazan = self.___kuazan + 1

	anim:addEndCallback(function()
		anim:removeFromParent()
	end)
	anim:addCallbackAtFrame(5, function()
		local anim_ = cc.MovieClip:create("eryu_qxnmazhan")
		local node = cc.Node:create()

		anim_:addTo(node)
		anim_:setPlaySpeed(1.5)
		self:getView():addChild(node, 10)
		node:setPosition(568, 320)
		anim_:addEndCallback(function()
			anim_:removeFromParent()
		end)

		self.___kuazan = self.___kuazan - 1
	end)

	local params = {
		type = WorldPeaceSwearBehaviorWithBoss.KPraise
	}

	self._worldPeaceSystem:requestInteractWithBoss(params, function(data)
		if data.thisChat.rank > 6 then
			self._showPanelTips[#self._showPanelTips + 1] = {
				rank = data.thisChat.rank,
				rewards = data.clubRewards
			}
		else
			self._showTips[#self._showTips + 1] = {
				rank = data.thisChat.rank,
				rewards = data.clubRewards
			}
		end
	end)
end

function WordPeaceSwearDetailMediator:onClickPraiseBtn1()
	print("------夸赞-------")

	local phaseTwoTimes = self._worldPeaceSystem:getWorldSwearChat():getPhaseTwoTimes()

	if phaseTwoTimes.value <= 0 then
		return self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_80642")
		}))
	end

	local gift = self:getView():getChildByFullName("Panel2.praiseBg")

	self.___kuazan = self.___kuazan or 0
	self.___kuazan = self.___kuazan + 1

	local anim_ = cc.MovieClip:create("eryu_qxnmazhan")

	anim_:addTo(gift)
	anim_:setPlaySpeed(1.5)
	anim_:setPosition(250, 320)
	anim_:addEndCallback(function()
		anim_:removeFromParent()
	end)

	self.___kuazan = self.___kuazan - 1

	local params = {
		type = WorldPeaceSwearBehaviorWithBoss.KPraise
	}

	self._worldPeaceSystem:requestInteractWithBoss(params, function(data)
		if data.thisChat.rank > 6 then
			self._showPanelTips[#self._showPanelTips + 1] = {
				rank = data.thisChat.rank,
				rewards = data.clubRewards
			}
		else
			self._showTips[#self._showTips + 1] = {
				rank = data.thisChat.rank,
				rewards = data.clubRewards
			}
		end
	end)
end

function WordPeaceSwearDetailMediator:onClickGrabBtn()
	print("------抢夺-------")

	local phaseTwoTimes = self._worldPeaceSystem:getWorldSwearChat():getPhaseTwoTimes()

	if phaseTwoTimes.value <= 0 then
		return self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_80642")
		}))
	end

	local gift = self:getView():getChildByFullName("Panel2.grabBg1")

	self.___kuazan = self.___kuazan or 0
	self.___kuazan = self.___kuazan + 1

	local anim_ = cc.MovieClip:create("lalong_qxnmazhan")
	local node = cc.Node:create()

	anim_:addTo(gift)
	anim_:setPlaySpeed(1.5)
	anim_:setPosition(50, 320)
	anim_:addEndCallback(function()
		anim_:removeFromParent()
	end)

	self.___kuazan = self.___kuazan - 1

	local var_52_0 = {
		type = WorldPeaceSwearBehaviorWithClub.KGrab,
		clubId = self._clubA.gId
	}

	var_52_0.bossId = self._worldPeaceSystem:getWorldSwearChat():getChatBossId()

	local params = var_52_0

	self._worldPeaceSystem:requestInteractWithClub(params, function(data)
		if data.thisChat.rank > 6 then
			self._showPanelTips[#self._showPanelTips + 1] = {
				rank = data.robRank,
				rewards = data.robRewards
			}
		else
			self._showTips[#self._showTips + 1] = {
				rank = data.robRank,
				rewards = data.robRewards
			}
		end
	end)
end

function WordPeaceSwearDetailMediator:onClickGrabBtn1()
	print("------抢夺-------")

	local phaseTwoTimes = self._worldPeaceSystem:getWorldSwearChat():getPhaseTwoTimes()

	if phaseTwoTimes.value <= 0 then
		return self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_80642")
		}))
	end

	local gift = self:getView():getChildByFullName("Panel2.grabBg2")
	local anim = cc.MovieClip:create("anniu_fx_common_qxnmazhan")

	self.___kuazan = self.___kuazan or 0
	self.___kuazan = self.___kuazan + 1

	local anim_ = cc.MovieClip:create("lalong_qxnmazhan")

	anim_:addTo(gift)
	anim_:setPlaySpeed(1.5)
	anim_:setPosition(-250, 320)
	anim_:addEndCallback(function()
		anim_:removeFromParent()
	end)

	self.___kuazan = self.___kuazan - 1

	for k, v in pairs(self.__diffRewards or {}) do
		for k, v_ in pairs(v) do
			v_.up = nil
		end
	end

	local var_55_0 = {
		type = WorldPeaceSwearBehaviorWithClub.KGrab,
		clubId = self._clubB.gId
	}

	var_55_0.bossId = self._worldPeaceSystem:getWorldSwearChat():getChatBossId()

	local params = var_55_0

	self._worldPeaceSystem:requestInteractWithClub(params, function(data)
		if data.thisChat.rank > 6 then
			self._showPanelTips[#self._showPanelTips + 1] = {
				rank = data.robRank,
				rewards = data.robRewards
			}
		else
			self._showTips[#self._showTips + 1] = {
				rank = data.robRank,
				rewards = data.robRewards
			}
		end
	end)
end

function WordPeaceSwearDetailMediator:onClickBack()
	if checkDependInstance(self) then
		self:dismiss()
	end
end
