-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/bashen/ClubBashenMainMediator.lua

ClubBashenMainMediator = class("ClubBashenMainMediator", DmAreaViewMediator, _M)

ClubBashenMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubBashenMainMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ClubBashenMainMediator:has("_clubBashenSystem", {
	is = "r"
}):injectWith("ClubBashenSystem")
ClubBashenMainMediator:has("_redPointSystem", {
	is = "r"
}):injectWith("RedPointSystem")

local kBtnHandlers = {
	["main.left_bg.button_reward_panel.button_reward"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickReward"
	},
	["main.button_rule"] = {
		ignoreClickAudio = true,
		func = "onClickRule"
	},
	["main.button_rank"] = {
		ignoreClickAudio = true,
		func = "onClickRank"
	},
	["main.button_open"] = {
		ignoreClickAudio = true,
		func = "onClickOpen"
	}
}

function ClubBashenMainMediator:initialize()
	super.initialize(self)
end

function ClubBashenMainMediator:dispose()
	self:dispatch(Event:new(EVT_CLUBOSSREDPOINT_REFRESH))

	if self._bubbleScheduler then
		LuaScheduler:getInstance():unschedule(self._bubbleScheduler)

		self._bubbleScheduler = nil
	end

	if self._announceScheduler then
		LuaScheduler:getInstance():unschedule(self._announceScheduler)

		self._announceScheduler = nil
	end

	super.dispose(self)
end

function ClubBashenMainMediator:onRegister()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dailyReset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_BASHEN_REOPEN_SUCC, self, self.refreshCurReward)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_BASHEN_REWARD_CHANGE, self, self.refreshBtnRewardAnim)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_BASHEN_RECEIVE_ANNOUNCE, self, self.refreshAnnounceView)
	self:mapButtonHandlersClick(kBtnHandlers)
	super.onRegister(self)
end

function ClubBashenMainMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)

	local background = cc.Sprite:create("asset/scene/scene_main_rezero_4.jpg")
	local targetPos = self:getView():convertToNodeSpace(cc.p(targetFrame.x + targetFrame.width / 2, targetFrame.y + targetFrame.height / 2))

	background:addTo(self:getView(), -1):setName("backgroundBG"):posite(targetPos.x, targetPos.y)

	self._targetFrame = targetFrame
end

function ClubBashenMainMediator:enterWithData(data)
	super.enterWithData(self, data)
	self:setupTopInfoWidget()
	self:setupView()
end

function ClubBashenMainMediator:setupView()
	self:setupUI()
	self:setupMainAnim()
	self:setupBubble()
	self:setupAnnounce()
	self:refreshCurReward()
	self:refreshBtnRewardAnim()
end

function ClubBashenMainMediator:setupChatFlowWidget()
	if not self._chatFlowWidget then
		local view = ChatFlowWidget:createWidgetNode()

		self._chatFlowWidget = self:autoManageObject(self:getInjector():injectInto(ChatFlowWidget:new(view)))

		view:addTo(self:getView(), 99999):offset(430, 550)
		self._chatFlowWidget:start(ChannelId.kBaShenFlow)
	end
end

function ClubBashenMainMediator:refreshRedPoint()
	self._btnOpen:removeChildByName("RedPoint")

	local redPointData = {
		system = self._clubBashenSystem
	}
	local ret = self._redPointSystem:getRedPointInfoById(RedPointViewType.Ada_Times, redPointData)

	if next(ret) then
		self._redPointSystem:createRedImgIcon(ret, self._btnOpen, {
			240,
			65
		})
	end
end

function ClubBashenMainMediator:setupUI()
	local view = self:getView()

	self._rewardCell = view:getChildByName("reward_cell")
	self._clickLabel = view:getChildByName("clicklabel")

	self._clickLabel:setLocalZOrder(999999)
	self._clickLabel:setVisible(false)

	self._main = view:getChildByName("main")
	self._leftPanel = self._main:getChildByName("left_bg")
	self._btnOpen = self._main:getChildByName("button_open")
	self._btnRule = self._main:getChildByName("button_rule")
	self._btnRank = self._main:getChildByName("button_rank")
	self._btnReward = self._main:getChildByName("button_reward")
	self._bubble = self._main:getChildByName("pop_bg")
	self._title = self._main:getChildByName("title")
	self._titleImage = self._main:getChildByName("Image_1")
	self._leaveTimeTitle = self._main:getChildByName("leave_time_title")
	self._leaveTime = self._main:getChildByName("leave_times")
	self._skipTitle = self._main:getChildByName("skip_title")
	self._skipBtn = self._main:getChildByName("skip_btn")
	self._labelLeaveTimes = self._main:getChildByName("leave_times")
	self._btnReward = self._leftPanel:getChildByFullName("button_reward_panel.button_reward")

	local textReward = self._leftPanel:getChildByFullName("button_reward_panel.Text")

	textReward:setLocalZOrder(10)

	local starTitle = self._leftPanel:getChildByName("star_title")
	local rewardTitle = self._leftPanel:getChildByName("reward_title")
	local lineGradiantVecT = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 245, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 215, 107, 255)
		}
	}

	starTitle:enablePattern(cc.LinearGradientPattern:create(lineGradiantVecT, {
		x = 0,
		y = -1
	}))
	rewardTitle:enablePattern(cc.LinearGradientPattern:create(lineGradiantVecT, {
		x = 0,
		y = -1
	}))
	self._skipBtn:addTouchEventListener(function(sender, eventType)
		self:onClickSkipAnim(sender, eventType)
	end)

	local textBg = self._leftPanel:getChildByName("text_bg")
	local templateStr = TextTemplate:new(Strings:get("EightPieceText40"))
	local str = templateStr:stringify({
		fontName = TTF_FONT_BOLD
	})
	local richText = ccui.RichText:createWithXML(str, {})

	richText:addTo(textBg):center(textBg:getContentSize()):offset(-10, 0)
	richText:renderContent(340, 0, true)

	self._resultBtnContinue = view:getChildByName("button_continue")
	self._resultBtnReopen = view:getChildByName("button_reopen")
	self._resultBtnClose = view:getChildByName("button_close")
	self._resultLeaveTimePanel = view:getChildByName("leave_time_panel")
	self._resultReopenPanel = view:getChildByName("reopen_panel")
	self._resultSkipPanel = view:getChildByName("skip_panel")
	self._resultCostPanel = view:getChildByName("cost_panel")
end

function ClubBashenMainMediator:refreshBtnRewardAnim()
	local recordList = self._clubBashenSystem:getRecordList()
	local isManualFinish = self._clubBashenSystem:getManualFinish()
	local bubblePanel = self._leftPanel:getChildByFullName("button_reward_panel.Panel_bubble")

	if #recordList > 0 and not isManualFinish then
		if not self._rewardBtnAnim then
			bubblePanel:setVisible(true)

			local btnBg = self._leftPanel:getChildByFullName("button_reward_panel.bg")

			self._btnReward:setScale(1)

			local rewardBtnAnim = cc.MovieClip:create("jianglibao_bashenjiangli")

			rewardBtnAnim:addTo(btnBg):center(btnBg:getContentSize())

			local animBtn = rewardBtnAnim:getChildByName("reward_btn")

			self._btnReward:changeParent(animBtn):center(animBtn:getContentSize()):setName("reward_btn")

			self._rewardBtnAnim = rewardBtnAnim
		end

		local totalFreeCount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BaShen_PackNumber", "content")

		totalFreeCount = totalFreeCount or 5

		if #recordList == totalFreeCount and not self._rewardBtnAnim.redPoint then
			self._rewardBtnAnim.redPoint = RedPoint:createDefaultNode()

			self._rewardBtnAnim.redPoint:setScale(0.8)
			self._rewardBtnAnim.redPoint:addTo(self._rewardBtnAnim):posite(18, 15)
			self._rewardBtnAnim.redPoint:setVisible(true)
		end
	elseif self._rewardBtnAnim then
		bubblePanel:setVisible(false)

		local rewardPanel = self._leftPanel:getChildByFullName("button_reward_panel")

		self._btnReward:setScale(0.8)
		self._btnReward:changeParent(rewardPanel):center(rewardPanel:getContentSize()):offset(10, 3)
		self._rewardBtnAnim:removeFromParent(true)

		self._rewardBtnAnim.redPoint = nil
		self._rewardBtnAnim = nil
	end
end

function ClubBashenMainMediator:setupMainAnim()
	self._mainAnim = cc.MovieClip:create("xunhuandonghua_bashendebaozang")

	self._mainAnim:addTo(self._main):center(self._main:getContentSize())

	self._animDest = self._mainAnim:getChildByName("dest")
	self._animPortrait = self._mainAnim:getChildByName("hero")
	self._animBall = self._mainAnim:getChildByName("qiu")
	self._resultAnim = cc.MovieClip:create("yeqian_bashenbaozangload")

	self._resultAnim:addTo(self:getView(), 20):center(self:getView():getContentSize())
	self._resultAnim:stop()
	self._resultAnim:setVisible(false)

	local nodeAnim = self._resultAnim:getChildByName("node")
	local behindBallPanel = self._animBall:getChildByName("up_panel")
	local frontBallPanel = self._animBall:getChildByName("down_panel")

	self._behindBall1 = behindBallPanel:getChildByName("ball_1")
	self._behindBall2 = behindBallPanel:getChildByName("ball_2")
	self._behindBall3 = behindBallPanel:getChildByName("ball_3")
	self._behindBall4 = behindBallPanel:getChildByName("ball_4")
	self._behindBall5 = behindBallPanel:getChildByName("ball_5")
	self._frontBall1 = frontBallPanel:getChildByName("ball_1")
	self._frontBall2 = frontBallPanel:getChildByName("ball_2")
	self._frontBall3 = frontBallPanel:getChildByName("ball_3")
	self._frontBall4 = frontBallPanel:getChildByName("ball_4")
	self._frontBall5 = frontBallPanel:getChildByName("ball_5")
	self._behindBallBoom = {}
	self._frontBallBoom = {}
	self._behindBallBoom[1] = self._behindBall1:getChildByName("ball")
	self._behindBallBoom[2] = self._behindBall2:getChildByName("ball")
	self._behindBallBoom[3] = self._behindBall3:getChildByName("ball")
	self._behindBallBoom[4] = self._behindBall4:getChildByName("ball")
	self._behindBallBoom[5] = self._behindBall5:getChildByName("ball")
	self._frontBallBoom[1] = self._frontBall1:getChildByName("ball")
	self._frontBallBoom[2] = self._frontBall2:getChildByName("ball")
	self._frontBallBoom[3] = self._frontBall3:getChildByName("ball")
	self._frontBallBoom[4] = self._frontBall4:getChildByName("ball")
	self._frontBallBoom[5] = self._frontBall5:getChildByName("ball")

	self:setBurryBallState(false)

	local animLeftPanel = self._mainAnim:getChildByName("left_panel")
	local animTitle = self._mainAnim:getChildByName("title_panel")
	local animLeaveTimePanel = self._mainAnim:getChildByName("leave_time_panel")

	self._openBtnAnim = self._mainAnim:getChildByName("btn_open")

	local animBtnOpen = self._openBtnAnim:getChildByName("btn_image")
	local animSkipPanel = self._mainAnim:getChildByName("skip_panel")
	local animBtnRank = self._mainAnim:getChildByName("btn_rank")
	local animBtnRule = self._mainAnim:getChildByName("btn_rule")
	local animBubble = self._mainAnim:getChildByName("bubble")
	local animPortrai = self._mainAnim:getChildByName("hero")
	local bashenPic, jsonPath = IconFactory:createRoleIconSpriteNew({
		id = "Model_SP_PNCao",
		frameId = "bustframe9"
	})

	bashenPic:setScale(0.9)
	bashenPic:addTo(animPortrai):offset(60, -60)
	self._leftPanel:changeParent(animLeftPanel):center(animLeftPanel:getContentSize()):offset(0, -20)
	self._btnOpen:changeParent(animBtnOpen):center(animBtnOpen:getContentSize()):offset(0, -2)
	self._btnRule:changeParent(animBtnRule):center(animBtnRule:getContentSize()):offset(0, -20)
	self._btnRank:changeParent(animBtnRank):center(animBtnRank:getContentSize()):offset(0, -20)
	self._bubble:changeParent(animBubble):center(animBubble:getContentSize()):offset(80, 20)
	self._titleImage:changeParent(animTitle):center(animTitle:getContentSize()):offset(150, 16)
	self._title:changeParent(animTitle):center(animTitle:getContentSize()):offset(200, 6)
	self._leaveTimeTitle:changeParent(animLeaveTimePanel):center(animLeaveTimePanel:getContentSize()):offset(20, 0)
	self._labelLeaveTimes:changeParent(animLeaveTimePanel):center(animLeaveTimePanel:getContentSize()):offset(90, 0)
	self._skipTitle:changeParent(animSkipPanel):center(animSkipPanel:getContentSize()):offset(-80, 0)
	self._skipBtn:changeParent(animSkipPanel):center(animSkipPanel:getContentSize()):offset(0, 0)

	self._animGemPos = {}

	self:resetMainAnimInfo()
	self._openBtnAnim:addCallbackAtFrame(100, function(fid, mc)
		self._openBtnAnim:gotoAndPlay(1)
	end)
end

function ClubBashenMainMediator:resetMainAnimInfo(callback, noAnim)
	self._behindBall1:gotoAndPlay(1)
	self._behindBall2:gotoAndPlay(80)
	self._behindBall3:gotoAndPlay(160)
	self._behindBall4:gotoAndPlay(240)
	self._behindBall5:gotoAndPlay(320)
	self._frontBall1:gotoAndPlay(1)
	self._frontBall2:gotoAndPlay(80)
	self._frontBall3:gotoAndPlay(160)
	self._frontBall4:gotoAndPlay(240)
	self._frontBall5:gotoAndPlay(320)
	self._behindBall1:setPlaySpeed(1)
	self._behindBall2:setPlaySpeed(1)
	self._behindBall3:setPlaySpeed(1)
	self._behindBall4:setPlaySpeed(1)
	self._behindBall5:setPlaySpeed(1)
	self._frontBall1:setPlaySpeed(1)
	self._frontBall2:setPlaySpeed(1)
	self._frontBall3:setPlaySpeed(1)
	self._frontBall4:setPlaySpeed(1)
	self._frontBall5:setPlaySpeed(1)

	for i = 1, 5 do
		self._behindBallBoom[i]:gotoAndStop(1)
		self._frontBallBoom[i]:gotoAndStop(1)
	end

	self:setBurryBallState(false)

	if self._gems then
		for _, gem in pairs(self._gems) do
			gem:removeFromParent(true)
		end
	end

	self._gems = {}

	local curMainAnimFrame = self._mainAnim:getCurrentFrame()

	if (curMainAnimFrame >= 300 or curMainAnimFrame == 1) and not noAnim then
		self._mainAnim:gotoAndPlay(1)
		self._mainAnim:addCallbackAtFrame(15, function(fid, mc)
			self._mainAnim:removeCallback(fid)

			if callback then
				callback()
			end
		end)
		self._mainAnim:addCallbackAtFrame(50, function(fid, mc)
			self._mainAnim:stop()
		end)
	else
		self._animBall:setVisible(true)
		self._mainAnim:gotoAndStop(50)
	end

	local isSkipAnim = self._clubBashenSystem:isSkipAnim()

	if isSkipAnim then
		self._skipBtn:setSelected(true)
	else
		self._skipBtn:setSelected(false)
	end

	local leaveOpenCount = self._clubBashenSystem:getLeaveOpenCount()

	if leaveOpenCount <= 0 then
		self._btnOpen:setGray(true)
		self._openBtnAnim:gotoAndStop(101)
	end

	self._labelLeaveTimes:setString(leaveOpenCount)
	self:refreshBubbleContent()
end

function ClubBashenMainMediator:setBurryBallState(showBurry)
	for i = 1, 5 do
		local imgBurry1 = self._behindBallBoom[i]:getChildByName("blurry")
		local imgBurry2 = self._frontBallBoom[i]:getChildByName("blurry")
		local imgNormal1 = self._behindBallBoom[i]:getChildByName("normal")
		local imgNormal2 = self._frontBallBoom[i]:getChildByName("normal")

		imgBurry1:setVisible(showBurry)
		imgBurry2:setVisible(showBurry)
		imgNormal1:setVisible(not showBurry)
		imgNormal2:setVisible(not showBurry)
	end
end

function ClubBashenMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Club_System")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		hasAnim = true,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("BaShen_Title")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ClubBashenMainMediator:setupBubble()
	local function update()
		if self._isAnimRunning then
			return
		end

		local isVisible = self._bubble:isVisible()

		if isVisible then
			self._bubble:setVisible(false)

			return
		end

		self:refreshBubbleContent()
	end

	self._bubbleScheduler = LuaScheduler:getInstance():schedule(update, 3, true)
end

function ClubBashenMainMediator:refreshBubbleContent()
	local contentList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "EightPieceBubbleText", "content") or {}
	local contentIndex = math.random(1, #contentList)
	local content = contentList[contentIndex]
	local text = self._bubble:getChildByName("text")

	text:setString(Strings:get(content))
	self._bubble:setVisible(true)
end

function ClubBashenMainMediator:setupAnnounce()
	self._clubBashenSystem:requestGetAnnounce(true)

	local function updateAnnounceView()
		self._clubBashenSystem:requestGetAnnounce()
	end

	self._announceScheduler = LuaScheduler:getInstance():schedule(updateAnnounceView, 3, false)
end

function ClubBashenMainMediator:refreshAnnounceView(event)
	local data = event:getData()
	local isFirstRequset = data.isFirstRequest
	local announceListview = self._leftPanel:getChildByFullName("announce_bg.announce_listview")

	announceListview:setTouchEnabled(true)

	local announceCellModel = self:getView():getChildByName("announce_cell")

	announceListview:setScrollBarEnabled(false)

	local showAnnounceNum = 3

	local function createAnnounceCell(announceData)
		local announceCell = announceCellModel:clone()

		announceCell:setSwallowTouches(false)

		local quality = ConfigReader:getDataByNameIdAndKey("ItemConfig", announceData.itemId, "Quality")
		local templateStr = TextTemplate:new(Strings:get("EightPieceText1"))
		local itemNameColor = c3bToHtmlColor(GemColor[quality])
		local str = templateStr:stringify({
			name = announceData.nickname,
			num = " " .. announceData.amount .. " ",
			itemname = Strings:get(GemName[quality]),
			itemnamecolor = itemNameColor
		})
		local richText = ccui.RichText:createWithXML(str, {})

		richText:setAnchorPoint(cc.p(0, 0.5))
		richText:addTo(announceCell):posite(4, 23)
		richText:renderContent(320, 0, true)

		local rtSize = richText:getContentSize()

		announceCell:setContentSize(cc.size(375, rtSize.height + 12))
		richText:setPositionY(announceCell:getContentSize().height * 0.5 + 5)
		announceListview:pushBackCustomItem(announceCell)
	end

	local function updateEmptyNotice(announceList)
		local announceEmptyNotice = self._leftPanel:getChildByName("announce_empty_notice")

		if table.nums(announceList) > 0 then
			announceEmptyNotice:setVisible(false)
		else
			announceEmptyNotice:setVisible(true)
		end
	end

	if isFirstRequset then
		local announceList = self._clubBashenSystem:getAnnounceList()
		local announceCount = #announceList

		self._topAnnounceIndex = announceCount

		if announceCount > 0 then
			local showMaxIndex = self._topAnnounceIndex - 2 + showAnnounceNum - 1

			for i = self._topAnnounceIndex - 2, showMaxIndex do
				if i > 0 then
					local announceData = announceList[i]

					createAnnounceCell(announceData)
				end
			end
		end

		updateEmptyNotice(announceList)
	else
		local announceList = self._clubBashenSystem:getAnnounceList()
		local announceCount = #announceList

		if announceCount > self._topAnnounceIndex then
			self._topAnnounceIndex = self._topAnnounceIndex + 1

			local announceData = announceList[self._topAnnounceIndex]

			createAnnounceCell(announceData)
			announceListview:scrollToBottom(0.5, false)

			if announceCount > self._topAnnounceIndex + 1 then
				announceListview:removeItem(1)
			end
		end

		updateEmptyNotice(announceList)
	end
end

function ClubBashenMainMediator:refreshCurReward()
	local rewardPanel = self._leftPanel:getChildByName("reward_panel")

	rewardPanel:removeAllChildren()

	local totalRewards = self._clubBashenSystem:getTotalRewards()
	local cellWidth = self._rewardCell:getContentSize().width
	local cellHeight = self._rewardCell:getContentSize().height
	local rewardEmptyNotice = self._leftPanel:getChildByName("reward_empty_notice")

	if table.nums(totalRewards) > 0 then
		rewardEmptyNotice:setVisible(false)
	else
		rewardEmptyNotice:setVisible(true)
	end

	for k, rewards in pairs(totalRewards) do
		local rewardCell = self._rewardCell:clone()
		local iconBg = rewardCell:getChildByName("icon")
		local numLabel = rewardCell:getChildByName("num")
		local Text_301 = rewardCell:getChildByName("Text_30")

		if not rewards.amount then
			local numStr = 1

			if rewards.amount >= 1000 then
				numStr = string.format(Strings:get("Number_TenThousand", {
					num = rewards.amount / 1000
				}))
			end

			numLabel:setString(rewards.amount)

			local rewardName = ConfigReader:getDataByNameIdAndKey("ItemConfig", rewards.code, "Name")
			local icon = IconFactory:createRewardIcon(rewards, {
				ignoreAnim = true,
				showAmount = false,
				isWidget = true
			})

			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards, {
				swallowTouches = true,
				needDelay = true
			})
			icon:addTo(iconBg):center(iconBg:getContentSize())

			local iconScale = iconBg:getContentSize().width / icon:getContentSize().width

			icon:setScale(iconScale * 1)

			if table.nums(totalRewards) > 3 then
				icon:setScale(iconScale * 0.65)
				numLabel:setPositionX(60)
				Text_301:setPositionX(54)
			else
				numLabel:setPositionX(69.84)
				Text_301:setPositionX(61.39)
			end

			local pos = ((table.nums(totalRewards) > 3 or nil) and {
				{
					x = -15.07,
					y = 29.76
				},
				{
					x = 97.03,
					y = 29.76
				},
				{
					x = 215.12,
					y = 29.76
				},
				{
					x = -15.07,
					y = -2.76
				},
				{
					x = 90.03,
					y = -2.76
				},
				{
					x = 215.12,
					y = -2.76
				}
			})[k]

			rewardCell:addTo(rewardPanel):posite(pos.x, pos.y)
		end
	end

	local orangeGemsNum = self._clubBashenSystem:getGemsNumByQuality(GemQuality.orange)
	local purpleGemsNum = self._clubBashenSystem:getGemsNumByQuality(GemQuality.purple)
	local orangeGemsNumLabel = self._leftPanel:getChildByName("orange_num")
	local purpleGemsNumLabel = self._leftPanel:getChildByName("purple_num")

	orangeGemsNumLabel:setString(orangeGemsNum)
	purpleGemsNumLabel:setString(purpleGemsNum)
end

function ClubBashenMainMediator:skipOpenAnim(gemsQualityList, rewardId)
	self._clubBashenSystem:sortQualityList(gemsQualityList)
	self._animBall:setVisible(false)
	self._bubble:setVisible(false)

	self._isAnimRunning = true

	local touchConstSpeed = 1

	if self._isAddSpeed then
		touchConstSpeed = 3
	end

	local touchLayer = ccui.Layout:create()

	touchLayer:setTouchEnabled(true)
	touchLayer:setContentSize(cc.size(1386, 852))
	touchLayer:addTo(self:getView()):center(self:getView():getContentSize())

	local resultAnim = self._resultAnim

	resultAnim:setVisible(true)
	resultAnim:gotoAndPlay(1)
	resultAnim:setPlaySpeed(1 * touchConstSpeed)

	local animButtonPanel = resultAnim:getChildByName("button_panel")
	local animBtnReopen = animButtonPanel:getChildByName("btn_reopen")
	local animLeaveTimeTitle = animButtonPanel:getChildByName("leave_time_title")
	local animLeaveTime = animButtonPanel:getChildByName("leave_num")
	local animBtnContinue = animButtonPanel:getChildByName("btn_continue")
	local animFreeTimeTitle = animButtonPanel:getChildByName("free_time_title")
	local animFreeTime = animButtonPanel:getChildByName("free_time")

	animBtnReopen:removeAllChildren()
	animLeaveTimeTitle:removeAllChildren()
	animLeaveTime:removeAllChildren()
	animBtnContinue:removeAllChildren()
	animFreeTimeTitle:removeAllChildren()
	animFreeTime:removeAllChildren()
	animButtonPanel:gotoAndPlay(1)
	animButtonPanel:setVisible(false)

	local animRewardPanel = resultAnim:getChildByName("reward_panel")

	animRewardPanel:gotoAndStop(1)

	local numCell = self:getView():getChildByName("num")
	local leaveTimePanel = self._resultLeaveTimePanel:clone()

	leaveTimePanel:addTo(animLeaveTimeTitle):center(animFreeTimeTitle:getContentSize()):offset(60, -5)

	local leaveTimeLabel = leaveTimePanel:getChildByName("leave_times")
	local leaveOpenCount = self._clubBashenSystem:getLeaveOpenCount()

	leaveTimeLabel:setString(leaveOpenCount)

	local function closeResultAnim()
		local tipText = self._resultAnim:getChildByName("tip_text")

		if tipText then
			tipText:removeFromParent(true)
		end

		resultAnim:setVisible(false)
		resultAnim:stop()
		touchLayer:removeFromParent(true)
		self:resetMainAnimInfo()
		self._clickLabel:setVisible(false)
	end

	local function onClickOpen(sender, eventType)
		if self._isAnimRunning then
			return
		end

		if eventType == ccui.TouchEventType.ended then
			closeResultAnim()
		end

		self:onClickOpen(sender, eventType, true)
	end

	local continueNode = TwoLevelViceButton:createWidgetNode()
	local continueBtnWidget = TwoLevelViceButton:new(continueNode, {})

	continueBtnWidget:getButton():addTouchEventListener(function(sender, eventType)
		onClickOpen(sender, eventType)
	end)
	continueBtnWidget:getView():addTo(animBtnContinue, 1):center(animBtnContinue:getContentSize()):offset(-215, 42)
	continueBtnWidget:setButtonName(Strings:get("EightPieceText13"))

	if leaveOpenCount <= 0 then
		continueBtnWidget:getButton():setGray(true)
	end

	animRewardPanel:addCallbackAtFrame(16, function(fid, mc)
		animRewardPanel:removeCallback(fid)

		local rewardBg = animRewardPanel:getChildByName("reward_bg")

		for i = 1, 3 do
			local animIcon = rewardBg:getChildByName("icon_" .. i)
			local animNum = rewardBg:getChildByName("num_" .. i)

			animIcon:removeAllChildren()
			animNum:removeAllChildren()
		end

		local rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")

		if rewards then
			for i, reward in pairs(rewards) do
				local animIcon = rewardBg:getChildByName("icon_" .. i)
				local rewardIcon = IconFactory:createRewardIcon(reward, {
					ignoreAnim = true,
					showAmount = false,
					isWidget = true
				})

				rewardIcon:setScale(0.47)
				rewardIcon:addTo(animIcon):center(animIcon:getContentSize())
				IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), reward, {
					needDelay = true
				})

				local animNum = rewardBg:getChildByName("num_" .. i)
				local num = numCell:clone()

				num:setAnchorPoint(cc.p(0, 0.5))
				num:setString("x" .. reward.amount)
				num:addTo(animNum):center(animNum:getContentSize()):offset(num:getContentSize().width / 2 - 10, 0)
			end
		end
	end)

	local animBall = resultAnim:getChildByName("ball_panel")

	animBall:gotoAndPlay(1)
	animBall:setPlaySpeed(1 * touchConstSpeed)

	local animGem = {}

	for i = 1, 5 do
		animGem[i] = animBall:getChildByName("gems_" .. i)
	end

	local function createGem(index, quality)
		local animGem = animGem[index]

		animGem:removeAllChildren()

		local picPath = GemPath[quality]
		local gemSprite = cc.Sprite:createWithSpriteFrameName(picPath)

		gemSprite:addTo(animGem):center(animGem:getContentSize())

		local animLight

		if quality == GemQuality.purple then
			animLight = cc.MovieClip:create("ziguang_bashenbaozangload")
		elseif quality == GemQuality.orange then
			animLight = cc.MovieClip:create("chengguang_bashenbaozangload")
		end

		if animLight then
			animLight:setScale(1.25)
			animLight:setPlaySpeed(0.5)
			animLight:addTo(animGem):center(animGem:getContentSize()):offset(-15, 20)
		end
	end

	animButtonPanel:addEndCallback(function(fid, mc)
		animButtonPanel:removeCallback(fid)
		animButtonPanel:stop()
	end)
	animBall:addEndCallback(function(fid, mc)
		animBall:removeCallback(fid)
		animBall:stop()
	end)
	resultAnim:gotoAndPlay(16)
	animBall:addCallbackAtFrame(6, function(fid, mc)
		animBall:removeCallback(fid)

		local boomAnim = animBall:getChildByName("boom_1")

		boomAnim:gotoAndPlay(1)
		boomAnim:setPlaySpeed(1 * touchConstSpeed)
		boomAnim:addCallbackAtFrame(21, function()
			createGem(1, gemsQualityList[1])
		end)
		boomAnim:addEndCallback(function(fid, mc)
			boomAnim:stop()
		end)
	end)
	animBall:addCallbackAtFrame(16, function(fid, mc)
		animBall:removeCallback(fid)

		local boomAnim = animBall:getChildByName("boom_2")

		boomAnim:gotoAndPlay(1)
		boomAnim:setPlaySpeed(1 * touchConstSpeed)
		boomAnim:addCallbackAtFrame(21, function()
			createGem(2, gemsQualityList[2])
		end)
		boomAnim:addEndCallback(function(fid, mc)
			boomAnim:stop()
		end)
	end)
	animBall:addCallbackAtFrame(25, function(fid, mc)
		animBall:removeCallback(fid)

		local boomAnim = animBall:getChildByName("boom_3")

		boomAnim:gotoAndPlay(1)
		boomAnim:setPlaySpeed(1 * touchConstSpeed)
		boomAnim:addCallbackAtFrame(21, function()
			createGem(3, gemsQualityList[3])
		end)
		boomAnim:addEndCallback(function(fid, mc)
			boomAnim:stop()
		end)
	end)
	animBall:addCallbackAtFrame(20, function(fid, mc)
		animBall:removeCallback(fid)
		self._clubBashenSystem:playOpenGemsAudio(gemsQualityList[1])
	end)
	animBall:addCallbackAtFrame(37, function(fid, mc)
		animBall:removeCallback(fid)
		self._clubBashenSystem:playOpenGemsAudio(gemsQualityList[2])
	end)
	animBall:addCallbackAtFrame(48, function(fid, mc)
		animBall:removeCallback(fid)
		self._clubBashenSystem:playOpenGemsAudio(gemsQualityList[3])
	end)
	animBall:addCallbackAtFrame(56, function(fid, mc)
		animBall:removeCallback(fid)
		self._clubBashenSystem:playOpenGemsAudio(gemsQualityList[4])
	end)
	animBall:addCallbackAtFrame(68, function(fid, mc)
		animBall:removeCallback(fid)
		self._clubBashenSystem:playOpenGemsAudio(gemsQualityList[5])
	end)
	animBall:addCallbackAtFrame(35, function(fid, mc)
		animBall:removeCallback(fid)

		local boomAnim = animBall:getChildByName("boom_4")

		boomAnim:gotoAndPlay(1)
		boomAnim:setPlaySpeed(1 * touchConstSpeed)
		boomAnim:addCallbackAtFrame(21, function()
			createGem(4, gemsQualityList[4])
		end)
		boomAnim:addEndCallback(function(fid, mc)
			boomAnim:stop()
		end)
	end)
	animBall:addCallbackAtFrame(47, function(fid, mc)
		animBall:removeCallback(fid)

		local boomAnim = animBall:getChildByName("boom_5")

		boomAnim:gotoAndPlay(1)
		boomAnim:setPlaySpeed(1 * touchConstSpeed)
		boomAnim:addCallbackAtFrame(21, function()
			createGem(5, gemsQualityList[5])
		end)
		boomAnim:addEndCallback(function(fid, mc)
			boomAnim:stop()
		end)
	end)
	resultAnim:addCallbackAtFrame(86, function(fid, mc)
		resultAnim:removeCallback(fid)
		animRewardPanel:gotoAndPlay(1)
	end)
	resultAnim:addCallbackAtFrame(105, function(fid, mc)
		animButtonPanel:setVisible(true)
	end)
	animRewardPanel:addEndCallback(function(fid, mc)
		animRewardPanel:removeCallback(fid)
		animRewardPanel:stop()
	end)
	resultAnim:addEndCallback(function(fid, mc)
		resultAnim:removeCallback(fid)
		resultAnim:stop()

		self._isAnimRunning = false
		self._isAddSpeed = false

		if self._touchAddSpeedLayer then
			self._touchAddSpeedLayer:removeFromParent(true)

			self._touchAddSpeedLayer = nil
		end

		local tipText = ccui.Text:create(Strings:get("CUSTOM_WIN_CONTINUE"), TTF_FONT_BOLD, 26)

		tipText:setAnchorPoint(cc.p(0.5, 0))
		tipText:addTo(resultAnim):setName("tip_text"):posite(0, -self._targetFrame.height * 0.5 + 60)
		touchLayer:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				closeResultAnim()

				if leaveOpenCount <= 0 then
					local view = self:getInjector():getInstance("ClubBashenRecordView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}))
				end
			end
		end)
	end)

	if not self._isAddSpeed then
		if self._touchAddSpeedLayer then
			self._touchAddSpeedLayer:removeFromParent(true)

			self._touchAddSpeedLayer = nil
		end

		self._touchAddSpeedLayer = ccui.Layout:create()

		self._touchAddSpeedLayer:setTouchEnabled(true)
		self._touchAddSpeedLayer:setContentSize(cc.size(1386, 852))
		self._touchAddSpeedLayer:addTo(self:getView()):center(self:getView():getContentSize(), 10)
		self._touchAddSpeedLayer:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self._touchAddSpeedLayer:removeFromParent(true)

				self._touchAddSpeedLayer = nil
				touchConstSpeed = 3

				if animBall.setPlaySpeed then
					animBall:setPlaySpeed(1 * touchConstSpeed)
				end

				resultAnim:setPlaySpeed(1 * touchConstSpeed)

				for i = 1, 5 do
					local anim = animBall:getChildByName("boom_" .. i)

					if anim and anim.setPlaySpeed then
						anim:setPlaySpeed(1 * touchConstSpeed)
					end
				end
			end
		end)
	end
end

function ClubBashenMainMediator:runOpenAnim(gemsQualityList, rewardId)
	if not self._isAnimRunning then
		local constSpeed = 1
		local constFrame = 10

		self._isAnimRunning = true

		self._mainAnim:gotoAndPlay(300)
		self._mainAnim:setPlaySpeed(1 * constSpeed)
		self._bubble:setVisible(false)

		function setBallRatateSpeed(speed)
			self._behindBall1:setPlaySpeed(speed)
			self._behindBall2:setPlaySpeed(speed)
			self._behindBall3:setPlaySpeed(speed)
			self._behindBall4:setPlaySpeed(speed)
			self._behindBall5:setPlaySpeed(speed)
			self._frontBall1:setPlaySpeed(speed)
			self._frontBall2:setPlaySpeed(speed)
			self._frontBall3:setPlaySpeed(speed)
			self._frontBall4:setPlaySpeed(speed)
			self._frontBall5:setPlaySpeed(speed)
		end

		setBallRatateSpeed(constFrame * constSpeed)
		self:runDestAndPotraitAnim()
		self._mainAnim:addCallbackAtFrame(321, function(fid, mc)
			self._mainAnim:removeCallback(fid)

			constFrame = 20

			setBallRatateSpeed(constFrame * constSpeed)
			self:setBurryBallState(true)
		end)
		self._mainAnim:addCallbackAtFrame(345, function(fid, mc)
			self._animBall:setVisible(false)
			self._mainAnim:removeCallback(fid)
		end)
		self._mainAnim:addCallbackAtFrame(346, function(fid, mc)
			self._mainAnim:removeCallback(fid)
			self:skipOpenAnim(gemsQualityList, rewardId)
		end)
		self._mainAnim:addEndCallback(function(fid, mc)
			self._mainAnim:removeCallback(fid)
			self._mainAnim:stop()
		end)

		if self._touchAddSpeedLayer then
			self._touchAddSpeedLayer:removeFromParent(true)

			self._touchAddSpeedLayer = nil
		end

		self._touchAddSpeedLayer = ccui.Layout:create()

		self._touchAddSpeedLayer:setTouchEnabled(true)
		self._touchAddSpeedLayer:setContentSize(cc.size(1386, 852))
		self._touchAddSpeedLayer:addTo(self:getView()):center(self:getView():getContentSize(), 10)
		self._touchAddSpeedLayer:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self._touchAddSpeedLayer:removeFromParent(true)

				self._touchAddSpeedLayer = nil
				constSpeed = 2

				self._mainAnim:setPlaySpeed(1 * constSpeed)
				setBallRatateSpeed(constFrame * constSpeed)

				self._isAddSpeed = true
			end
		end)
	end
end

function ClubBashenMainMediator:onClickOpen(sender, eventType, isContinue)
	if eventType == ccui.TouchEventType.began then
		local leaveOpenCount = self._clubBashenSystem:getLeaveOpenCount()

		if leaveOpenCount <= 0 then
			return
		end

		self._openBtnAnim:gotoAndStop(101)
	elseif eventType == ccui.TouchEventType.canceled then
		local leaveOpenCount = self._clubBashenSystem:getLeaveOpenCount()

		if leaveOpenCount <= 0 then
			return
		end

		self._openBtnAnim:gotoAndPlay(1)
	elseif eventType == ccui.TouchEventType.ended then
		local leaveOpenCount = self._clubBashenSystem:getLeaveOpenCount()

		if leaveOpenCount <= 0 then
			local isManualFinish = self._clubBashenSystem:getManualFinish()

			if isManualFinish then
				-- block empty
			end

			AudioEngine:getInstance():playEffect("Se_Click_Open_2", false)

			do
				local view = self:getInjector():getInstance("ClubBashenRecordView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}))
			end

			return
		end

		if isContinue then
			-- block empty
		end

		self._openBtnAnim:gotoAndPlay(1)
		self._clubBashenSystem:requestOpenNewPack(function(data)
			local isSkipAnim = self._clubBashenSystem:isSkipAnim()
			local record = self._clubBashenSystem:clearupRecordData(data)
			local gemsQualityList = record.gemsQualityList
			local rewardId = record.rewardId

			if isSkipAnim then
				self:skipOpenAnim(gemsQualityList, rewardId)
			else
				self:runOpenAnim(gemsQualityList, rewardId)
			end

			self:refreshCurReward()
		end)
	end
end

function ClubBashenMainMediator:onclickReopen(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local leaveDiamondOpenCount = self._clubBashenSystem:getLeaveDiamondReopenCount()

		if leaveDiamondOpenCount <= 0 then
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
			self:dispatch(ShowTipEvent({
				tip = Strings:get("EightPieceText21")
			}))

			return
		end

		local freeReopenCount = self._clubBashenSystem:getFreeReopenCount()

		if freeReopenCount > 0 then
			local index = self._clubBashenSystem:getCurOpenPackIndex()

			self._clubBashenSystem:requestReopenPack(index, function(data)
				AudioEngine:getInstance():playEffect("Se_Click_Goth_DiceOpen", false)

				local record = self._clubBashenSystem:clearupRecordData(data)
				local gemsQualityList = record.gemsQualityList
				local rewardId = record.rewardId
				local isSkipAnim = self._clubBashenSystem:isSkipAnim()

				if isSkipAnim then
					self:skipOpenAnim(gemsQualityList, rewardId)
				else
					self:runOpenAnim(gemsQualityList, rewardId)
				end
			end)
		else
			local outSelf, delegate = self, {}

			function delegate:willClose(popupMediator, data)
				if data.response == "ok" then
					local index = outSelf._clubBashenSystem:getCurOpenPackIndex()

					outSelf._clubBashenSystem:requestReopenPack(index, function(data)
						AudioEngine:getInstance():playEffect("Se_Click_Goth_DiceOpen", false)

						local record = outSelf._clubBashenSystem:clearupRecordData(data)
						local gemsQualityList = record.gemsQualityList
						local rewardId = record.rewardId
						local isSkipAnim = outSelf._clubBashenSystem:isSkipAnim()

						if isSkipAnim then
							outSelf:skipOpenAnim(gemsQualityList, rewardId)
						else
							outSelf:runOpenAnim(gemsQualityList, rewardId)
						end
					end)
				end
			end

			local costNum = self._clubBashenSystem:getDiamondReopenCost()
			local data = {
				title = Strings:get("EightPieceText29"),
				content = Strings:get("EightPieceText28", {
					num = costNum
				}),
				sureBtn = {}
			}
			local view = self:getInjector():getInstance("alertView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data, delegate))
		end
	end
end

function ClubBashenMainMediator:runDestAndPotraitAnim()
	local function runAnim(node)
		local moveBy = cc.MoveBy:create(0.1, cc.p(-30, 20))
		local scaleBy = cc.ScaleBy:create(0.1, 1.1)

		node:runAction(cc.Spawn:create(moveBy, scaleBy))
	end

	runAnim(self._animDest)
	runAnim(self._animPortrait)
	runAnim(self._animBall)
end

function ClubBashenMainMediator:dailyReset()
	self:dismiss()
end

function ClubBashenMainMediator:onClickSkipAnim(sender, eventType)
	if eventType == ccui.CheckBoxEventType.selected then
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
		self._clubBashenSystem:setSkipAnim(not sender:isSelected())
	end
end

function ClubBashenMainMediator:onClickReward(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local view = self:getInjector():getInstance("ClubBashenRecordView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}))
	end
end

function ClubBashenMainMediator:onClickRule(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local view = self:getInjector():getInstance("ClubBashenRuleView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}))
	end
end

function ClubBashenMainMediator:onClickRank(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._clubBashenSystem:requestBashenRank(ClubBashenRankType.kToday, 1, 20, function()
			local view = self:getInjector():getInstance("ClubBashenRankView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}))
		end)
	end
end

function ClubBashenMainMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._isAnimRunning then
			return
		end

		self:dismiss()
	end
end
