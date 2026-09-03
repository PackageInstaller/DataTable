-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpk/view/RTPKRewardViewMediator.lua

RTPKRewardViewMediator = class("RTPKRewardViewMediator", DmPopupViewMediator, _M)

RTPKRewardViewMediator:has("_rTPKSystem", {
	is = "r"
}):injectWith("RTPKSystem")

local rankTabData = {
	{
		Desc2 = "EN_RTPK_PopUpReward_UI02",
		Desc1 = "RTPK_PopUpReward_UI02"
	},
	{
		Desc2 = "EN_RTPK_PopUpReward_UI03",
		Desc1 = "RTPK_PopUpReward_UI04"
	},
	{
		Desc2 = "RTPK_WinReward_UI03",
		Desc1 = "RTPK_WinReward_UI01"
	}
}
local RTPKRankRewardType = {
	Grade = 1,
	AllRank = 2,
	WinTask = 3
}
local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	}
}

function RTPKRewardViewMediator:initialize()
	super.initialize(self)
end

function RTPKRewardViewMediator:dispose()
	super.dispose(self)
end

function RTPKRewardViewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESH_GRADE_REWARD_DONE, self, self.refreshGradeReward)

	self._bgWidget = bindWidget(self, "main.bgNode", PopupNormalWidget, {
		title = Strings:get("RTPK_PopUpReward_UI01"),
		title1 = Strings:get("EN_RTPK_PopUpReward_UI01"),
		titleDimensions = {
			180,
			85
		}
	})
end

function RTPKRewardViewMediator:enterWithData(data)
	self._rtpk = self._rTPKSystem:getRtpk()
	self._curTabType = data.tab or RTPKRankRewardType.Grade
	self._serverRank = self._rtpk:getServerRank() or -1
	self._allserverRank = self._rtpk:getGlobalRank() or -1
	self._dataList = {}

	self:initWidgetInfo()
	self:createTabController()
end

function RTPKRewardViewMediator:resumeWithData()
	self:onClickTab("", self._curTabType)
end

function RTPKRewardViewMediator:initWidgetInfo()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._tabpanel = self._mainPanel:getChildByFullName("tabpanel")
	self._viewPanel = self._mainPanel:getChildByName("viewPanel")
	self._tableViewLayout = self._viewPanel:getChildByFullName("tableView")
	self._rewardCellPanel = self._viewPanel:getChildByName("rewardCellPanel")

	self._rewardCellPanel:setVisible(false)

	self._duanweiCellPanel = self._viewPanel:getChildByName("rankCellPanel")

	self._duanweiCellPanel:setVisible(false)

	self._winCellPanel = self._viewPanel:getChildByName("winCellPanel")

	self._winCellPanel:setVisible(false)

	self._duanweiTitle = self._viewPanel:getChildByFullName("RankProperty_bg")
	self._rewardTitle = self._viewPanel:getChildByFullName("rewardProperty_bg")
	self._rewardSelfInfo = self._viewPanel:getChildByFullName("rewardMyselfInfo")

	self._rewardTitle:getChildByFullName("property_1"):setString(Strings:get("RTPK_PopUpReward_UI13"))
	self._rewardTitle:getChildByFullName("property_2"):setString(Strings:get("RTPK_PopUpReward_UI12"))
	self._duanweiTitle:getChildByFullName("property_1"):setString(Strings:get("RTPK_PopUpReward_UI11"))
	self._duanweiTitle:getChildByFullName("property_2"):setString(Strings:get("RTPK_PopUpReward_UI12"))
end

function RTPKRewardViewMediator:createTabController()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #rankTabData do
		local tabText = Strings:get(rankTabData[i].Desc1)
		local tabTextTranslate = Strings:get(rankTabData[i].Desc2)

		data[#data + 1] = {
			fontSize = 28,
			tabText = tabText,
			tabTextTranslate = tabTextTranslate,
			redPointFunc = function()
				if i == RTPKRankRewardType.Grade then
					return self._rTPKSystem:checkGradeRewardRedpoint()
				end

				if i == RTPKRankRewardType.WinTask then
					return self._rTPKSystem:checkWinTaskRewardRedpoint()
				end

				return false
			end
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

function RTPKRewardViewMediator:refreshGradeReward()
	if self._tabBtnWidget then
		self._tabBtnWidget:refreshAllRedPoint()
	end

	if self._curTabType == RTPKRankRewardType.Grade then
		self._dataList = self._rTPKSystem:getGradeConfigInfo()
	elseif self._curTabType == RTPKRankRewardType.WinTask then
		self._dataList = self._rtpk:getWinTaskData()
	end

	self:refreshTableView()
end

function RTPKRewardViewMediator:onClickTab(name, tag)
	self._curTabType = tag

	if self._curTabType == RTPKRankRewardType.Grade then
		self._dataList = self._rTPKSystem:getGradeConfigInfo()
	elseif self._curTabType == RTPKRankRewardType.AllRank then
		local seasonConfig = self._rtpk:getSeasonConfig()

		if seasonConfig then
			self._dataList = seasonConfig.AllServerReward or {}
		end
	else
		self._dataList = self._rtpk:getWinTaskData()
	end

	self:refreshTableView()
	self:refreshRewardSelfView()
	self:refreshTitlePanel()
end

function RTPKRewardViewMediator:refreshTitlePanel()
	self._duanweiTitle:setVisible(self._curTabType == RTPKRankRewardType.Grade)
	self._rewardTitle:setVisible(self._curTabType ~= RTPKRankRewardType.Grade)

	if self._curTabType == RTPKRankRewardType.WinTask then
		self._rewardTitle:getChildByName("property_1"):setString(Strings:get("RTPK_Task"))
	else
		self._rewardTitle:getChildByName("property_1"):setString(Strings:get("RTPK_PopUpReward_UI11"))
	end
end

function RTPKRewardViewMediator:refreshRewardSelfView()
	local textName1 = self._rewardSelfInfo:getChildByFullName("text_1")
	local textName3 = self._rewardSelfInfo:getChildByFullName("text_5")

	if self._serverRank == -1 and self._allserverRank == -1 then
		textName1:setString(Strings:get("RTPK_PopUpReward_UI09", {
			myRank01 = Strings:get("RTPK_PopUpRank_UI10"),
			myRank02 = Strings:get("RTPK_PopUpRank_UI10")
		}))
	elseif self._serverRank ~= -1 and self._allserverRank == -1 then
		textName1:setString(Strings:get("RTPK_PopUpReward_UI09", {
			myRank01 = self._serverRank,
			myRank02 = Strings:get("RTPK_PopUpRank_UI10")
		}))
	elseif self._serverRank == -1 and self._allserverRank ~= -1 then
		textName1:setString(Strings:get("RTPK_PopUpReward_UI09", {
			myRank01 = Strings:get("RTPK_PopUpRank_UI10"),
			myRank02 = self._serverRank
		}))
	else
		textName1:setString(Strings:get("RTPK_PopUpReward_UI09", {
			myRank01 = self._serverRank,
			myRank02 = self._allserverRank
		}))
	end

	if self._curTabType == RTPKRankRewardType.WinTask then
		textName1:setString(Strings:get("RTPK_WinReward_UI04", {
			times = self._rtpk:getTotalWin()
		}))
	end

	local gradeData = self._rtpk:getCurGrade()

	textName3:setString(Strings:get("RTPK_PopUpReward_UI10", {
		rankTitle = Strings:get(gradeData.Name)
	}))
end

function RTPKRewardViewMediator:refreshTableView()
	if self._tableView then
		self._tableView:reloadData()
	else
		self._tableViewLayout:removeAllChildren()

		local viewSize = self._tableViewLayout:getContentSize()
		local tableView = cc.TableView:create(viewSize)
		local kCellHeight = self._rewardCellPanel:getContentSize().height

		local function numberOfCells(view)
			return #self._dataList
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

			local index = idx + 1

			self:addCellPanel(cell, index)

			return cell
		end

		tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
		tableView:setDelegate()
		tableView:addTo(self._tableViewLayout)
		tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
		tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
		tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
		tableView:setMaxBounceOffset(20)
		tableView:reloadData()

		self._tableView = tableView
	end
end

function RTPKRewardViewMediator:addCellPanel(cell, index)
	if self._curTabType == RTPKRankRewardType.Grade then
		self:addRankGradePanel(cell, index)
	elseif self._curTabType == RTPKRankRewardType.AllRank then
		self:addRankAwardPanel(cell, index)
	else
		self:addWinTaskPanel(cell, index)
	end
end

function RTPKRewardViewMediator:addRankGradePanel(cell, index)
	cell:removeAllChildren()

	local info = self._dataList[index]

	assert(type(info.Reward) == "table", "error type Reward ")

	local seasonConfig = self._rtpk:getSeasonConfig()
	local curSeasionOrder = seasonConfig.SeasonOrder
	local rewardIndex = curSeasionOrder % #info.Reward

	if rewardIndex == 0 then
		rewardIndex = #info.Reward
	end

	local panel = self._duanweiCellPanel:clone()

	panel:setVisible(true)
	panel:addTo(cell):posite(0, 0)

	local bg1 = panel:getChildByName("Image_bg1")
	local bg2 = panel:getChildByName("Image_bg2")
	local rankIcon = panel:getChildByName("rankIcon")
	local rankName = panel:getChildByName("rankName")
	local scoreTitleText = panel:getChildByName("rankScoreName")
	local rankScore = panel:getChildByName("rankScore")
	local iconPanel = panel:getChildByName("icon")
	local btnGet = panel:getChildByName("rewardFinishBtn")
	local notGetText = panel:getChildByName("ranktext1")
	local recivedText = panel:getChildByName("Image_87")

	rankIcon:ignoreContentAdaptWithSize(true)
	bg1:setVisible(index % 2 == 0)
	bg2:setVisible(index % 2 ~= 0)

	local icon = IconFactory:createRTPKGradeIcon(info.Id, {
		hideName = true
	})

	icon:setScale(0.25)
	rankIcon:removeAllChildren()
	icon:addTo(rankIcon)
	rankName:setString(Strings:get(info.Name))
	rankScore:setString(Strings:get("RTPK_PopUpReward_UI16", {
		score = info.ScoreLow
	}))

	local reward = info.Reward[rewardIndex]
	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", reward, "Content") or {}
	local length = #rewards

	for i = 1, length do
		local icon = IconFactory:createRewardIcon(rewards[i], {
			showAmount = true,
			isWidget = true
		})

		icon:addTo(iconPanel)
		icon:setScale(0.65)
		icon:setPosition(cc.p(iconPanel:getContentSize().width / 2 + (i - 1) * 105, iconPanel:getContentSize().height / 2 - 7))
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[i], {
			needDelay = true
		})
	end

	local state = info.state

	btnGet:setVisible(state == RTPKGradeRewardState.kCanGet)
	notGetText:setVisible(state == RTPKGradeRewardState.kCanNotGet)
	recivedText:setVisible(state == RTPKGradeRewardState.kHadGet)

	if state == RTPKGradeRewardState.kCanGet then
		btnGet:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				local data = {
					code = RTPKGetRewardType.KGradeReward,
					target = info.Id
				}

				self._rTPKSystem:requestGetReward(data)
			end
		end)
	end
end

function RTPKRewardViewMediator:addRankAwardPanel(cell, idx)
	cell:removeAllChildren()

	local rewardId = self._dataList[idx]
	local reward = ConfigReader:getDataByNameIdAndKey("RankReward", rewardId, "Reward") or ""
	local rank = ConfigReader:getDataByNameIdAndKey("RankReward", rewardId, "Rank") or {}
	local score = ConfigReader:getDataByNameIdAndKey("RankReward", rewardId, "Score") or 0
	local panel = self._rewardCellPanel:clone()

	panel:setVisible(true)
	panel:addTo(cell):posite(0, 0)

	local bg1 = panel:getChildByName("Image_bg1")
	local bg2 = panel:getChildByName("Image_bg2")
	local rankNum = panel:getChildByName("rankNum")
	local rankIcon = panel:getChildByName("rankIcon")
	local iconPanel = panel:getChildByName("icon")

	rankIcon:ignoreContentAdaptWithSize(true)
	bg1:setVisible(idx % 2 == 0)
	bg2:setVisible(idx % 2 ~= 0)
	rankIcon:setVisible(false)
	rankNum:setVisible(false)

	local randDes = ""

	if idx <= 3 then
		rankIcon:loadTexture(RankTopImage[idx], 1)
		rankIcon:setVisible(true)
	elseif rank[1] == rank[2] then
		rankNum:setVisible(true)

		randDes = Strings:get("RTPK_PopUpReward_UI15", {
			num = rank[1]
		})

		rankNum:setString(randDes)
	else
		rankNum:setVisible(true)

		randDes = Strings:get("RTPK_PopUpReward_UI15", {
			num = rank[1] .. "-" .. rank[2]
		})

		rankNum:setString(randDes)
	end

	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", reward, "Content") or {}
	local length = #rewards

	for i = 1, length do
		local icon = IconFactory:createRewardIcon(rewards[i], {
			showAmount = true,
			isWidget = true
		})

		icon:addTo(iconPanel)
		icon:setScale(0.65)
		icon:setPosition(cc.p(iconPanel:getContentSize().width / 2 + (i - 1) * 105, iconPanel:getContentSize().height / 2 - 7))
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[i], {
			needDelay = true
		})
	end
end

function RTPKRewardViewMediator:addWinTaskPanel(cell, index)
	cell:removeAllChildren()

	local info = self._dataList[index]
	local panel = self._winCellPanel:clone()

	panel:setVisible(true)
	panel:addTo(cell):posite(0, 0)

	local bg1 = panel:getChildByName("Image_bg1")
	local bg2 = panel:getChildByName("Image_bg2")
	local descText = panel:getChildByName("desc")
	local iconPanel = panel:getChildByName("icon")
	local btnGet = panel:getChildByName("rewardFinishBtn")
	local notGetText = panel:getChildByName("ranktext1")
	local recivedText = panel:getChildByName("Image_87")

	bg1:setVisible(index % 2 == 0)
	bg2:setVisible(index % 2 ~= 0)
	descText:setString(Strings:get("RTPK_WinReward_UI02", {
		times = info.num
	}))

	local rewardId = info.rewardId
	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content") or {}
	local length = #rewards

	for i = 1, length do
		local icon = IconFactory:createRewardIcon(rewards[i], {
			showAmount = true,
			isWidget = true
		})

		icon:addTo(iconPanel)
		icon:setScale(0.65)
		icon:setPosition(cc.p(iconPanel:getContentSize().width / 2 + (i - 1) * 105, iconPanel:getContentSize().height / 2 - 7))
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[i], {
			needDelay = true
		})
	end

	local state = info.state

	btnGet:setVisible(state == RTPKGradeRewardState.kCanGet)
	notGetText:setVisible(state == RTPKGradeRewardState.kCanNotGet)
	recivedText:setVisible(state == RTPKGradeRewardState.kHadGet)

	if state == RTPKGradeRewardState.kCanGet then
		btnGet:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				local data = {
					key = tostring(info.num)
				}

				self._rTPKSystem:requestTotalWinReward(data)
			end
		end)
	end
end

function RTPKRewardViewMediator:onClickClose()
	self:close()
end
