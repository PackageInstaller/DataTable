-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rank/view/RankMediator.lua

require("dm.gameplay.rank.view.component.BaseRankCell")

RankMediator = class("RankMediator", DmPopupViewMediator)

RankMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
RankMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
RankMediator:has("_friendSystem", {
	is = "r"
}):injectWith("FriendSystem")
RankMediator:has("_crusadeSystem", {
	is = "r"
}):injectWith("CrusadeSystem")
RankMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
RankMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {
	["main.viewPanel.rewardPanel"] = {
		clickAudio = "Se_Click_Common_2",
		func = "showRankRewardView"
	},
	["main.rankBg.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickBack"
	},
	["main.button_rule"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	}
}
local kRankCell = {
	[RankType.kCombat] = CombatRankCell,
	[RankType.kBlockStar] = BlockRankCell,
	[RankType.kClub] = ClubRankCell,
	[RankType.kMap] = MapRankCell,
	[RankType.kCrusade] = CrusadeRankCell,
	[RankType.kArena] = ArenaRankCell,
	[RankType.KPetWorldScore] = PetRaceRankCell,
	[RankType.kClubBoss] = ClubBossRankCell,
	[RankType.kCollection] = CollectionRankCell
}
local kTextTitle = {
	[RankType.kCombat] = {
		title1 = Strings:get("RANK_UI2"),
		title2 = Strings:get("RANK_UI3"),
		title3 = Strings:get("RANK_UI4"),
		title4 = Strings:get("RANK_UI5")
	},
	[RankType.kBlockStar] = {
		title1 = Strings:get("RANK_UI2"),
		title2 = Strings:get("RANK_UI3"),
		title3 = Strings:get("RANK_UI4"),
		title4 = Strings:get("RANK_UI6")
	},
	[RankType.KPetWorldScore] = {
		title1 = Strings:get("RANK_UI2"),
		title2 = Strings:get("RANK_UI3"),
		title3 = Strings:get("Petrace_Whole_Point"),
		title4 = Strings:get("Petrace_World_Point")
	},
	[RankType.kClub] = {
		title1 = Strings:get("RANK_UI2"),
		title2 = Strings:get("Club_Text50"),
		title3 = Strings:get("CLUB_MANAGER"),
		title4 = Strings:get("RANK_COMBAT")
	},
	[RankType.kMap] = {
		title1 = Strings:get("RANK_UI2"),
		title2 = Strings:get("RANK_UI3"),
		title3 = Strings:get("RANK_UI4"),
		title4 = Strings:get("EXPLORE_UI46")
	},
	[RankType.kCrusade] = {
		title1 = Strings:get("RANK_UI2"),
		title2 = Strings:get("RANK_UI3"),
		title3 = Strings:get("RANK_UI4"),
		title4 = Strings:get("Crusade_UI14")
	},
	[RankType.kArena] = {
		title1 = Strings:get("RANK_UI2"),
		title2 = Strings:get("RANK_UI3"),
		title3 = Strings:get("RANK_UI4"),
		title4 = Strings:get("RANK_WeeklyHonor")
	},
	[RankType.kClubBoss] = {
		title1 = Strings:get("RANK_UI2"),
		title2 = Strings:get("Club_Text50"),
		title3 = Strings:get("CLUB_MANAGER"),
		title4 = Strings:get("Rank_ClubBoss_01")
	},
	[RankType.kCollection] = {
		title1 = Strings:get("RANK_UI2"),
		title2 = Strings:get("RANK_UI3"),
		title3 = Strings:get("RANK_UI4"),
		title4 = Strings:get("RANK_Price_UI1")
	}
}
local kCellHeight = 47

function RankMediator:initialize()
	super.initialize(self)
end

function RankMediator:dispose()
	if not self._ignoreClean then
		self._rankSystem:cleanUpRankList()
	end

	super.dispose(self)
end

function RankMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RANK_GOT_REWARD_SUCC, self, self.setRewardView)
end

function RankMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dailyReset)
	self:mapEventListeners()

	local bgNode = self:getView():getChildByFullName("main.bgNode")
	local tempNode = bindWidget(self, bgNode, PopupNormalTabWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("RANK_TITLE"),
		title1 = Strings:get("UITitle_EN_Shishibangdan")
	})

	bgNode:setVisible(false)
	self:getView():getChildByFullName("main.rankBg.titleNode.bg_hw")

	local titleText1 = self:getView():getChildByFullName("main.rankBg.titleNode.Text_1")
	local titleText2 = self:getView():getChildByFullName("main.rankBg.titleNode.Text_2")

	titleText1:setString(Strings:get("RANK_TITLENO1"))
	titleText2:setString(Strings:get("UITitle_EN_Lianjiezherikan"))

	local remoteTimestamp = self._gameServerAgent:remoteTimestamp()
	local date = TimeUtil:localDate("*t", remoteTimestamp)

	if date.month >= 10 then
		if not date.month then
			local month = "0" .. date.month

			if date.day >= 10 then
				if not date.day then
					local day = "0" .. date.day
					local week = date.wday == 1 and 7 or date.wday - 1
					local dateText = self:getView():getChildByFullName("main.rankBg.dateMonth")

					dateText:setString(month .. "/" .. day)

					local dateyear = self:getView():getChildByFullName("main.rankBg.dateyear")

					dateyear:setString(Strings:get("RANK_DATAUI", {
						year = date.year,
						week = GameStyle:intNumToWeekString(week)
					}))

					local titleText1_frame_w = titleText1:getContentSize().width
					local titleText1_text_w = titleText1:getAutoRenderSize().width

					if titleText1_frame_w < titleText1_text_w then
						titleText1_text_w = titleText1_frame_w
					end

					local lineImage = self:getView():getChildByFullName("main.rankBg.main_bg_0")

					lineImage:setPositionX(titleText1_text_w + 60)
					dateText:setPositionX(titleText1_text_w + 70)
					dateyear:setPositionX(titleText1_text_w + 70)
				end
			end
		end
	end
end

function RankMediator:enterWithData(data)
	self._allRankData = self._rankSystem:getAllRankData()
	self._curTabType = self:getIndexByAppID(data.index) or 1
	self._recordCountWhenRequestNext = nil
	self._initTabClick = true
	self._isAskingRank = false
	self._ignoreClean = data.ignoreClean

	self:refreshData()
	self:initWigetInfo()
	self:setTopThreeInfo()
	self:createTableView()
	self:createTabController()
end

function RankMediator:setTopThreeInfo()
	local type = self._allRankData[self._curTabType].AppID

	for i = 1, 3 do
		local cellPanel = self._mainPanel:getChildByFullName("viewPanel.cellPanel_" .. i)

		cellPanel:setTag(i - 1)

		local rolePanel = cellPanel:getChildByFullName("rolePanel")

		rolePanel:removeAllChildren()

		local name = cellPanel:getChildByFullName("name")
		local rankTxt1 = cellPanel:getChildByFullName("rankTxt1")
		local rankNum = cellPanel:getChildByFullName("rankNum")
		local data = self._rankList[i]

		if cellPanel:getChildByName("title") then
			cellPanel:removeChildByName("title")
		end

		if data then
			local rankNumText = data._value

			if type == RankType.kClub or type == RankType.kClubBoss then
				rankNumText = data._comatValue

				name:setString(data._clubName)
				rankTxt1:setString(kTextTitle[type].title4)

				local headIcon = IconFactory:createClubIcon({
					clipType = 4,
					id = data._clubHeadImg
				})

				headIcon.backImg:setVisible(false)
				headIcon.icon:setScale(0.8)
				headIcon:addTo(rolePanel):posite(rolePanel:getContentSize().width / 2, 55)
			else
				name:setString(data._nickName)
				rankTxt1:setString(kTextTitle[type].title4)
				rankNum:setString(data._combat)

				local heroAnim, jsonPath

				if data._surfaceId then
					local roleModel = ConfigReader:getDataByNameIdAndKey("Surface", data._surfaceId, "Model")
					local actionType = ConfigReader:getDataByNameIdAndKey("Surface", data._surfaceId, "Type")

					assert(roleModel ~= nil, "Surface不存在配置" .. data._surfaceId)

					local action = actionType == SurfaceType.kAwake and "stand1" or "stand"

					if roleModel then
						heroAnim, jsonPath = RoleFactory:createHeroAnimation(roleModel, action)
					end
				else
					heroAnim, jsonPath = RoleFactory:createHeroAnimation("Model_" .. data._board)
				end

				heroAnim:setAnchorPoint(cc.p(0.5, 0.5))
				heroAnim:addTo(rolePanel):posite(rolePanel:getContentSize().width / 2, 2)
				heroAnim:setScale(0.6)

				if data:getTitle() ~= "" then
					local icon = IconFactory:createTitleIcon({
						id = data:getTitle()
					})

					icon:addTo(cellPanel):posite(name:getPositionX() + 3, name:getPositionY() + 25)
					icon:setName("title")
					icon:setScale(0.58)
				end
			end

			rankNum:setString((type == RankType.KPetWorldScore or type == RankType.kSubPetRace or nil) and data:getScore())
		else
			name:setString(Strings:get("RankRuleUI_4"))
			rankTxt1:setString("")
			rankNum:setString("")
		end

		local width1 = rankTxt1:getContentSize().width
		local width2 = rankNum:getContentSize().width
		local startPosX = name:getPositionX()

		rankTxt1:setPositionX(startPosX + (width1 - (width1 + width2 + 2) / 2))
		rankNum:setPositionX(rankTxt1:getPositionX() + 2)

		if getCurrentLanguage() ~= GameLanguageType.CN then
			rankTxt1:setPositionX(rankTxt1:getPositionX() + width2 / 2)
			rankNum:setPositionX(rankTxt1:getPositionX() - width1 / 2 - width2 / 2)
			rankNum:setPositionY(rankTxt1:getPositionY() - 20)
		end

		local function callFunc()
			self:onClickRankCell(cellPanel)
		end

		mapButtonHandlerClick(nil, cellPanel, {
			func = callFunc
		})
	end
end

function RankMediator:getIndexByAppID(appID)
	for k, v in pairs(self._allRankData) do
		if v.AppID == appID then
			return tonumber(k)
		end
	end
end

function RankMediator:resumeWithData()
	print("545646546", self._curTabType)
	self:onClickTab("", self._curTabType)
end

function RankMediator:initWigetInfo()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._tabpanel = self._mainPanel:getChildByName("tabpanel")
	self._myselfText1 = self._mainPanel:getChildByFullName("viewPanel.myself_info_bg.text_1")
	self._myselfText2 = self._mainPanel:getChildByFullName("viewPanel.myself_info_bg.text_2")
	self._myselfText3 = self._mainPanel:getChildByFullName("viewPanel.myself_info_bg.text_3")
	self._myselfText4 = self._mainPanel:getChildByFullName("viewPanel.myself_info_bg.text_4")
	self._imgNoRank = self._mainPanel:getChildByFullName("viewPanel.myself_info_bg.img_no_in_rank")
	self._title1 = self._mainPanel:getChildByFullName("viewPanel.property_bg.property_1")
	self._title2 = self._mainPanel:getChildByFullName("viewPanel.property_bg.property_2")
	self._title3 = self._mainPanel:getChildByFullName("viewPanel.property_bg.property_3")
	self._title4 = self._mainPanel:getChildByFullName("viewPanel.property_bg.property_4")

	local myselfInfo = self._mainPanel:getChildByFullName("viewPanel.myself_info_bg")

	myselfInfo:setSwallowTouches(true)
	myselfInfo:setTouchEnabled(true)
	myselfInfo:addClickEventListener(function()
		local type = self._allRankData[self._curTabType].AppID

		if type == RankType.KPetWorldScore then
			return
		end

		local myselfData = self:getRankSystem():getMyselfDataByType(type)

		if not myselfData then
			return
		end

		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local showView = false

		if (type ~= RankType.kClub or type ~= RankType.kClubBoss) and myselfData:getRid() ~= "" then
			showView = true
		elseif myselfData:getRid() == "" then
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("RelationText9")
			}))
		else
			showView = true
		end

		if showView then
			self._friendSystem:showFriendPlayerInfoView(myselfData:getRid(), myselfData)
		end
	end)
	self._title1:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._title2:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._title3:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._title4:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	myselfInfo:getChildByFullName("img_myself.text"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function RankMediator:refreshData()
	self._rankList = self._rankSystem:getRankListByType(self._allRankData[self._curTabType].AppID)
end

function RankMediator:refreshMyselfInfo()
	local type = self._allRankData[self._curTabType].AppID
	local myselfData = self:getRankSystem():getMyselfDataByType(type)

	if not myselfData then
		return
	end

	local str = self:getRankSystem():getMyselfShowInfoByType(myselfData)
	local rank = myselfData:getRank()
	local maxRank = self:getRankSystem():getMaxRank()

	self._myselfText1:setString(str[1])
	self._myselfText2:setString(str[2])
	self._myselfText3:setString(str[3])

	if rank <= 0 or maxRank < rank then
		self._imgNoRank:setVisible(true)
		self._myselfText1:setVisible(false)
	else
		self._imgNoRank:setVisible(false)
		self._myselfText1:setVisible(true)
	end

	if type == RankType.kCrusade then
		local textData = self._crusadeSystem:getRankShowFloorData(tonumber(str[4]))

		self._myselfText4:setString(textData.name)
	else
		self._myselfText4:setString(str[4])
	end
end

function RankMediator:refreshTitleInfo()
	local type = self._allRankData[self._curTabType].AppID

	if self._title1 then
		self._title1:setString(kTextTitle[type].title1)
	end

	if self._title2 then
		self._title2:setString(kTextTitle[type].title2)
	end

	if self._title3 then
		self._title3:setString(kTextTitle[type].title3)
	end

	if self._title4 then
		self._title4:setString(kTextTitle[type].title4)
	end
end

function RankMediator:createTableView()
	local scrollLayer = self._mainPanel:getChildByFullName("viewPanel.tableView")
	local viewSize = scrollLayer:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function scrollViewDidScroll(table)
		if table:isTouchMoved() then
			self:touchForTableView()
		end
	end

	local function numberOfCells(view)
		return #self._rankList <= 6 and 6 or #self._rankList - 3
	end

	local function cellTouched(table, cell)
		self:onClickRankCell(cell)
	end

	local function cellSize(table, idx)
		return viewSize.width, kCellHeight
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			cell:setContentSize(cc.size(viewSize.width, kCellHeight))
		end

		cell:removeAllChildren()

		local type = self._allRankData[self._curTabType].AppID
		local RankCell = kRankCell[type]
		local rankCell = RankCell:new({
			mediator = self
		})

		cell:addChild(rankCell:getView(), 0)
		rankCell:getView():setPosition(0, 0)

		cell.rankCell = rankCell

		local index = idx + 1 + 3
		local record = self._rankList[index]

		cell:setTag(index - 1)

		if record then
			if type == RankType.kCrusade then
				local textData = self._crusadeSystem:getRankShowFloorData(tonumber(record:getPoint()))

				cell.rankCell:refreshData(record, textData)
			elseif type == RankType.KPetWorldScore then
				cell.rankCell:refreshData(record)
			else
				cell.rankCell:refreshData(record)
			end
		else
			cell.rankCell:refreshEmpty(index)
		end

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:addTo(scrollLayer)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:setMaxBounceOffset(36)

	self._tableView = tableView
end

function RankMediator:onClickRankCell(cell)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local tag = cell:getTag()
	local index = tag + 1
	local type = self._allRankData[self._curTabType].AppID
	local record = self:getRankSystem():getRankRecordByTypeAndIndex(type, index)

	if not record then
		return
	end

	if type == RankType.kClub or type == RankType.kClubBoss then
		local clubId = record:getClubId()

		self._clubSystem:requestClubDetailInfoData(clubId, {
			remainLastView = true,
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, nil)
	else
		self._friendSystem:showFriendPlayerInfoView(record:getRid(), record)
	end
end

function RankMediator:touchForTableView()
	if self._isAskingRank then
		return
	end

	local kMinRefreshHeight = 35
	local viewHeight = self._tableView:getViewSize().height
	local offsetY = self._tableView:getContentOffset().y

	if (kMinRefreshHeight < offsetY and viewHeight < self._tableView:getContentSize().height and #self._rankList < self._rankSystem:getMaxRank() or nil) and true then
		self._isAskingRank = true
		self._requestNextCount = #self._rankList

		self:doRequestNextRank()
	end
end

function RankMediator:doRequestNextRank()
	local currentTab = self._curTabType
	local type = self._allRankData[currentTab].AppID
	local dataEnough = self:getRankSystem():isServerDataEnough(type)

	if dataEnough == true then
		self._tableView:stopScroll()

		local function onRequestRankDataSucc()
			if DisposableObject:isDisposed(self) then
				return
			end

			self:refreshData()
			self:refreshView()
		end

		local rankStart = #self._rankList - 10

		rankStart = math.max(rankStart, 1)

		local rankEnd = rankStart + 10 + self._rankSystem:getRequestRankCountPerTime()
		local sendData = {
			type = type,
			rankStart = rankStart,
			rankEnd = rankEnd
		}

		self._rankSystem:requestRankData(sendData, onRequestRankDataSucc)
	end
end

function RankMediator:createTabController()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #self._allRankData do
		local tabText = Strings:get(self._allRankData[i].Desc1)
		local tabTextTranslate = Strings:get(self._allRankData[i].Desc2)

		data[#data + 1] = {
			tabText = tabText,
			tabTextTranslate = tabTextTranslate
		}
	end

	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 490)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		noCenterBtn = true,
		ignoreRedSelectState = true
	})
	self._tabBtnWidget:selectTabByTag(self._curTabType)

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabpanel):posite(0, -5)
	view:setLocalZOrder(1100)
	self._tabBtnWidget:scrollTabPanel(self._curTabType)
end

function RankMediator:onClickTab(name, tag)
	self._tableView:stopScroll()

	self._curTabType = tag

	local function switchTabView()
		if DisposableObject:isDisposed(self) then
			return
		end

		self:refreshData()
		self:refreshView()
	end

	local type = self._allRankData[tag].AppID

	if not self._initTabClick then
		self._rankSystem:cleanUpRankListByType(type)

		local var_27_0 = {
			rankStart = 1,
			type = type
		}

		var_27_0.rankEnd = self:getRankSystem():getRequestRankCountPerTime()

		local sendData = var_27_0

		self._rankSystem:requestRankData(sendData, switchTabView)
	else
		switchTabView()
	end

	self._requestNextCount = nil
	self._isAskingRank = false
	self._initTabClick = false
end

function RankMediator:refreshView()
	self:refreshTitleInfo()
	self:setTopThreeInfo()
	self:refreshMyselfInfo()
	self._tableView:stopScroll()
	self._tableView:reloadData()

	if self._requestNextCount then
		local diffCount = #self._rankList - self._requestNextCount
		local offsetY = diffCount == 0 and 0 or -diffCount * kCellHeight + kCellHeight * 1.2

		self._tableView:setContentOffset(cc.p(0, offsetY))

		self._requestNextCount = nil
		self._isAskingRank = false
	end

	self:setRewardView()
end

function RankMediator:onClickBack()
	self:close()
end

function RankMediator:dailyReset()
	if DisposableObject:isDisposed(self) then
		return
	end

	self:close()
end

function RankMediator:showRankRewardView()
	local view = self:getInjector():getInstance("RankRewardView")
	local type = self._allRankData[self._curTabType].AppID

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rankType = type,
		rankList = self._rankList
	}))
end

function RankMediator:setRewardView()
	local panel = self:getView():getChildByFullName("main.viewPanel.rewardPanel")
	local unlock, tips = self._rankSystem:checkRewardEnabled()

	if not unlock then
		panel:setVisible(false)

		return
	end

	local list = self._rankSystem:getRewardRankListData()
	local type = self._allRankData[self._curTabType].AppID

	panel:setVisible(list[type] and true or false)

	if not list[type] then
		return
	end

	local status = self._rankSystem:getRewardRedPointByRankType(type)
	local redPoint = panel:getChildByName("redPoint")

	if not redPoint then
		redPoint = RedPoint:createDefaultNode()

		redPoint:addTo(panel):posite(73, 70)
		redPoint:setLocalZOrder(99901)
		redPoint:setName("redPoint")
		redPoint:setScale(0.7)
	end

	redPoint:setVisible(status)
end

function RankMediator:onClickRule()
	local Arena_RuleTranslate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Rank_RuleTranslate", "content")
	local view = self:getInjector():getInstance("ArenaRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Arena_RuleTranslate
	}, nil)

	self:dispatch(event)
end
