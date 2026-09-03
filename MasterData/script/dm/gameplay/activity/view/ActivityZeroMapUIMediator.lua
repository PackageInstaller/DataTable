-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityZeroMapUIMediator.lua

ActivityZeroMapUIMediator = class("ActivityZeroMapUIMediator", DmBaseUI)

ActivityZeroMapUIMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityZeroMapUIMediator:has("_bagSystem", {
	is = "r"
}):injectWith("BagSystem")

local kBtnHandlers = {
	["main.bottomNode.storyBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickStory"
	},
	["main.bottomNode.dice1Btn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickDice1"
	},
	["main.bottomNode.dice2Btn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickDice2"
	},
	["main.bottomNode.tipBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickDesc"
	},
	["main.bottomNode.tipBtn.touchPanel"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickTipTouch"
	},
	["main.tipBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	}
}

function ActivityZeroMapUIMediator:initialize(data)
	super.initialize(self, data)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._titleContent = self._main:getChildByFullName("titleNode.titleContent")
	self._titleBg = self._main:getChildByFullName("titleNode.titleBg")
	self._stageType = self._main:getChildByFullName("titleNode.stageType")
	self._heroNode = self._main:getChildByFullName("titleNode.heroNode")
	self._exploreNum = self._main:getChildByFullName("bottomNode.exploreNum")
	self._hartNum = self._main:getChildByFullName("bottomNode.hartNum")
	self._loadingBar = self._main:getChildByFullName("bottomNode.rewardNode.LoadingBar_2")
	self._itemNode = self._main:getChildByFullName("bottomNode.rewardNode.itemNode")
	self._txt1 = self._main:getChildByFullName("bottomNode.rewardNode.txt1")
	self._txt2 = self._main:getChildByFullName("bottomNode.rewardNode.txt2")
	self._txt3 = self._main:getChildByFullName("bottomNode.rewardNode.txt3")
	self._txt4 = self._main:getChildByFullName("bottomNode.rewardNode.txt4")
	self._touchHero = self._main:getChildByFullName("titleNode.addBg")
	self._tipsTouch = self._main:getChildByFullName("bottomNode.tipBtn.touchPanel")

	self._tipsTouch:setSwallowTouches(false)
	self._tipsTouch:setVisible(false)

	self._dice1Btn = self._main:getChildByFullName("bottomNode.dice1Btn")
	self._dice2Btn = self._main:getChildByFullName("bottomNode.dice2Btn")
end

function ActivityZeroMapUIMediator:enterWithData(data)
	self._parentMediator = data.parent
	self._activityId = data.activityId
	self._activity = data.activity
	self._mapId = data.mapId
	self._map = data.map

	self:initData()
	self:initView()
end

function ActivityZeroMapUIMediator:setupTopInfoWidget()
	local currencyInfo = self._activity:getResourcesBanner()
	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local config = {
		hideLine = true,
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Activity_Zero_UI6")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self._parentMediator:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ActivityZeroMapUIMediator:refreshView(data)
	if data.explorePoint then
		self:refreshExplorePoint()
	end
end

function ActivityZeroMapUIMediator:initData(data)
	return
end

function ActivityZeroMapUIMediator:initView()
	self:setupTopInfoWidget()

	self._activityConfig = self._activity:getActivityConfig()

	self._titleContent:setString(self._map:getMapName())
	self._stageType:setString(Strings:get("Activity_Zero_UI13", {
		num = table.indexof(self._activity:getMapList(), self._mapId)
	}))

	local w = self._titleContent:getContentSize().width
	local w1 = self._titleBg:getContentSize().width

	self._titleBg:setScaleX((w - w1) / w1 + 1 + 0.7)
	self._titleBg:setScaleY(1.4)
	self._stageType:setPositionX(self._titleContent:getPositionX() + w + 5)
	self._touchHero:addTouchEventListener(function(sender, eventType)
		self:onClickAditionButton(sender, eventType)
	end)

	local heroIds = self._activityConfig.BonusHero

	for i = 1, 4 do
		if heroIds[i] then
			local id = heroIds[i]
			local icon = IconFactory:createHeroIconForReward({
				star = 0,
				id = id
			})

			icon:addTo(self._heroNode):center(self._heroNode:getContentSize()):offset((i - 1) * 54 + 4, -2)
			icon:setScale(0.45)

			local image = ccui.ImageView:create("jjc_bg_ts_new.png", 1)

			image:addTo(icon):posite(92, 20):setScale(1.2)
		end
	end

	self._touchHero:setContentSize(cc.size(50 + #heroIds * 54, 55.5))
	self:refreshExplorePoint()
end

function ActivityZeroMapUIMediator:refreshExplorePoint()
	self._exploreNum:setString(Strings:get("Activity_Zero_UI7", {
		num = self._map:getExplorePoint()
	}))
	self._hartNum:setString(Strings:get("Activity_Zero_UI8", {
		num = self._map:getHard(self._activity:getTeam())
	}))

	local ratio = self._map:getExplorePoint() / self._map:getConfig().Point * 100
	local percent = {
		0,
		37.5,
		58,
		78.2
	}
	local posx = {
		0,
		134,
		266,
		400
	}
	local rate = self._map:getRate()

	self._loadingBar:setPercent(percent[#rate])

	local txtStr = ""

	for i = 1, 4 do
		if rate[i] then
			local rewards = ConfigReader:getRecordById("Reward", rate[i].rewardId).Content

			for j = 1, #rewards do
				local rewardIcon = IconFactory:createRewardIcon(rewards[j], {
					isWidget = true
				})

				self._itemNode:addChild(rewardIcon)
				rewardIcon:setAnchorPoint(cc.p(0.5, 0.5))
				rewardIcon:setPosition(cc.p(posx[i], 5))
				rewardIcon:setScaleNotCascade(0.6)
				IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), rewards[j], {
					needDelay = true
				})

				local status = rate[i].status

				if status == ActivityTaskStatus.kGet then
					rewardIcon:setColor(cc.c3b(120, 120, 120))

					local get = ccui.ImageView:create("hd_8r_ylq.png", ccui.TextureResType.plistType)

					get:addTo(self._itemNode):posite(posx[i], 5):setScale(0.8)
				elseif status == ActivityTaskStatus.kFinishNotGet then
					local function callFunc()
						self:getRewardView(rate[i].point)
					end

					mapButtonHandlerClick(nil, rewardIcon, {
						func = callFunc
					})
				end
			end

			local ratio = rate[i].ratio

			if ratio then
				self._loadingBar:setPercent(percent[i] + (percent[i + 1] - percent[i]) * ratio)
			end

			txtStr = rate[i].point
		end

		self["_txt" .. i]:setString(txtStr)
	end

	self._dice1Btn:getChildByName("txt"):setString(self._bagSystem:getItemCount(self._activityConfig.FixedItem))
	self._dice2Btn:getChildByName("txt"):setString(self._bagSystem:getItemCount(self._activityConfig.RollItem))
end

function ActivityZeroMapUIMediator:getRewardView(point)
	self._activity:requestGetPointReward(self._activityId, self._mapId, tostring(point), true, function()
		self:refreshExplorePoint()
	end)
end

function ActivityZeroMapUIMediator:onClickAditionButton(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if not self._activity then
			return
		end

		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

		local rules = self._activityConfig.BonusHeroDesc

		self._activitySystem:showActivityRules(rules)
	end
end

function ActivityZeroMapUIMediator:onClickBack(sender, eventType)
	self._parentMediator:dismiss()
end

function ActivityZeroMapUIMediator:createAttTxt(view, str1, str2, pos)
	local txt = "<outline color='#000000' size = '1'><font face='asset/font/CustomFont_FZYH_M.TTF' size='25' color='#ffffff'>" .. str1 .. "</font><font face='asset/font/CustomFont_FZYH_M.TTF' size='25' color='#A6E31F'>" .. str2 .. "</font></outline>"
	local richTextIndex = ccui.RichText:createWithXML(txt, {})

	richTextIndex:setAnchorPoint(cc.p(0.5, 0.5))
	richTextIndex:setPosition(pos)
	richTextIndex:addTo(view)
	richTextIndex:renderContent()
end

function ActivityZeroMapUIMediator:onClickDesc()
	self._tipsTouch:setVisible(true)

	local bg = self._tipsTouch:getChildByName("backimg")
	local h = bg:getContentSize().height - 75
	local w = bg:getContentSize().width
	local off = 40

	bg:removeAllChildren()

	local cur, next = self._map:getHard(self._activity:getTeam())

	if next == "full" then
		self:createAttTxt(bg, Strings:get("Activity_Zero_UI12"), "", cc.p(w / 2, h))

		return
	end

	self:createAttTxt(bg, Strings:get("Activity_Zero_UI9"), Strings:get("Activity_Zero_UI11", {
		num = cur
	}), cc.p(w / 2, h))
	self:createAttTxt(bg, Strings:get("Activity_Zero_UI10"), Strings:get("Activity_Zero_UI11", {
		num = next
	}), cc.p(w / 2, h - off))
end

function ActivityZeroMapUIMediator:onClickRule()
	local rules = self._activityConfig.RuleDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityZeroMapUIMediator:onClickTipTouch()
	self._tipsTouch:setVisible(false)
end

function ActivityZeroMapUIMediator:onClickStory()
	local view = self:getInjector():getInstance("GalleryMemoryPackView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		type = GalleryMemoryPackType.STORY
	}))
end

function ActivityZeroMapUIMediator:onClickDice1()
	self._parentMediator:onClickDice(ActivityZeroDiceType.KFixed)
end

function ActivityZeroMapUIMediator:onClickDice2()
	self._parentMediator:onClickDice(ActivityZeroDiceType.KRandom)
end

function ActivityZeroMapUIMediator:setMovingStatus(moving)
	self._dice1Btn:setTouchEnabled(not moving)
	self._dice2Btn:setTouchEnabled(not moving)
end
