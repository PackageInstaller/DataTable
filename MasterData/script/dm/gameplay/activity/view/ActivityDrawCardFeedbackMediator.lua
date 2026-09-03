-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityDrawCardFeedbackMediator.lua

ActivityDrawCardFeedbackMediator = class("ActivityDrawCardFeedbackMediator", DmPopupViewMediator)

ActivityDrawCardFeedbackMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityDrawCardFeedbackMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

KBubleEnterStatus = {
	ExchangeEnd = 2,
	ClickHero = 3,
	ClickText = 4,
	FirstEnter = 1
}

local kBtnHandlers = {
	["main.ruleButton"] = {
		ignoreClickAudio = true,
		func = "onClickRule"
	}
}

function ActivityDrawCardFeedbackMediator:initialize()
	super.initialize(self)

	self._initScrollView = false
	self._currentSocreCell = 0
end

function ActivityDrawCardFeedbackMediator:dispose()
	self:stopTimer()

	if self._bannerTimer then
		self._bannerTimer:stop()

		self._bannerTimer = nil
	end

	super.dispose(self)
end

function ActivityDrawCardFeedbackMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ActivityDrawCardFeedbackMediator:enterWithData(data)
	self._activity = data.activity
	self._parentMediator = data.parentMediator

	self:setupView()
end

function ActivityDrawCardFeedbackMediator:resumeView()
	dump("ActivityDrawCardFeedbackMediator:resumeView")
	self:refreshView()
end

function ActivityDrawCardFeedbackMediator:setupView()
	self._main = self:getView():getChildByName("main")
	self._cloneCell = self:getView():getChildByName("cloneCell")

	self._cloneCell:setVisible(false)

	self._bottomCell = self:getView():getChildByName("bottomCell")

	self._bottomCell:setVisible(false)

	self._urlFuncLayout = self._main:getChildByName("URLLayout")

	local activityConfig = self._activity:getActivityConfig()

	self._refreshTime = self._main:getChildByName("timeText")
	self._allScoreText = self._main:getChildByName("allScoreText")

	local allScoreStr = Strings:get("DrawCardFeedback_Actiity_1") .. " " .. tostring(self._activity:getAllScore())

	self._allScoreText:setString(allScoreStr)

	self._titleDesText = self._main:getChildByName("titleDesText")

	local nameId = ConfigReader:getDataByNameIdAndKey("DrawCard", activityConfig.DrawCard[1], "DrawCardName")
	local numStr = tostring(activityConfig.WinPoint)
	local titleStr = Strings:get("DrawCardFeedback_Actiity_2", {
		name = (nameId ~= "" or nil) and Strings:get(nameId),
		num = numStr
	})

	self._titleDesText:setString(titleStr)
	self:createHeroModel()
	self:createScrollView()
	self:setTimer()
	self:initActivityBanner()
end

function ActivityDrawCardFeedbackMediator:refreshScoreText()
	local allScoreStr = Strings:get("DrawCardFeedback_Actiity_1") .. " " .. tostring(self._activity:getAllScore())

	self._allScoreText:setString(allScoreStr)
end

function ActivityDrawCardFeedbackMediator:createHeroModel()
	local activityConfig = self._activity:getActivityConfig()
	local heroNode = self._main:getChildByName("heroNode")

	if activityConfig.ActivityPic ~= nil and activityConfig.ActivityPic ~= "" then
		local imageName = activityConfig.ActivityPic .. ".png"
		local pic = ccui.ImageView:create(imageName, ccui.TextureResType.plistType)

		pic:addTo(heroNode):posite(-140, 0)
	end
end

function ActivityDrawCardFeedbackMediator:createScrollView()
	self._scrollPanel = self._main:getChildByName("scrollPanel")
	self._scrollView = ccui.ScrollView:create()

	self._scrollView:setScrollBarEnabled(true)
	self._scrollView:setContentSize(self._scrollPanel:getContentSize())
	self._scrollView:setScrollBarAutoHideTime(9999)
	self._scrollView:setScrollBarColor(cc.c3b(243, 220, 142))
	self._scrollView:setScrollBarAutoHideEnabled(true)
	self._scrollView:setScrollBarWidth(5)
	self._scrollView:setScrollBarOpacity(255)
	self._scrollView:setScrollBarPositionFromCorner(cc.p(10, 15))
	self._scrollPanel:addChild(self._scrollView)
	self:refreshScrollView()

	local viewHeight = self._scrollView:getContentSize().height

	if self._currentSocreCell > 0 then
		local offset = self._allHeight - viewHeight - 100 * (self._currentSocreCell - 1)

		if offset < 0 then
			offset = 0
		end

		self._scrollView:setInnerContainerPosition(cc.p(0, -offset))
	else
		self._scrollView:setInnerContainerPosition(cc.p(0, 0))
	end
end

function ActivityDrawCardFeedbackMediator:refreshScrollView()
	local offsetY = 10

	if self._initScrollView then
		offsetY = self._scrollView:getInnerContainerPosition().y
	end

	self._scrollView:removeAllChildren()

	local rewardList = self._activity:getRewardList()
	local allHeight = 0
	local oneCellHeight = 100
	local bottomHeight = self:createBottomCell()

	allHeight = allHeight + bottomHeight
	self._cells = {}

	for i = 1, #rewardList do
		local layout = ccui.Layout:create()

		layout:setContentSize(cc.size(676, 150))
		layout:setAnchorPoint(0, 0)
		layout:addTo(self._scrollView)
		layout:setTag(i)
		layout:setPosition(cc.p(0, allHeight))

		allHeight = allHeight + oneCellHeight

		layout:setTouchEnabled(false)

		local oneReward = rewardList[#rewardList - i + 1]

		self:createCell(layout, oneReward, #rewardList - i + 1)
	end

	local viewHeight = self._scrollView:getContentSize().height

	self._scrollView:setInnerContainerSize(cc.size(676, allHeight))

	if offsetY <= 0 then
		self._scrollView:setInnerContainerPosition(cc.p(0, offsetY))
	else
		self._scrollView:setInnerContainerPosition(cc.p(0, -(allHeight - viewHeight)))
	end

	self._initScrollView = true
	self._allHeight = allHeight
end

function ActivityDrawCardFeedbackMediator:createBottomCell()
	local layout = ccui.Layout:create()

	layout:setContentSize(cc.size(676, 150))
	layout:setAnchorPoint(0, 0)
	layout:addTo(self._scrollView)

	local clonePanel = self._bottomCell:clone()

	clonePanel:setVisible(true)
	clonePanel:setAnchorPoint(0, 0)
	clonePanel:setPosition(cc.p(0, 0))
	layout:addChild(clonePanel)

	local per = 0
	local per_Score = 0
	local rewardId = ""
	local oneLevelScore = 0
	local extraRewardList = self._activity:getExtraRewardList()
	local currentReward

	for i = 1, #extraRewardList do
		local oneReward = extraRewardList[i]

		oneLevelScore = oneReward.oneLevelScore

		if oneReward.hasGot < 1 and oneReward.canGain == true then
			per = 100
			per_Score = oneReward.oneLevelScore
			rewardId = oneReward.rewardId
			currentReward = oneReward

			break
		end

		if oneReward.currentBar then
			per = oneReward.per_Score / oneReward.oneLevelScore * 100
			rewardId = oneReward.rewardId
			currentReward = oneReward

			break
		end
	end

	if rewardId == "" then
		per = 0
		per_Score = extraRewardList[1].oneLevelScore
		rewardId = extraRewardList[1].rewardId
		currentReward = extraRewardList[1]
	end

	local loadingBar = clonePanel:getChildByName("LoadingBar_7")

	loadingBar:setPercent(per)

	local remainScore = self._activity:getAllScore() - self._activity:getMaxNomalScore()

	if self._activity:getExtraTimes() > 0 and self._activity:getExtraTimes() <= #extraRewardList then
		remainScore = self._activity:getAllScore() - extraRewardList[self._activity:getExtraTimes()].score
	end

	if remainScore < 0 then
		remainScore = 0
	end

	local bottomScoreText = clonePanel:getChildByName("bottomScoreText")

	bottomScoreText:setString(tostring(remainScore))

	local bottomTitleText = clonePanel:getChildByName("bottomTitleText")
	local bottomTitleStr = Strings:get("DrawCardFeedback_Actiity_7", {
		num = oneLevelScore
	})

	bottomTitleText:setString(bottomTitleStr)

	local limitText = clonePanel:getChildByName("limitText")
	local limitStr = Strings:get("DrawCardFeedback_Actiity_6") .. tostring(self._activity:getExtraTimes()) .. "/" .. tostring(#extraRewardList)

	limitText:setString(limitStr)

	local RewardMap = ConfigReader:getRecordById("Reward", rewardId).Content
	local rewardPanel = clonePanel:getChildByName("rewardPanel")

	rewardPanel:removeAllChildren()

	local posX = 35

	for i = 1, #RewardMap do
		local reward = RewardMap[i]
		local baseRewardNode = cc.Node:create()

		rewardPanel:addChild(baseRewardNode)
		baseRewardNode:setPosition(cc.p(posX, 30))

		posX = posX + 65

		local rewardIcon = IconFactory:createRewardIcon(reward, {
			isWidget = true
		})

		IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), reward, {
			needDelay = true
		})
		baseRewardNode:addChild(rewardIcon)
		rewardIcon:setScaleNotCascade(0.5)

		if self._activity:getExtraTimes() >= #extraRewardList then
			local maskLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 102))

			maskLayer:setContentSize(cc.size(60, 60))
			maskLayer:setTouchEnabled(false)
			maskLayer:setPosition(cc.p(-30, -30))
			maskLayer:addTo(baseRewardNode)

			local mark = ccui.ImageView:create("hd_14r_btn_go.png", ccui.TextureResType.plistType)

			mark:setAnchorPoint(cc.p(0.5, 0.5))
			mark:setScale(0.5)
			baseRewardNode:addChild(mark)
		end
	end

	local gotoBtn = clonePanel:getChildByFullName("gotoBtn")

	gotoBtn:addTouchEventListener(function(sender, eventType)
		self:onClickGoTo(sender, eventType, currentReward)
	end)
	gotoBtn:setSwallowTouches(false)

	local getBtn = clonePanel:getChildByFullName("getBtn")

	getBtn:addTouchEventListener(function(sender, eventType)
		self:onClickGetReward(sender, eventType, currentReward)
	end)
	getBtn:setSwallowTouches(false)

	local animPanel = clonePanel:getChildByFullName("animPanel")

	animPanel:removeAllChildren()

	local doneBtn = clonePanel:getChildByFullName("doneanim")

	if currentReward.canGain then
		doneBtn:setVisible(false)
		getBtn:setVisible(true)
		gotoBtn:setVisible(false)

		local anim = cc.MovieClip:create("xinxin_beibaojinpin")

		anim:addTo(animPanel):center(animPanel:getContentSize())
		anim:setScale(0.6)
	else
		doneBtn:setVisible(false)
		getBtn:setVisible(false)
		gotoBtn:setVisible(true)
	end

	if self._activity:getExtraTimes() >= #extraRewardList then
		doneBtn:setVisible(true)
		getBtn:setVisible(false)
		gotoBtn:setVisible(false)
	end

	return 150
end

function ActivityDrawCardFeedbackMediator:createCell(cell, oneReward, index)
	local clonePanel = self._cloneCell:clone()

	clonePanel:setVisible(true)
	clonePanel:setAnchorPoint(0, 0)
	clonePanel:setPosition(cc.p(0, 0))
	cell:addChild(clonePanel)

	local oneScore = clonePanel:getChildByName("oneScore")

	oneScore:setString(tostring(oneReward.score))

	local lightBar = clonePanel:getChildByName("lightBar")
	local darkBar = clonePanel:getChildByName("darkBar")
	local darkMark = clonePanel:getChildByName("darkMark")
	local frontLight = clonePanel:getChildByName("frontLight")
	local currentLight = clonePanel:getChildByName("currentLight")

	if index == 1 then
		lightBar:setVisible(false)
		darkBar:setVisible(false)
		darkMark:setVisible(false)
		frontLight:setVisible(false)
		currentLight:setVisible(false)

		if oneReward.hasGot > 1 then
			frontLight:setVisible(true)
		elseif oneReward.canGain then
			currentLight:setVisible(true)
		else
			darkMark:setVisible(true)
		end

		if oneReward.hasGot == 0 and oneReward.canGain == false then
			self._currentSocreCell = index
		end
	else
		darkBar:setVisible(true)

		if oneReward.currentBar then
			lightBar:setVisible(true)
			darkMark:setVisible(true)
			frontLight:setVisible(false)
			currentLight:setVisible(false)
			lightBar:setScaleX(oneReward.per_Score / oneReward.oneLevelScore)

			if oneReward.per_Score >= oneReward.oneLevelScore then
				currentLight:setVisible(true)
			end

			self._currentSocreCell = index
		elseif oneReward.hasGot > 1 then
			frontLight:setVisible(true)
			currentLight:setVisible(false)
		elseif oneReward.canGain then
			lightBar:setVisible(true)
			darkBar:setVisible(false)
			darkMark:setVisible(false)
			frontLight:setVisible(false)
			currentLight:setVisible(true)
		else
			lightBar:setVisible(false)
			darkBar:setVisible(true)
			darkMark:setVisible(true)
			frontLight:setVisible(false)
			currentLight:setVisible(false)
		end
	end

	local RewardMap = ConfigReader:getRecordById("Reward", oneReward.rewardId).Content
	local rewardPanel = clonePanel:getChildByName("reward")

	rewardPanel:removeAllChildren()

	local posX = 35

	for i = 1, #RewardMap do
		local reward = RewardMap[i]
		local baseRewardNode = cc.Node:create()

		rewardPanel:addChild(baseRewardNode)
		baseRewardNode:setPosition(cc.p(posX, 30))

		posX = posX + 65

		local rewardIcon = IconFactory:createRewardIcon(reward, {
			isWidget = true
		})

		IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), reward, {
			needDelay = true
		})
		baseRewardNode:addChild(rewardIcon)
		rewardIcon:setScaleNotCascade(0.5)

		if oneReward.hasGot > 1 then
			local maskLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 102))

			maskLayer:setContentSize(cc.size(60, 60))
			maskLayer:setTouchEnabled(false)
			maskLayer:setPosition(cc.p(-30, -30))
			maskLayer:addTo(baseRewardNode)

			local mark = ccui.ImageView:create("hd_14r_btn_go.png", ccui.TextureResType.plistType)

			mark:setAnchorPoint(cc.p(0.5, 0.5))
			mark:setScale(0.5)
			baseRewardNode:addChild(mark)
		end
	end

	local gotoBtn = clonePanel:getChildByFullName("gotoBtn")

	gotoBtn:addTouchEventListener(function(sender, eventType)
		self:onClickGoTo(sender, eventType, oneReward)
	end)
	gotoBtn:setSwallowTouches(false)

	local getBtn = clonePanel:getChildByFullName("getBtn")

	getBtn:addTouchEventListener(function(sender, eventType)
		self:onClickGetReward(sender, eventType, oneReward)
	end)
	getBtn:setSwallowTouches(false)

	local doneBtn = clonePanel:getChildByFullName("doneanim")

	if oneReward.hasGot > 1 then
		doneBtn:setVisible(true)
		getBtn:setVisible(false)
		gotoBtn:setVisible(false)
	elseif oneReward.canGain then
		doneBtn:setVisible(false)
		getBtn:setVisible(true)
		gotoBtn:setVisible(false)
	else
		doneBtn:setVisible(false)
		getBtn:setVisible(false)
		gotoBtn:setVisible(true)
	end
end

function ActivityDrawCardFeedbackMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._refreshPanel then
		self._refreshPanel:setVisible(false)
	end
end

function ActivityDrawCardFeedbackMediator:setTimer()
	self:stopTimer()

	if not self._activity then
		return
	end

	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endMills = self._activity:getEndTime() / 1000

	self._refreshTime:setString(Strings:get("DrawCardFeedback_Actiity_8"))

	if remoteTimestamp < endMills and not self._timer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()

			local endMills = self._activity:getEndTime() / 1000
			local remainTime = endMills - remoteTimestamp

			if math.floor(remainTime) <= 0 then
				self:stopTimer()
				self._refreshTime:setString(Strings:get("DrawCardFeedback_Actiity_8"))

				return
			end

			local fmtStr = "${d}:${H}:${M}:${S}"
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = tonumber(parts[1])
			timeTab.hour = tonumber(parts[2])
			timeTab.min = tonumber(parts[3])
			timeTab.sec = tonumber(parts[4])

			self._refreshTime:setString((timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")) .. Strings:get("DrawCardFeedback_Actiity_5"))
		end

		checkTimeFunc()

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)
	end
end

function ActivityDrawCardFeedbackMediator:onClickRule()
	local rules = self._activity:getActivityConfig().RuleTranslate

	self._activitySystem:showActivityRules(rules)
end

function ActivityDrawCardFeedbackMediator:onClickGetReward(sender, eventType, data)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Get", false)

		if self._isReturn then
			self:onClickGet(data)
		end
	end
end

function ActivityDrawCardFeedbackMediator:onClickGoTo(sender, eventType, data)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Story_Common", false)

		if self._isReturn then
			self:goToRecruitView()
		end
	end
end

function ActivityDrawCardFeedbackMediator:goToRecruitView()
	local activityConfig = self._activity:getActivityConfig()
	local drawCardPool = activityConfig.DrawCard
	local param = {
		recruitId = drawCardPool[1]
	}
	local recruitSystem = self:getInjector():getInstance(RecruitSystem)

	recruitSystem:tryEnter(param)
end

function ActivityDrawCardFeedbackMediator:onClickGet(data)
	local activityId = self._activity:getId()

	self._activitySystem:requestDoActivity(activityId, (data.isExtra or nil) and {
		doActivityType = 102
	}, function(response)
		if checkDependInstance(self) then
			self:onGetRewardCallback(response)
			self:refreshView()
		end
	end)
end

function ActivityDrawCardFeedbackMediator:refreshView()
	self:refreshScoreText()
	self:refreshScrollView()
end

function ActivityDrawCardFeedbackMediator:onGetRewardCallback(response)
	local response = response.data.reward
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		needClick = false,
		rewards = response
	}))
end

function ActivityDrawCardFeedbackMediator:initActivityBanner()
	local view = self._urlFuncLayout:getChildByName("pageView")

	self._animName = {}

	local delegate, outself = {}, self

	function delegate:getPageNum()
		return #outself._animName
	end

	function delegate:getPageByIndex(index)
		return outself:getPageByIndex(index)
	end

	function delegate:pageTouchedAtIndex(index)
		outself:viewTouchEvent(index)
	end

	local data = {
		view = view,
		delegate = delegate
	}

	self:setPageViewIndicator()

	self._flipView = PageViewUtil:new(data)

	self._flipView:reloadData()
	self:enableBannerTimer()
end

function ActivityDrawCardFeedbackMediator:enableBannerTimer()
	if self._bannerTimer then
		self._bannerTimer:stop()

		self._bannerTimer = nil
	end

	if #self._animName > 1 then
		local function bannerTimer()
			self._flipView:scrollToDirection(1, 1)
		end

		self._bannerTimer = LuaScheduler:getInstance():schedule(bannerTimer, 5, false)
	end
end

function ActivityDrawCardFeedbackMediator:setPageViewIndicator()
	self:getBannerAct()

	local pageTipPanel = self._urlFuncLayout:getChildByName("pageTipPanel")

	pageTipPanel:removeAllChildren()

	local width = 0

	for i = 1, #self._animName do
		local img = ccui.ImageView:create("miam_qh_2.png", 1)

		img:setAnchorPoint(cc.p(0.5, 0.5))
		img:setTag(i)
		img:setScale(0.8)
		img:addTo(pageTipPanel)
		img:setPosition(cc.p((img:getContentSize().width + 8) * (i - 1), pageTipPanel:getContentSize().height / 2))

		width = img:getContentSize().width * i
	end

	pageTipPanel:setContentSize(cc.size(width, 14))

	if #self._animName == 0 then
		self._urlFuncLayout:setVisible(false)
	else
		self._urlFuncLayout:setVisible(true)
	end
end

function ActivityDrawCardFeedbackMediator:getBannerAct()
	local _table = self._activitySystem._bannerData

	self._animName = {}

	for _, bannerInfo in pairs(_table) do
		local bannerType = bannerInfo.Type

		if bannerType == ActivityBannerType.kActivity then
			local activityId = bannerInfo.TypeId

			if self._activitySystem:isActivityOpen(activityId) and not self._activitySystem:isActivityOver(activityId) and self:checkInDrawCard(activityId) then
				self._animName[#self._animName + 1] = {
					bannerInfo = bannerInfo,
					id = activityId
				}
			end
		end
	end

	table.sort(self._animName, function(a, b)
		local aSortNum = a.bannerInfo.Sort
		local bSortNum = b.bannerInfo.Sort

		return aSortNum < bSortNum
	end)

	return #self._animName
end

function ActivityDrawCardFeedbackMediator:checkInDrawCard(activityId)
	local result = false
	local activityConfig = self._activity:getActivityConfig()
	local drawCardPool = activityConfig.DrawCardActivity

	for i = 1, #drawCardPool do
		if activityId == drawCardPool[i] then
			result = true

			break
		end
	end

	return result
end

function ActivityDrawCardFeedbackMediator:getPageByIndex(index)
	local animData = self._animName[index]
	local image = "asset/ui/mainScene/" .. animData.bannerInfo.Img
	local pageView = self._urlFuncLayout:getChildByName("pageView")
	local pageTipPanel = self._urlFuncLayout:getChildByName("pageTipPanel")
	local layout = ccui.Layout:create()

	layout:setName("mainLayout")
	layout:setAnchorPoint(cc.p(0, 0))
	layout:setPosition(cc.p(0, 0))
	layout:setContentSize(pageView:getContentSize())

	local image = ccui.ImageView:create(image, ccui.TextureResType.localType)

	image:setScale(0.7)
	image:addTo(layout):center(layout:getContentSize())

	for i = 1, #self._animName do
		local image = i == index and "miam_qh_1.png" or "miam_qh_2.png"

		pageTipPanel:getChildByTag(i):loadTexture(image, ccui.TextureResType.plistType)
	end

	return layout
end

function ActivityDrawCardFeedbackMediator:viewTouchEvent(index)
	local animData = self._animName[index]
	local bannerInfo = animData.bannerInfo
	local bannerType = bannerInfo.Type

	if bannerType == ActivityBannerType.kActivity then
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

		local url = bannerInfo.Link
		local param = {}

		self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
			url = url,
			extParams = param
		}))
	end
end
