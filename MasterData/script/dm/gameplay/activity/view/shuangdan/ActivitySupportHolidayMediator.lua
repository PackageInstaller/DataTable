-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/shuangdan/ActivitySupportHolidayMediator.lua

ActivitySupportHolidayMediator = class("ActivitySupportHolidayMediator", DmAreaViewMediator, _M)

ActivitySupportHolidayMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivitySupportHolidayMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivitySupportHolidayMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")

local kBtnHandlers = {
	["bottom.rewardBtn"] = {
		ignoreClickAudio = true,
		func = "onClickRewardBtn"
	},
	["bottom.rankBtn"] = {
		ignoreClickAudio = true,
		func = "onClickRankBtn"
	},
	["bottom.scoreBtn"] = {
		ignoreClickAudio = true,
		func = "onClickScoreBtn"
	},
	btn_back = {
		clickAudio = "Se_Click_Close_1",
		func = "onClickBack"
	},
	["bottom.ruleBtn"] = {
		clickAudio = "Se_Click_Close_1",
		func = "onClickRule"
	}
}
local statusText1 = {
	[ActivitySupportStatus.Preparing] = Strings:get("Activity_Saga_UI_3"),
	[ActivitySupportStatus.Starting] = "times",
	[ActivitySupportStatus.Ended] = Strings:get("Activity_Saga_UI_4")
}
local itemUseAnimationByQuality = {
	[2] = {
		sound = "Se_Effect_Support_Green",
		effect = "lv_yingyuanyemian"
	},
	[3] = {
		sound = "Se_Effect_Support_Blue",
		effect = "lan_yingyuanyemian"
	},
	[4] = {
		sound = "Se_Effect_Support_Purple",
		effect = "zi_yingyuanyemian"
	},
	[5] = {
		sound = "Se_Effect_Support_Orange",
		effect = "chen_yingyuanyemian"
	}
}

ActivitySupportViewEnter = {
	Main = 2,
	Stage = 1
}

local supportUIConfig = {
	{
		supportRole = "shuandan_scene_yy_hjr.png",
		name = "SingingCompetition_RankReward_UI01",
		supportNameDi = "shuandan_img_yy_hjrqd.png",
		supportAnimName = "red_baimengyingyuan",
		bg = "asset/scene/shuandan_scene_yy_hj.jpg",
		textPattern = {
			cc.c4b(255, 21, 151, 255),
			cc.c4b(152, 0, 79, 255)
		},
		roleList = {
			"shuandan_img_zy_rh1.png",
			"shuandan_img_zy_rh2.png",
			"shuandan_img_zy_rh3.png"
		}
	},
	{
		supportRole = "shuandan_img_yy_bmr.png",
		name = "SingingCompetition_RankReward_UI02",
		supportNameDi = "shuandan_img_yy_bmrqd.png",
		supportAnimName = "white_baimengyingyuan",
		bg = "asset/scene/shuandan_scene_yy_bm.jpg",
		textPattern = {
			cc.c4b(109, 64, 225, 255),
			cc.c4b(223, 84, 238, 255)
		},
		roleList = {
			"shuandan_img_zy_rb1.png",
			"shuandan_img_zy_rb2.png",
			"shuandan_img_zy_rb3.png"
		}
	}
}

function ActivitySupportHolidayMediator:initialize()
	super.initialize(self)
end

function ActivitySupportHolidayMediator:dispose()
	self:disposeView()
	super.dispose(self)
end

function ActivitySupportHolidayMediator:disposeView()
	self:stopTimer()

	if self._addPanel then
		self._addPanel:stopAllActions()
	end

	self:stopEffect()
end

function ActivitySupportHolidayMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_SAGA_SCORE, self, self.updateRedPoint)

	self._main = self:getView():getChildByName("main")
	self._imageBg = self._main:getChildByName("Imagebg")
	self._stagePanel = self._main:getChildByName("stagePanel")
	self._mainPanel = self._main:getChildByName("mainPanel")
	self._addPanel = self._mainPanel:getChildByFullName("addPanel")

	self._addPanel:setVisible(false)

	self._addPanelPosX = self._addPanel:getPositionX()
	self._addPanelPosY = self._addPanel:getPositionY()

	local btns = {
		"scoreBtn",
		"rankBtn",
		"rewardBtn",
		"ruleBtn"
	}

	for i = 1, 4 do
		local lineGradiantVec2 = {
			{
				ratio = 0.3,
				color = cc.c4b(255, 255, 255, 255)
			},
			{
				ratio = 0.7,
				color = cc.c4b(167, 186, 255, 255)
			}
		}
		local lineGradiantDir2 = {
			x = 0,
			y = -1
		}
		local bottomPanel = self:getView():getChildByName("bottom")
		local btn = bottomPanel:getChildByFullName(btns[i])

		btn:getChildByFullName("text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir2))
		btn:getChildByFullName("redPoint"):setVisible(false)

		if i <= 3 then
			AdjustUtils.addSafeAreaRectForNode(btn, AdjustUtils.kAdjustType.Left + AdjustUtils.kAdjustType.Bottom)
		else
			AdjustUtils.addSafeAreaRectForNode(btn, AdjustUtils.kAdjustType.Right + AdjustUtils.kAdjustType.Bottom)
		end
	end
end

function ActivitySupportHolidayMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = self._activity:getResourcesBanner(),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		complexTitle = {
			{
				str = Strings:get("Activity_Saga_UI_35")
			},
			{
				pos = 200,
				str = Strings:get("Activity_Saga_UI_36")
			}
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ActivitySupportHolidayMediator:enterWithData(data)
	self._activityId = data.activityId or ActivityId.kActivityBlockZuoHe
	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_12806")
		}))

		return
	end

	self._enterView = data.enterView or ActivitySupportViewEnter.Stage
	self._heroId = data.heroId or nil

	self:initData()
	self:initView()
	self:updateRedPoint()
	self:playDanmaku()
end

function ActivitySupportHolidayMediator:resumeWithData()
	self:doReset()
end

function ActivitySupportHolidayMediator:refreshView()
	self:doReset()
end

function ActivitySupportHolidayMediator:doReset()
	self:disposeView()

	self._activity = self._activitySystem:getActivityById(self._activityId)

	if not self._activity then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return
	end

	self:initData()
	self:initView()
end

function ActivitySupportHolidayMediator:playDanmaku()
	local data = self._curPeriod.data

	if data.status ~= ActivitySupportStatus.Starting then
		return
	end

	local heroConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Newyeawr_HeroBubbleConfig", "content")
	local totalCount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Newyear_HeroBubbleNum", "content")
	local time = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Newyear_HeroBubbleSpeed", "content")
	local oneCount = math.ceil(totalCount / #heroConfig)
	local danmuList = {}

	for _, heroInfo in pairs(heroConfig) do
		local bubbleList = ConfigReader:getDataByNameIdAndKey("ConfigValue", heroInfo.bubble, "content")

		for i = 1, oneCount do
			local random = math.random(1, #bubbleList)

			if totalCount > #danmuList then
				danmuList[#danmuList + 1] = {
					hero = heroInfo.heroId,
					bubble = bubbleList[random]
				}
			end
		end
	end

	local playList = {}

	local function getDanmuIndex()
		local random = math.random(1, #danmuList)

		if table.nums(playList) >= #danmuList then
			return 0
		end

		if playList[tostring(random)] == nil then
			return random
		else
			return getDanmuIndex()
		end
	end

	for i = 1, totalCount do
		local index = getDanmuIndex()

		playList[tostring(index)] = index

		local danmuInfo = danmuList[index]
		local node = cc.Node:create()
		local random = math.random(1, 7)
		local posY = 150 + random * 50

		node:addTo(self._stagePanel):posite(1336, posY)

		local di = ccui.ImageView:create("common_bg_wjtx.png", ccui.TextureResType.plistType)

		di:addTo(node):posite(0, 0):setScale(0.9)

		local heroPic = RoleFactory:createRolePic(danmuInfo.hero, "battlepic")

		heroPic:addTo(node):posite(0, 0)
		heroPic:setScale(0.3)

		local frame = ccui.ImageView:create("asset/head/Frame_Actitity_Moren.png")

		frame:addTo(node):posite(0, 0):setScale(0.3)

		local text = ccui.Text:create(Strings:get(danmuInfo.bubble), TTF_FONT_FZYH_M, 20)

		text:addTo(node):posite(40, -20)
		text:setAnchorPoint(0, 0.5)
		text:enableOutline(cc.c4b(0, 0, 0, 255), 1)

		local size = text:getContentSize()
		local delay = cc.DelayTime:create(1 * i)
		local move = cc.MoveTo:create(time, cc.p(-100 - size.width, posY))
		local call = cc.CallFunc:create(function()
			node:setVisible(false)
			node:removeFromParent()
		end)

		node:runAction(cc.Sequence:create(delay, move, call))
	end
end

function ActivitySupportHolidayMediator:initData()
	self._config = self._activity:getActivityConfig()
	self._periodsInfo = self._activity:getPeriodsInfo()
	self._periodId = self._periodsInfo.periodId
	self._curPeriod = self._activity:getSupportCurPeriodData()
end

function ActivitySupportHolidayMediator:initView()
	self:updateStageView()
	self:updateMainView()
end

function ActivitySupportHolidayMediator:setTextPattern(text, colors)
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = colors[1]
		},
		{
			ratio = 0.7,
			color = colors[2]
		}
	}

	text:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
end

function ActivitySupportHolidayMediator:updateMainView(index)
	if self._enterView == ActivitySupportViewEnter.Stage then
		return
	end

	if not self._heroId then
		return
	end

	index = index or self._index

	local uiConfig = supportUIConfig[index]

	self._imageBg:loadTexture(uiConfig.bg)
	self._stagePanel:setVisible(false)
	self._mainPanel:setVisible(true)

	local data = self._curPeriod.data

	self._mainPanel:getChildByFullName("Image_di"):loadTexture(uiConfig.supportNameDi, 1)

	local popularity = data.popularity
	local name = self._mainPanel:getChildByFullName("name")
	local popularityValue = self._mainPanel:getChildByFullName("popularityValue")

	popularityValue:setString(Strings:get("Activity_Saga_UI_9"))

	local popularityNum = self._mainPanel:getChildByFullName("popularityNum")

	popularityNum:setString(tostring(popularity[self._heroId]))

	local roleNode = self._mainPanel:getChildByFullName("roleNode")

	roleNode:removeAllChildren()

	local img = ccui.ImageView:create("asset/ui/activity/" .. uiConfig.supportRole)

	img:addTo(roleNode):posite(0, 0)

	self._mainRoleNode = roleNode

	self._mainPanel:getChildByFullName("name"):setString(Strings:get(uiConfig.name))
	self:setTextPattern(self._mainPanel:getChildByFullName("name"), uiConfig.textPattern)
	self:setTextPattern(self._mainPanel:getChildByFullName("popularityValue"), uiConfig.textPattern)
	self:setTextPattern(self._mainPanel:getChildByFullName("popularityNum"), uiConfig.textPattern)

	local clubAddNode = self._mainPanel:getChildByFullName("clubAddNode")
	local num = data.clubAdd[self._heroId] < 0 and 0 or data.clubAdd[self._heroId]

	clubAddNode:getChildByFullName("clubAddValue"):setString(Strings:get("SingingCompetition_Second_UI03", {
		percent = num * 100 .. "%"
	}))
	clubAddNode:getChildByFullName("clubAddBtn"):setTouchEnabled(true)
	clubAddNode:setVisible(false)

	local function callFunc(sender, eventType)
		self:onClickClubAddBtn()
	end

	mapButtonHandlerClick(nil, clubAddNode:getChildByFullName("clubAddBtn"), {
		func = callFunc
	})

	local itemPanel = self._mainPanel:getChildByFullName("itemPanel")

	itemPanel:removeAllChildren()

	self._bagSystem = self._developSystem:getBagSystem()

	local itemAddClone = self._mainPanel:getChildByFullName("itemAddClone")

	itemAddClone:setVisible(false)

	local items = self._activity:getSupportItems()

	for i = 1, #items do
		local rewardData = {
			type = 2,
			amount = self._bagSystem:getItemCount(items[i]),
			code = items[i]
		}
		local icon = IconFactory:createRewardIcon(rewardData, {
			showAmount = true,
			notGray = true,
			isWidget = true
		})

		icon:setAnchorPoint(cc.p(0.5, 0.5))
		icon:setScaleNotCascade(0.75)
		icon:addTo(itemPanel):posite((i - 1) * 113 + 75, 29)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
			needDelay = true
		})

		local function callFunc(sender, eventType)
			self:onClickItemBtn(rewardData)
		end

		mapButtonHandlerClick(nil, icon, {
			func = callFunc
		})
	end

	self._mainPanel:getChildByFullName("itemTipTxt"):setString(Strings:get("SingingCompetition_Second_UI02"))
	self._addPanel:stopAllActions()
	self._addPanel:setVisible(false)

	local supportAnim = self._mainPanel:getChildByName("supportAnim")

	if supportAnim then
		supportAnim:removeFromParent()
	end

	supportAnim = cc.MovieClip:create(uiConfig.supportAnimName)

	supportAnim:addTo(self._mainPanel):center(self._mainPanel:getContentSize()):offset(-4, 145.5):setName("supportAnim")
	popularityValue:setPositionX(name:getPositionX() + name:getContentSize().width + 10)
	popularityNum:setPositionX(popularityValue:getPositionX() + popularityValue:getContentSize().width + 10)
end

function ActivitySupportHolidayMediator:runRoleAction(roleImgList)
	local function action(index)
		local img = roleImgList[index]
		local fadeIn = cc.FadeIn:create(0.5)
		local delay = cc.DelayTime:create(3)
		local fadeOut = cc.FadeOut:create(0.5)
		local callFunc = cc.CallFunc:create(function()
			local index = index + 1 > #roleImgList and 1 or index + 1

			action(index)
		end)

		img:runAction(cc.Sequence:create(fadeIn, delay, cc.Spawn:create(fadeOut, callFunc)))
	end

	action(1)
end

function ActivitySupportHolidayMediator:updateStageView()
	if self._enterView == ActivitySupportViewEnter.Main then
		return
	end

	self._stagePanel:setVisible(true)
	self._mainPanel:setVisible(false)

	local data = self._curPeriod.data

	self._imageBg:loadTexture("asset/scene/shuandan_scene_zy_bg.jpg")

	local timeTxt = statusText1[data.status]

	self._stagePanel:getChildByName("timeValue"):setString(timeTxt)

	if timeTxt == "times" then
		self:setTimer(data.resetTime, "", ActivitySupportStatus.Starting, self._stagePanel:getChildByName("timeValue"))
	end

	local popularity = data.popularity
	local heros = data.heros
	local left = 0
	local right = 0

	for heroId, idx in pairs(heros) do
		local node = self._stagePanel:getChildByName("pkNode" .. idx)

		node:getChildByFullName("popularityValue"):setString(Strings:get("Activity_Saga_UI_9") .. "：" .. tostring(popularity[heroId]))

		left = idx == 1 and popularity[heroId] or left
		right = idx == 2 and popularity[heroId] or right

		local roleNode = node:getChildByFullName("roleNode")

		roleNode:removeAllChildren()

		local roleList = supportUIConfig[idx].roleList
		local hd = self._activity:getHeroDataById(heroId)
		local roleImgList = {}

		for i, v in pairs(roleList) do
			local img = ccui.ImageView:create("asset/ui/activity/" .. v)

			img:addTo(roleNode):posite(0, 0)
			img:setOpacity(0)

			roleImgList[i] = img
		end

		self:runRoleAction(roleImgList)

		local supportBtn = node:getChildByFullName("supportBtn")
		local clubAddBg = node:getChildByFullName("clubAddBg")

		supportBtn:setVisible(false)
		clubAddBg:setVisible(false)

		if data.status == ActivitySupportStatus.Ended and (data.winHeroId ~= heroId or true) then
			-- block empty
		else
			supportBtn:setVisible(true)
			supportBtn:setTouchEnabled(true)

			local function callFunc(sender, eventType)
				if self._curPeriod.data.status ~= ActivitySupportStatus.Starting then
					self:dispatch(ShowTipEvent({
						duration = 0.2,
						tip = Strings:get("Activity_Saga_UI_Tips_1")
					}))
					AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

					return
				end

				self._heroId = heroId

				self:onClickSupport(idx)
			end

			mapButtonHandlerClick(nil, node:getChildByFullName("supportBtn"), {
				func = callFunc
			})

			if data.clubAdd and data.clubAdd[heroId] and data.clubAdd[heroId] > 0 then
				clubAddBg:setVisible(true)

				local clubAddValue = clubAddBg:getChildByFullName("clubAddValue")

				clubAddValue:setString(Strings:get("SingingCompetition_Second_UI03", {
					percent = data.clubAdd[heroId] * 100 .. "%"
				}))
			end

			if idx == 1 then
				self:runAction(roleImgList[1], cc.p(-200, 0), cc.p(30, 0))
				self:runAction(supportBtn, cc.p(-200, 0), cc.p(30, 0))
				self:runAction(node:getChildByFullName("popularityValue"), cc.p(0, 200), cc.p(0, -20))
				self:runAction(clubAddBg, cc.p(-200, 0), cc.p(30, 0))
			else
				self:runAction(roleImgList[1], cc.p(200, 0), cc.p(-30, 0))
				self:runAction(supportBtn, cc.p(200, 0), cc.p(-30, 0))
				self:runAction(node:getChildByFullName("popularityValue"), cc.p(0, 200), cc.p(0, -20))
				self:runAction(clubAddBg, cc.p(200, 0), cc.p(-30, 0))
			end
		end
	end

	local loadingBar = self._stagePanel:getChildByName("LoadingBar_1")

	loadingBar:setScale9Enabled(true)
	loadingBar:setCapInsets(cc.rect(50, 10, 10, 10))

	local ratio = 50

	if left ~= right then
		ratio = left / (left + right) * 100
		ratio = left / (left + right) * 100 > 83.5 and 83.5 or ratio
		ratio = ratio < 16.5 and 16.5 or ratio
	end

	loadingBar:setPercent(ratio)

	if not self._stagePanel.anim then
		local anim = cc.MovieClip:create("main_yingyuanduijue")

		anim:addTo(self._stagePanel):center(self._stagePanel:getContentSize()):offset(-7, -5)
		anim:addCallbackAtFrame(90, function()
			anim:stop()
		end)

		self._stagePanel.anim = anim
	end

	self:runAction(self._stagePanel:getChildByName("Image_6_0_0"), cc.p(0, 200), cc.p(0, -20))
	self:runAction(loadingBar, cc.p(0, 200), cc.p(0, -20))
	self:runAction(self._stagePanel:getChildByName("Image_153"), cc.p(0, 200), cc.p(0, -20))
	self:runAction(self._stagePanel:getChildByName("timeValue"), cc.p(0, 200), cc.p(0, -20))
end

function ActivitySupportHolidayMediator:runAction(node, offset1, offset2)
	local initPos = cc.p(node:getPosition())

	node:setPosition(initPos.x + offset1.x, initPos.y + offset1.y)

	local delay = cc.DelayTime:create(0.1)
	local fadeIn = cc.FadeIn:create(0.3)
	local move1 = cc.MoveTo:create(0.2, cc.p(initPos.x + offset2.x, initPos.y + offset2.y))
	local move2 = cc.MoveTo:create(0.1, initPos)

	node:runAction(cc.Sequence:create(delay, cc.Spawn:create(fadeIn, cc.Sequence:create(move1, move2))))
end

function ActivitySupportHolidayMediator:stopEffect()
	if self._heroEffect then
		AudioEngine:getInstance():stopEffect(self._heroEffect)

		self._heroEffect = nil
	end
end

function ActivitySupportHolidayMediator:setAddShow(_data, _time, _ignoreCallback)
	self._addPanel:stopAllActions()
	self._addPanel:setVisible(true)
	self._addPanel:setPosition(cc.p(self._addPanelPosX, self._addPanelPosY))

	local addTxt = _data.popularity

	if _data.allClubAdd and _data.allClubAdd > 0 then
		addTxt = addTxt .. "(" .. _data.allClubAdd .. ")"
	end

	self._addPanel:getChildByFullName("addTxt1"):setString(Strings:get("Activity_Saga_UI_9") .. "：+" .. addTxt)
	self._addPanel:getChildByFullName("addTxt2"):setString(Strings:get("Activity_Saga_UI_13") .. "：+" .. _data.allScore)
	self._addPanel:getChildByFullName("addTxt1"):enableOutline(cc.c4b(247, 41, 255, 102), 3)
	self._addPanel:getChildByFullName("addTxt2"):enableOutline(cc.c4b(247, 41, 255, 102), 3)
	self._addPanel:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(self._addPanelPosX, self._addPanelPosY + 50)), cc.DelayTime:create(_time or 2), cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		if DisposableObject:isDisposed(self) then
			return
		end

		self._addPanel:setOpacity(255)
		self._addPanel:setVisible(false)
	end)))
end

function ActivitySupportHolidayMediator:setRoleAni(itemId)
	if DisposableObject:isDisposed(self._mainRoleNode) then
		return
	end

	local configitem = ConfigReader:getRecordById("ItemConfig", itemId)

	if configitem and itemUseAnimationByQuality[configitem.Quality] then
		local animStr = itemUseAnimationByQuality[configitem.Quality].effect
		local itemAnim = cc.MovieClip:create(animStr)

		itemAnim:addTo(self._mainRoleNode):posite(0, 50)
		itemAnim:addEndCallback(function(fid, mc)
			mc:stop()
			mc:removeFromParent()
		end)
	end
end

function ActivitySupportHolidayMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end
end

function ActivitySupportHolidayMediator:setTimer(_times, _text, _status, _node, strId)
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endMills = _times * 0.001
	local remainTime = endMills - remoteTimestamp
	local fmtStr = Strings:get("SingingCompetition_Main_UI04")
	local txt = TimeUtil:formatTime(fmtStr, remainTime)

	_node:setString(_text .. txt)

	if remainTime > 0 and not self._timer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()
			remainTime = endMills - remoteTimestamp

			if remainTime <= 0 then
				self:stopTimer()

				local params = {
					doActivityType = 101
				}

				self._activitySystem:requestDoActivity(self._activity:getId(), params, function(response)
					self._activity:synchronizePeriodsInfo(response.data)

					if DisposableObject:isDisposed(self) then
						return
					end

					self:refreshView()
				end)

				return
			end

			local txt = TimeUtil:formatTime(fmtStr, remainTime)

			_node:setString(_text .. txt)
		end

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	end
end

function ActivitySupportHolidayMediator:onClickItemBtn(_data)
	if not _data then
		return
	end

	if _data.amount < 1 then
		local param = {
			needNum = 1,
			isNeed = true,
			hasWipeTip = true,
			itemId = _data.code,
			hasNum = _data.amount
		}
		local view = self:getInjector():getInstance("sourceView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, param))
	elseif _data.amount > 1 then
		local data = {
			selectType = SelectItemType.kForUse,
			title = Strings:get("UITitle_CH_Piliangshiyong"),
			title1 = Strings:get("UITitle_EN_Piliangshiyong"),
			entryId = _data.code,
			callBackFuncx = function(_, _count)
				self:useItemCallBack(_data, _count)
			end
		}

		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

		local bagBatchUseSellMediator = self:getInjector():getInstance("ActivitySagaBatchUseSellView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bagBatchUseSellMediator, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, nil))
	else
		self:useItemCallBack(_data, 1)
	end
end

function ActivitySupportHolidayMediator:useItemCallBack(_data, _count)
	local data = {
		doActivityType = 102,
		itemId = _data.code,
		count = _count,
		heroId = self._heroId
	}

	self._activitySystem:requestDoActivity(self._activity:getId(), data, function(response)
		if not response.data then
			return
		end

		if response.data.periods then
			self._activity:synchronizePeriodsInfo(response.data.periods)
		end

		if DisposableObject:isDisposed(self) then
			return
		end

		self:refreshView()
		self:setBuyEndAni(_data.code, response.data, 2)
		self:dispatch(Event:new(EVT_ACTIVITY_SAGA_SCORE))

		if response.data.buffFull then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("Activity_Saga_UI_buffFull")
			}))
		end
	end)
end

function ActivitySupportHolidayMediator:setBuyEndAni(itemId, data, times)
	self:setAddShow(data, times)
	self:setRoleAni(itemId)
end

function ActivitySupportHolidayMediator:onClickSupport(index)
	self:stopTimer()

	self._enterView = ActivitySupportViewEnter.Main
	self._index = index

	self:updateMainView(index)

	local hd = self._activity:getHeroDataById(self._heroId)

	AudioEngine:getInstance():playEffect("Se_Alert_Equip_Powerup", false)
end

function ActivitySupportHolidayMediator:onClickClubAddBtn()
	local data = {
		doActivityType = 104
	}

	self._activitySystem:requestDoActivity(self._activity:getId(), data, function(response)
		if not response.data then
			return
		end

		local list = {}

		if not response.data[self._heroId] then
			for key, value in pairs(response.data[self._heroId]) do
				list[#list + 1] = value
			end

			table.sort(list, function(a, b)
				return a.score > b.score
			end)
			AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

			local view = self:getInjector():getInstance("ActivitySagaSupportClubView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				data = list
			}))
		end
	end)
end

function ActivitySupportHolidayMediator:onClickRewardBtn()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local view = self:getInjector():getInstance("ActivitySupportRewardHolidayView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		activityId = self._activityId
	}))
end

function ActivitySupportHolidayMediator:onClickRankBtn()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local view = self:getInjector():getInstance("ActivitySagaSupportRankView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		periodId = self._periodId,
		activityId = self._activityId
	}))
end

function ActivitySupportHolidayMediator:onClickScoreBtn()
	local data = self._curPeriod.data

	if data.status == ActivitySupportStatus.Ended then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Activity_Saga_UI_15")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local view = self:getInjector():getInstance("ActivitySagaSupportScoreRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		activity = self._activity
	}))
end

function ActivitySupportHolidayMediator:onClickRule()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local rules = self._activity:getActivityConfig().RuleDesc
	local timeFactor = self._activity:getConfig().TimeFactor
	local start = TimeUtil:parseDateTime({}, timeFactor.start[1])
	local startTs = TimeUtil:timeByRemoteDate(start)
	local periodId = self._activity:getActivityConfig().ActivitySupportId[1]
	local periodCfg = ConfigReader:getRecordById("ActivitySupport", periodId)
	local startTime = startTs + periodCfg.PrepareTime
	local endTime = startTs + periodCfg.PrepareTime + periodCfg.Time
	local param = {
		startTime = TimeUtil:localDate("%Y.%m.%d %H:%M", startTime),
		endTime = TimeUtil:localDate("%Y.%m.%d %H:%M", endTime)
	}

	self._activitySystem:showActivityRules(rules, nil, param)
end

function ActivitySupportHolidayMediator:onClickBack(sender, eventType)
	if self._enterView == ActivitySupportViewEnter.Stage then
		self:dismiss()
	end

	if self._enterView == ActivitySupportViewEnter.Main then
		self._enterView = ActivitySupportViewEnter.Stage

		self:updateStageView()
	end
end

function ActivitySupportHolidayMediator:updateRedPoint()
	if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self:getView()) then
		return
	end

	local status = self._activity:getSupportScoreRewardRedPoint()

	self:getView():getChildByFullName("bottom.scoreBtn.redPoint"):setVisible(status)
end
