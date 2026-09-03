-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/view/ArenaMediator.lua

KLevelIcon = {
	["0"] = "jjc_bg_dwd_2.png",
	["7"] = "jjc_bg_dw_7.png",
	["6"] = "jjc_bg_dw_6.png",
	["2"] = "jjc_bg_dw_2.png",
	["5"] = "jjc_bg_dw_5.png",
	["1"] = "jjc_bg_dw_1.png",
	["3"] = "jjc_bg_dw_3.png",
	["4"] = "jjc_bg_dw_4.png"
}
KLevelName = {
	["1"] = Strings:get("Arena_Rank_Qingtong"),
	["2"] = Strings:get("Arena_Rank_Baiyin"),
	["3"] = Strings:get("Arena_Rank_Huangjin"),
	["4"] = Strings:get("Arena_Rank_Zuanshi"),
	["5"] = Strings:get("Arena_Rank_Bojin"),
	["6"] = Strings:get("Arena_Rank_Zongshi"),
	["7"] = Strings:get("Arena_Rank_Wangzhe"),
	["0"] = Strings:get("Arena_Text_None") .. Strings:get("Arena_Title1_Rank")
}
KLevelColor = {
	["1"] = {
		cc.c4b(255, 255, 255, 255),
		cc.c4b(170, 183, 171, 255),
		cc.c4b(0, 0, 0, 219.29999999999998),
		2
	},
	["2"] = {
		cc.c4b(255, 255, 255, 255),
		cc.c4b(189, 165, 141, 255),
		cc.c4b(0, 0, 0, 219.29999999999998),
		2
	},
	["3"] = {
		cc.c4b(255, 255, 255, 255),
		cc.c4b(241, 220, 125, 255),
		cc.c4b(0, 0, 0, 219.29999999999998),
		2
	},
	["4"] = {
		cc.c4b(255, 255, 255, 255),
		cc.c4b(241, 220, 125, 255),
		cc.c4b(0, 0, 0, 219.29999999999998),
		2
	},
	["5"] = {
		cc.c4b(255, 255, 255, 255),
		cc.c4b(213, 141, 116, 255),
		cc.c4b(0, 0, 0, 219.29999999999998),
		2
	},
	["6"] = {
		cc.c4b(255, 255, 255, 255),
		cc.c4b(254, 255, 179, 255),
		cc.c4b(0, 0, 0, 219.29999999999998),
		2
	},
	["7"] = {
		cc.c4b(255, 255, 255, 255),
		cc.c4b(254, 255, 179, 255),
		cc.c4b(0, 0, 0, 219.29999999999998),
		2
	},
	["0"] = {
		cc.c4b(255, 255, 255, 255),
		cc.c4b(0, 0, 0, 255),
		1
	}
}

require("dm.gameplay.arena.view.component.ArenaRoleInfoCell")

ArenaMediator = class("ArenaMediator", DmAreaViewMediator, _M)

ArenaMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ArenaMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
ArenaMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ArenaMediator:has("_arenaSystem", {
	is = "r"
}):injectWith("ArenaSystem")
ArenaMediator:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")
ArenaMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

local ArenaNumReward = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_NumReward", "content")
local ArenaFirstNumReward = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_FirstNumReward", "content")
local kArenaTimeCoin = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_ItemUse", "content")
local kArenaTimeCoinMax = ConfigReader:getDataByNameIdAndKey("ItemConfig", kArenaTimeCoin, "MaxPile")
local kArenaCoin = CurrencyIdKind.kHonor
local kBtnHandlers = {
	["main.bg_bottom.button_team"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickTeam"
	},
	["main.bg_bottom.button_recruit"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickRecruit"
	},
	["main.bg_bottom.button_award"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickAward"
	},
	["main.bg_bottom.button_report"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickReport"
	},
	button_rule = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	},
	["main.refreshNode.button"] = {
		ignoreClickAudio = true,
		func = "onClickRefresh"
	}
}
local firstBoxRewardImg = {
	{
		"rcc_baoxiang",
		"rca_baoxiang",
		"baoxiang_3_3.png"
	},
	{
		"rdc_baoxiang",
		"rda_baoxiang",
		"baoxiang_4_3.png"
	},
	{
		"rec_baoxiang",
		"rea_baoxiang",
		"baoxiang_5_3.png"
	}
}
local ArenaTeamType = {
	StageTeamType.ARENA_ATK,
	StageTeamType.ARENA_DEF
}

function ArenaMediator:initialize()
	super.initialize(self)
end

function ArenaMediator:getRewardInfo()
	self._winReward = self._arenaSystem:getArena():getFirstReward()

	local awards = {}

	for i, v in pairs(self._winReward) do
		local data = {
			num = tonumber(i),
			rewardId = v,
			first = self._winReward[i] == ArenaFirstNumReward[i]
		}

		table.insert(awards, data)
	end

	table.sort(awards, function(a, b)
		return a.num < b.num
	end)

	self._rewardInfo = {}

	for i = 1, 3 do
		awards[i].icon = awards[i].first and "icon_zuanshi_1.png" or firstBoxRewardImg[i]

		table.insert(self._rewardInfo, awards[i])
	end
end

function ArenaMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._cellList then
		for k, v in pairs(self._cellList) do
			v:dispose()

			v = nil
		end

		self._cellList = {}
	end

	super.dispose(self)
end

function ArenaMediator:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()
	self._systemKeeper = self:getInjector():getInstance(SystemKeeper)
	self._customDataSystem = self:getInjector():getInstance(CustomDataSystem)
	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function ArenaMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ARENA_SYNC_DIFF, self, self.updateView)
end

function ArenaMediator:updateView(event)
	self:updateTime()
	self:createTableView()
	self:refreshProgress()
end

function ArenaMediator:resumeWithData()
	self:refreshTeamRed()
	self._arenaSystem:requestArenaInfo()
	self:showGetReward()
	self:setupClickEnvs()
end

function ArenaMediator:refreshTeamRed()
	local redPoint = self._buttonTeam:getChildByFullName("redPoint")
	local maxTeamPetNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum", "content") + self._developSystem:getBuildingCardEffValue()
	local costLimit = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()
	local teamList = {}

	for i, v in ipairs(ArenaTeamType) do
		local team = self._developSystem:getSpTeamByType(v)

		teamList[i] = team

		if v == StageTeamType.ARENA_ATK then
			self._combatPanel:getChildByFullName("combat_number"):setString(team:getCombat())
		end
	end

	local isShow = false

	for i, v in ipairs(ArenaTeamType) do
		local data = teamList[i]
		local ids = data:getHeroes()
		local totalCost = 0

		for k, vv in pairs(ids) do
			local heroInfo = self._heroSystem:getHeroById(vv)

			totalCost = totalCost + heroInfo:getCost()
		end

		local petList = self._stageSystem:getNotOnTeamPet(data:getHeroes())

		if maxTeamPetNum > #ids then
			for i = 1, #petList do
				local cost = self._heroSystem:getHeroById(petList[i]):getCost()

				if costLimit > totalCost + cost then
					isShow = true

					break
				end
			end
		end
	end

	redPoint:setVisible(isShow)
end

function ArenaMediator:enterWithData(data)
	data = data or {}

	if data.ignoreRefresh then
		self._arenaSystem:requestArenaInfo()
		self:showGetReward()
	end

	data.ignoreRefresh = true
	self._canRefresh = true

	self:setupView()
	self:setupClickEnvs()
end

function ArenaMediator:setupView()
	self:setupTopInfoWidget()
	self:initWidgetInfo()
	self:createTableView()
	self:updateTime()
	self:refreshProgress()
	self:refreshTeamRed()
end

function ArenaMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Arena_System")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("ARENA_TITLE")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)

	local button_rule = self:getView():getChildByFullName("button_rule")

	button_rule:setPositionX(self._topInfoWidget:getTitleWidth() + 25)
end

function ArenaMediator:initWidgetInfo()
	self._mainPanel = self:getView():getChildByName("main")
	self._progressPanel = self._mainPanel:getChildByName("progressPanel")
	self._seasonPanel = self._mainPanel:getChildByName("seasonPanel")
	self._button = self._mainPanel:getChildByFullName("refreshNode.button")
	self._timeNode = self._mainPanel:getChildByFullName("bg_bottom.timesNode")
	self._coinNode = self._mainPanel:getChildByFullName("bg_bottom.coinNode")
	self._rankNode = self._mainPanel:getChildByFullName("bg_bottom.rankNode")
	self._combatPanel = self._mainPanel:getChildByFullName("bg_bottom.combatPanel")
	self._buttonTeam = self._mainPanel:getChildByFullName("bg_bottom.button_team")

	local times = self._timeNode:getChildByFullName("text_0")

	times:setContentSize(cc.size(85, 40))

	local times = self._coinNode:getChildByFullName("times")

	times:setContentSize(cc.size(85, 40))

	local times = self._rankNode:getChildByFullName("times")

	times:setContentSize(cc.size(85, 40))

	self._levelPanel = self._mainPanel:getChildByFullName("levelPanel")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		local button_award = self._mainPanel:getChildByFullName("bg_bottom.button_award")
		local button_recruit = self._mainPanel:getChildByFullName("bg_bottom.button_recruit")
		local button_report = self._mainPanel:getChildByFullName("bg_bottom.button_report")

		self._buttonTeam:setPositionX(770)
		button_award:setPositionX(862)
		button_recruit:setPositionX(945)
		self._buttonTeam:getChildByFullName("text"):setFontSize(14)
		button_recruit:getChildByFullName("text"):setFontSize(14)
		button_award:getChildByFullName("text"):setFontSize(14)
		button_report:getChildByFullName("text"):setFontSize(14)
	end

	local seasonData = self._arenaSystem:getSeasonData()
	local seasonSkillData = self._arenaSystem:getCurSeasonSkillData()
	local arenaSeasonData = self._arenaSystem:getCurSeasonData()
	local seasonTitle = self._seasonPanel:getChildByName("seasonTitle")
	local seasonInfo = self._seasonPanel:getChildByName("seasonInfo")
	local seasonTime = self._seasonPanel:getChildByName("seasonTime")

	seasonTitle:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	seasonInfo:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local seasonTitleText = Strings:get(arenaSeasonData.SeasonTitle)

	seasonTitle:setString(seasonTitleText)
	seasonInfo:setString("")

	local richText = ccui.RichText:createWithXML("", {})

	richText:setAnchorPoint(seasonInfo:getAnchorPoint())
	richText:setPosition(cc.p(seasonInfo:getPosition()))
	richText:addTo(seasonInfo:getParent())

	local text = Strings:get(seasonSkillData.Desc, {
		fontSize = 24,
		fontName = TTF_FONT_FZYH_R
	})

	richText:setString(text)

	local startTime, endTime = self._arenaSystem:getSeasonTime()

	seasonTime:setString(Strings:get("Arena_SeasonTimeTitle") .. startTime .. "-" .. endTime)

	local textRule = Strings:get(seasonSkillData.Desc, {
		fontSize = 18,
		fontName = TTF_FONT_FZYH_R
	})

	self.seasonDataForRule = {
		level = "",
		topic = seasonTitleText,
		starttime = startTime,
		endtime = endTime,
		buff = textRule
	}

	local icon = self._timeNode:getChildByName("icon")
	local coin = IconFactory:createResourcePic({
		id = kArenaTimeCoin
	})

	coin:addTo(icon)
	coin:setScale(1.2)

	local textLimit = self._timeNode:getChildByName("textLimit")

	textLimit:setString("/" .. kArenaTimeCoinMax)

	local icon = self._coinNode:getChildByName("icon")
	local coin = IconFactory:createResourcePic({
		id = kArenaCoin
	})

	coin:addTo(icon)
	self._button:getChildByName("name"):setString(Strings:get("Arena_UI73"))

	local lineGradiantVec1 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(130, 120, 110, 255)
		}
	}

	self._combatPanel:getChildByFullName("combat_number"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

	local lineGradiantVec1 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(167, 186, 255, 255)
		}
	}
	local bottomPanel = self._mainPanel:getChildByFullName("bg_bottom")

	bottomPanel:getChildByFullName("button_team.text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))
	bottomPanel:getChildByFullName("button_recruit.text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))
	bottomPanel:getChildByFullName("button_award.text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))
	bottomPanel:getChildByFullName("button_report.text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))
	GameStyle:setCommonOutlineEffect(self._mainPanel:getChildByFullName("bg_bottom.button_team.text"))
	GameStyle:setCommonOutlineEffect(self._mainPanel:getChildByFullName("bg_bottom.button_recruit.text"))
	GameStyle:setCommonOutlineEffect(self._mainPanel:getChildByFullName("bg_bottom.button_award.text"))
	GameStyle:setCommonOutlineEffect(self._mainPanel:getChildByFullName("bg_bottom.button_report.text"))

	local bg = self._mainPanel:getChildByFullName("bg")
	local jingjichang = cc.MovieClip:create("jingjichang_jingjichang")

	jingjichang:addEndCallback(function()
		jingjichang:stop()
	end)
	jingjichang:addTo(bg):center(bg:getContentSize())
end

function ArenaMediator:createTableView()
	self._currentWinTimes = 0
	self._cellList = {}

	local scrollLayer = self._mainPanel:getChildByFullName("rolePanel")

	scrollLayer:removeAllChildren()

	for i = 1, 10 do
		local roleInfoCell = ArenaRoleInfoCell:new({
			mediator = self
		})

		self._cellList[#self._cellList + 1] = roleInfoCell

		local nodeview = roleInfoCell:getView()

		nodeview:addTo(scrollLayer)

		if i <= 5 then
			if not (208 * (i - 1)) then
				local posX = 208 * (i - 6)
				local posY = i <= 5 and 149 or -5

				nodeview:setPosition(cc.p(posX + 10, posY))

				local rival = self._arenaSystem:getRivalByIndex(i)

				roleInfoCell:RefreshRoleInfo(rival)

				local status = rival:getStatus()
				local touchPanel = nodeview:getChildByFullName("bg.roleNode")

				touchPanel:setTouchEnabled(status ~= ArenaBattleStatus.kWinBattle)
				touchPanel:addClickEventListener(function()
					self:onClickFight(i, rival)
				end)

				if status == ArenaBattleStatus.kWinBattle then
					self._currentWinTimes = self._currentWinTimes + 1
				end
			end
		end
	end
end

function ArenaMediator:updateTime()
	local remainTimes = self._bagSystem:getItemCount(kArenaTimeCoin)
	local rank = self._arenaSystem:getMyRank()
	local text = self._timeNode:getChildByName("text")

	text:setString(remainTimes)

	local count = self._arenaSystem:getTotalExtra()
	local text = self._coinNode:getChildByName("text")

	text:setString(count)

	local text = self._rankNode:getChildByName("text")

	text:setString(rank)

	local remoteTimestamp = self._arenaSystem:getCurrentTime()

	self._refreshTime = self._arenaSystem:getRefreshTime()

	if remoteTimestamp < self._refreshTime and not self._timer then
		self._canRefresh = false

		local function checkTimeFunc()
			remoteTimestamp = self._arenaSystem:getCurrentTime()

			local remainTime = self._refreshTime - remoteTimestamp

			if remainTime <= 0 then
				self._canRefresh = true

				self._timer:stop()

				self._timer = nil

				self._button:getChildByName("name"):setString(Strings:get("Arena_UI73"))

				return
			end

			local time = TimeUtil:formatTime("${MM}:${SS}", remainTime)

			self._button:getChildByName("name"):setString(time)
		end

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	end

	self:setLevelPanel()
end

function ArenaMediator:setLevelPanel()
	local count = self._arenaSystem:getTotalExtra()
	local rank, info = self._arenaSystem:getRank()
	local type = rank
	local levelIcon = self._levelPanel:getChildByFullName("levelIcon")

	levelIcon:loadTexture(KLevelIcon[tostring(type)], 1)

	local levelText = self._levelPanel:getChildByFullName("levelText")

	if type ~= 0 then
		levelText:setString(Strings:get(info.Name))

		local lineGradiantVec2 = {
			{
				KLevelColor[tostring(type)][1],
				ratio = 1
			},
			{
				KLevelColor[tostring(type)][2],
				ratio = 1
			}
		}

		levelText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
			x = 0,
			y = -1
		}))
		levelText:enableOutline(KLevelColor[tostring(type)][3], KLevelColor[tostring(type)][4])
	else
		levelText:setString(KLevelName[tostring(type)])
		levelText:setTextColor(KLevelColor[tostring(type)][1])
		levelText:enableOutline(KLevelColor[tostring(type)][2], KLevelColor[tostring(type)][3])
	end

	self.seasonDataForRule.level = levelText:getString()
end

function ArenaMediator:refreshProgress()
	self:getRewardInfo()

	local numLabel = self._progressPanel:getChildByName("num")

	numLabel:setString(self._currentWinTimes)

	local loadingBar = self._progressPanel:getChildByName("loadingBar")

	loadingBar:setScale9Enabled(true)
	loadingBar:setCapInsets(cc.rect(1, 1, 1, 1))

	local percent = 0
	local num1 = self._rewardInfo[1].num
	local num2 = self._rewardInfo[2].num
	local num3 = self._rewardInfo[3].num
	local PercentMap = {
		[num1] = 36,
		[num2] = 69,
		[num3] = 100
	}

	local function getPercent(recruitTimes)
		if PercentMap[recruitTimes] then
			return PercentMap[recruitTimes]
		end

		if recruitTimes < num1 then
			percent = PercentMap[num1] * recruitTimes / num1
		elseif recruitTimes > num1 and recruitTimes < num2 then
			percent = (PercentMap[num2] - PercentMap[num1]) * (recruitTimes - num1) / (num2 - num1) + PercentMap[num1]
		elseif recruitTimes > num2 and recruitTimes < num3 then
			percent = (PercentMap[num3] - PercentMap[num2]) * (recruitTimes - num2) / (num3 - num2) + PercentMap[num2]
		elseif recruitTimes > num3 then
			percent = 100
		end

		return percent
	end

	percent = getPercent(self._currentWinTimes)

	loadingBar:setPercent(percent)

	for i = 1, #self._rewardInfo do
		local data = self._rewardInfo[i]
		local status = self._currentWinTimes >= data.num
		local node = self._progressPanel:getChildByName("node_" .. i)
		local iconPanel = node:getChildByName("icon")

		iconPanel:removeAllChildren()

		local got = node:getChildByName("got")

		got:setVisible(status)
		iconPanel:setGray(status)

		local animName = data.icon

		if status then
			if data.first then
				local child = ccui.ImageView:create(animName, 1)

				child:addTo(iconPanel):center(iconPanel:getContentSize())
				child:setScale(0.5)
				child:offset(5, 5)
			else
				local child = ccui.ImageView:create(animName[3], 1)

				child:addTo(iconPanel):center(iconPanel:getContentSize())
				child:setScale(0.9)
				child:offset(0, 5)
			end
		elseif data.first then
			local child = ccui.ImageView:create(animName, 1)

			child:addTo(iconPanel):center(iconPanel:getContentSize())
			child:setScale(0.5)
			child:offset(5, 5)
		else
			local child = cc.MovieClip:create(animName[1])

			child:addTo(iconPanel):center(iconPanel:getContentSize())
			child:setScale(0.9)
		end

		iconPanel:setTouchEnabled(true)
		iconPanel:addClickEventListener(function()
			self:onClickReward(status, data.rewardId, data.num)
		end)

		local text = node:getChildByName("text")

		text:setString(data.num)
	end
end

function ArenaMediator:onClickFight(index, rival)
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local view = self:getInjector():getInstance("ArenaRoleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		index = index,
		rival = rival
	}, nil)

	self:dispatch(event)
end

function ArenaMediator:onClickTeam()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local view = self:getInjector():getInstance("ArenaTeamListView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil))
end

function ArenaMediator:onClickRecruit(sender, eventType)
	local recruitSystem = self:getInjector():getInstance(RecruitSystem)
	local data = {
		recruitType = RecruitPoolType.kPvp
	}

	recruitSystem:tryEnter(data)
end

function ArenaMediator:onClickAward(sender, eventType)
	local view = self:getInjector():getInstance("ArenaAwardView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, nil, nil)

	self:dispatch(event)
end

function ArenaMediator:onClickReport(sender, eventType)
	local view = self:getInjector():getInstance("ArenaReportMainView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil))
end

function ArenaMediator:onClickRule(sender, eventType, oppoRecord)
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_RuleTranslate", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule,
		ruleReplaceInfo = self.seasonDataForRule
	}))
end

function ArenaMediator:onClickRefresh()
	if self._canRefresh then
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

		local function func()
			self._arenaSystem:requestRefreshRivalList()
		end

		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				func()
			elseif data.response == "cancel" then
				-- block empty
			elseif data.response == "close" then
				-- block empty
			end
		end

		local data = {
			title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
			title1 = Strings:get("UITitle_EN_Tishi"),
			content = Strings:get("Arena_Re_Tips"),
			sureBtn = {},
			cancelBtn = {}
		}
		local view = self:getInjector():getInstance("AlertView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	else
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Arena_UI117")
		}))
	end
end

function ArenaMediator:onClickReward(status, rewardId, targetNum)
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local info = {
		hasGet = status,
		rewardId = rewardId,
		desc = Strings:get("Arena_RewardText", {
			num = targetNum
		})
	}
	local view = self:getInjector():getInstance("ArenaBoxView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, info))
end

function ArenaMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ArenaMediator:showGetReward()
	local r = self._arenaSystem:getShowAwardAfterBattle()

	local function checkNumReward()
		if r and r.numReward and #r.numReward > 0 then
			local rewards = r.numReward
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = rewards
			}))
			self._arenaSystem:setShowAwardAfterBattle({})
		end
	end

	if r and r.rankRewards and #r.rankRewards > 0 then
		local delegate = __associated_delegate__(self)({
			willClose = function(self)
				checkNumReward()
			end
		})
		local rewards = r.rankRewards
		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			needClick = true,
			rewards = rewards,
			title = Strings:get("Arena_Title5_FirstPromotion"),
			title1 = Strings:get("UITitle_EN_Shoucijinsheng")
		}, delegate))
	else
		checkNumReward()
	end

	self._arenaSystem:setShowAwardAfterBattle({})
end

function ArenaMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local rolePanel = self._mainPanel:getChildByFullName("rolePanel")

		storyDirector:setClickEnv("ArenaMediator.rolePanel", rolePanel, nil)

		local progressPanel = self._progressPanel

		storyDirector:setClickEnv("ArenaMediator.progressPanel", progressPanel, nil)

		local refreshButton = self._button

		storyDirector:setClickEnv("ArenaMediator.refreshButton", refreshButton, nil)

		local nodeview = self._cellList[1]:getView()
		local fightNode = nodeview:getChildByFullName("bg.roleNode")

		storyDirector:setClickEnv("ArenaMediator.fightNode", fightNode, function(sender, eventType)
			self:onClickFight(1, self._arenaSystem:getRivalByIndex(1))
		end)

		local button_team = self._buttonTeam

		storyDirector:setClickEnv("ArenaMediator.button_team", button_team, function(sender, eventType)
			self:onClickTeam(sender, eventType)
		end)
		storyDirector:notifyWaiting("enter_ArenaMediator")
	end))

	self:getView():runAction(sequence)
end
