-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubResourcesBattleMediator.lua

ClubResourcesBattleMediator = class("ClubResourcesBattleMediator", DmAreaViewMediator)

ClubResourcesBattleMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubResourcesBattleMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")
ClubResourcesBattleMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
ClubResourcesBattleMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {}

function ClubResourcesBattleMediator:initialize()
	super.initialize(self)

	self._isDoingRequestData = false
	self._requestTime = 10
end

function ClubResourcesBattleMediator:dispose()
	self:stopTimer()

	self._isDoingRequestData = false

	super.dispose(self)
end

function ClubResourcesBattleMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	local view = self:getView()

	self._winSize = cc.Director:getInstance():getWinSize()
end

function ClubResourcesBattleMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBATTLE_REFRESH, self, self.onDoRefrsh)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBATTLE_AFTER_GET_REWARD, self, self.afterGetReward)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_FORCEDLEVEL, self, self.onForcedLevel)
end

function ClubResourcesBattleMediator:enterWithData(data)
	self:initData()
	self:initNodes()
	self:setupTopInfoWidget()
	self:createRewardScrollView()
	self:refreshBothClubInfoView()
	self:doBothClubScoreViewLogic()
	self:creatScoreRankTableView()
	self:doWordLogic()
	self:updateRemainTime()
	self:doSuccessLogic()
	self:refreshAllData()
	self:runStartAction()
end

function ClubResourcesBattleMediator:onDoRefrsh(event)
	local data = event:getData()

	self:refreshData()
	self:refreshView()
end

function ClubResourcesBattleMediator:afterGetReward(event)
	self:refreshAllData()
end

function ClubResourcesBattleMediator:initData()
	self._clubResourcesBattleInfo = self._developSystem:getPlayer():getClub():getClubResourcesBattleInfo()
	self._leftPlayerList = self._clubResourcesBattleInfo:getSelfClubSocreList()
	self._rightPlayerList = self._clubResourcesBattleInfo:getTargetClubSocreList()
	self._scrollDataList = self._clubResourcesBattleInfo:getScoreRewardData()
end

function ClubResourcesBattleMediator:initNodes()
	local lineGradiantVec = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.5,
			color = cc.c4b(255, 204, 246, 255)
		}
	}
	local lineGradiantVec1 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 203, 255)
		},
		{
			ratio = 0.5,
			color = cc.c4b(255, 231, 68, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	self._mainPanel = self:getView():getChildByFullName("main")

	local Image_9 = self._mainPanel:getChildByFullName("Image_9")
	local Image_10 = self._mainPanel:getChildByFullName("Image_10")
	local winSize = cc.Director:getInstance():getWinSize()

	Image_9:setPositionX(winSize.width)

	if winSize.width > 1136 then
		Image_10:setPositionX(1136 - winSize.width)
	end

	self._titleText = self._mainPanel:getChildByFullName("titleText")
	self._desText = self._mainPanel:getChildByFullName("desText")
	self._timeText = self._mainPanel:getChildByFullName("timeText")
	self._rightClubPanel = self._mainPanel:getChildByFullName("rightClubPanel")
	self._rightDarkPanel = self._rightClubPanel:getChildByFullName("basePanel.darkPanel")

	self._rightDarkPanel:setVisible(false)

	self._rightClubScoreText = self._rightClubPanel:getChildByFullName("basePanel.clubScoreText")
	self._rightClubIconNode = self._rightClubPanel:getChildByFullName("basePanel.clubIconNode")
	self._rightClubNameText = self._rightClubPanel:getChildByFullName("basePanel.clubNameText")

	self._rightClubNameText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec, lineGradiantDir))
	self._rightClubScoreText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, lineGradiantDir))

	self._rightIconNode = self._rightClubPanel:getChildByFullName("basePanel.iconNode")
	self._leftClubPanel = self._mainPanel:getChildByFullName("leftClubPanel")
	self._leftDarkPanel = self._leftClubPanel:getChildByFullName("basePanel.darkPanel")

	self._leftDarkPanel:setVisible(false)

	self._leftClubScoreText = self._leftClubPanel:getChildByFullName("basePanel.clubScoreText")
	self._leftClubIconNode = self._leftClubPanel:getChildByFullName("basePanel.clubIconNode")
	self._leftClubNameText = self._leftClubPanel:getChildByFullName("basePanel.clubNameText")

	self._leftClubNameText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec, lineGradiantDir))
	self._leftClubScoreText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, lineGradiantDir))

	self._leftIconNode = self._leftClubPanel:getChildByFullName("basePanel.iconNode")

	local leftTableNode = self._mainPanel:getChildByFullName("leftTableNode")

	self._leftTableDarkPanel = leftTableNode:getChildByFullName("darkPanel")

	self._leftTableDarkPanel:setVisible(false)

	self._leftTablePanel = leftTableNode:getChildByFullName("tablePanel")

	local rightTableNode = self._mainPanel:getChildByFullName("rightTableNode")

	self._rightTableDarkPanel = rightTableNode:getChildByFullName("darkPanel")

	self._rightTableDarkPanel:setVisible(false)

	self._rightTablePanel = rightTableNode:getChildByFullName("tablePanel")
	self._tableCellPanel = self._mainPanel:getChildByFullName("tableCellPanel")

	self._tableCellPanel:setVisible(false)

	self._bottomNode = self._mainPanel:getChildByFullName("bottomNode")
	self._bottomIconImage = self._bottomNode:getChildByFullName("iconNode.Image_3")
	self._bottomCurrentScore = self._bottomNode:getChildByFullName("currentScore")
	self._bottomScorePanel = self._bottomNode:getChildByFullName("scorePanel")

	local Text_2 = self._bottomNode:getChildByFullName("Text_2")

	Text_2:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, lineGradiantDir))

	self._scrollCellPanel = self._mainPanel:getChildByFullName("cellPanel")

	self._scrollCellPanel:setVisible(false)

	self._vsNode = self._mainPanel:getChildByFullName("vsNode")
	self._vsLineImage = self._vsNode:getChildByFullName("vsLineImage")
	self._wordNode = self._mainPanel:getChildByFullName("wordNode")

	local Image_wei = self._wordNode:getChildByName("Image_wei")
	local Image_li = self._wordNode:getChildByName("Image_li")
	local Image_po = self._wordNode:getChildByName("Image_po")
	local Image_you = self._wordNode:getChildByName("Image_you")
	local anim = cc.MovieClip:create("shijunlidi_jieshedabang")

	anim:addTo(Image_li, 1)
	anim:setPosition(cc.p(100, 0))
	anim:gotoAndPlay(1)

	local anim = cc.MovieClip:create("shirupozhu_jieshedabang")

	anim:addTo(Image_po, 1)
	anim:setPosition(cc.p(100, 0))
	anim:gotoAndPlay(1)

	local anim = cc.MovieClip:create("weizaidanxi_jieshedabang")

	anim:addTo(Image_wei, 1)
	anim:setPosition(cc.p(100, 0))
	anim:gotoAndPlay(1)

	local anim = cc.MovieClip:create("youshi_jieshedabang")

	anim:addTo(Image_you, 1)
	anim:setPosition(cc.p(100, 0))
	anim:gotoAndPlay(1)

	self._leftResultAnmNode = self._mainPanel:getChildByFullName("leftResultAnmNode")
	self._rightResultAnmNode = self._mainPanel:getChildByFullName("rightResultAnmNode")
	self._scoreMark = self._mainPanel:getChildByFullName("scoreMark")

	self._scoreMark:setVisible(false)

	self._frontImage = self._mainPanel:getChildByFullName("frontImage")

	self._frontImage:setVisible(false)
end

function ClubResourcesBattleMediator:refreshBothClubInfoView()
	local resourceBaseInfo = self._clubResourcesBattleInfo:getResouceBassInfo()

	self._titleText:setString(Strings:get(resourceBaseInfo.Desc_1))
	self._desText:setString(Strings:get(resourceBaseInfo.Desc_2))
	self._bottomIconImage:loadTexture(resourceBaseInfo.icon .. ".png", 1)

	if self._clubResourcesBattleInfo:getClubId() ~= "" then
		self._leftClubNameText:setString(self._clubResourcesBattleInfo:getClubName())

		local icon = IconFactory:createClubIcon({
			id = self._clubResourcesBattleInfo:getClubHeadImg()
		}, {
			isWidget = true
		})

		icon:addTo(self._leftClubIconNode)
		icon.backImg:setVisible(false)
		icon:setScale(1.2)

		local text, huge = CurrencySystem:formatCurrency(self._clubResourcesBattleInfo:getPoint())

		if huge then
			text = text .. "W"
		end

		self._leftClubScoreText:setString(text)
		self._bottomCurrentScore:setString(text)

		if self._clubResourcesBattleInfo:getStatus() == "END" then
			if self._clubResourcesBattleInfo:getWin() then
				self._leftDarkPanel:setVisible(false)
			else
				self._leftDarkPanel:setVisible(true)
			end
		end

		if self._clubResourcesBattleInfo:getResouceBassInfo() ~= nil then
			local data = self._clubResourcesBattleInfo:getResouceBassInfo()
			local goldIcon = IconFactory:createPic({
				id = data.id
			})

			self._leftIconNode:addChild(goldIcon)
		end
	end

	if self._clubResourcesBattleInfo:getTargetClubId() ~= "" then
		self._rightClubNameText:setString(self._clubResourcesBattleInfo:getTargetClubName())

		local icon = IconFactory:createClubIcon({
			id = self._clubResourcesBattleInfo:getTargetClubHeadImg()
		}, {
			isWidget = true
		})

		icon:addTo(self._rightClubIconNode)
		icon.backImg:setVisible(false)
		icon:setScale(1.2)

		local text, huge = CurrencySystem:formatCurrency(self._clubResourcesBattleInfo:getTargetPoint())

		if huge then
			text = text .. "W"
		end

		self._rightClubScoreText:setString(text)

		if self._clubResourcesBattleInfo:getStatus() == "END" then
			if self._clubResourcesBattleInfo:getWin() then
				self._rightDarkPanel:setVisible(true)
			else
				self._rightDarkPanel:setVisible(false)
			end
		end

		if self._clubResourcesBattleInfo:getResouceBassInfo() ~= nil then
			local data = self._clubResourcesBattleInfo:getResouceBassInfo()
			local goldIcon = IconFactory:createPic({
				id = data.id
			})

			self._rightIconNode:addChild(goldIcon)
		end
	else
		self._rightClubNameText:setString(Strings:get("Club_ResourceBattle_7"))
		self._rightClubScoreText:setVisible(false)
	end
end

function ClubResourcesBattleMediator:doBothClubScoreViewLogic()
	if self._clubResourcesBattleInfo:getClubId() ~= "" and self._clubResourcesBattleInfo:getTargetClubId() ~= "" then
		local selfScore = self._clubResourcesBattleInfo:getPoint()
		local targetScore = self._clubResourcesBattleInfo:getTargetPoint()

		if targetScore > 0 or selfScore > 0 then
			local leftRate = selfScore / (selfScore + targetScore)
			local rightRate = 1 - leftRate
			local leftWidth = leftRate * 1100
			local rightWidth = rightRate * 1100

			if leftWidth < 318 then
				leftWidth = 318
			end

			if leftWidth > 818 then
				leftWidth = 818
			end

			if rightWidth < 318 then
				rightWidth = 318
			end

			if rightWidth > 818 then
				rightWidth = 818
			end

			self._leftClubPanel:setContentSize(cc.size(leftWidth, 130))
			self._leftDarkPanel:setContentSize(cc.size(leftWidth, 130))
			self._rightClubPanel:setContentSize(cc.size(rightWidth, 130))
			self._rightDarkPanel:setContentSize(cc.size(rightWidth, 130))
			self._rightClubPanel:setPositionX(1136)

			local basePanel = self._rightClubPanel:getChildByFullName("basePanel")

			basePanel:setPositionX(rightWidth)
			self._vsNode:setPositionX(leftWidth)

			if leftRate < rightRate then
				self._vsLineImage:setFlippedX(true)
			end
		end
	end
end

function ClubResourcesBattleMediator:creatScoreRankTableView()
	if self._leftTableView == nil then
		self:createTableView(1)
	else
		local offset = self._leftTableView:getContentOffset()

		self._leftTableView:reloadData()
		self._leftTableView:setContentOffset(offset)
	end

	if self._rightTableView == nil then
		self:createTableView(2)
	else
		local offset = self._rightTableView:getContentOffset()

		self._rightTableView:reloadData()
		self._rightTableView:setContentOffset(offset)
	end

	if self._clubResourcesBattleInfo:getStatus() == "END" then
		if self._clubResourcesBattleInfo:getWin() then
			self._rightTableDarkPanel:setVisible(true)
			self._leftTableDarkPanel:setVisible(false)
		else
			self._rightTableDarkPanel:setVisible(false)
			self._leftTableDarkPanel:setVisible(true)
		end
	end
end

function ClubResourcesBattleMediator:setupTopInfoWidget()
	local resourceBaseInfo = self._clubResourcesBattleInfo:getResouceBassInfo()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Hero_Quality")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		stopAnim = true,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get(resourceBaseInfo.titleName)
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)

	local titlePanel = topInfoNode:getChildByFullName("titlePanel")

	if titlePanel:getChildByName("InfoSprite") == nil then
		local image = ccui.ImageView:create("asset/common/common_btn_xq.png")

		image:addTo(titlePanel):posite(310, 40)
		image:setScale(0.6)
		image:setName("InfoSprite")
		image:setTouchEnabled(true)
		image:addClickEventListener(function()
			self:onClickShowActivityInfo()
		end)
	end
end

function ClubResourcesBattleMediator:refreshData()
	self._clubResourcesBattleInfo = self._developSystem:getPlayer():getClub():getClubResourcesBattleInfo()
	self._leftPlayerList = self._clubResourcesBattleInfo:getSelfClubSocreList()
	self._rightPlayerList = self._clubResourcesBattleInfo:getTargetClubSocreList()
	self._scrollDataList = self._clubResourcesBattleInfo:getScoreRewardData()
end

function ClubResourcesBattleMediator:refreshView()
	self:createRewardScrollView()
	self:refreshBothClubInfoView()
	self:doBothClubScoreViewLogic()
	self:creatScoreRankTableView()
	self:doWordLogic()
	self:updateRemainTime()
	self:doSuccessLogic()
end

function ClubResourcesBattleMediator:createRewardScrollView()
	local offset

	if self._rewardScrollView == nil then
		local size = self._bottomScorePanel:getContentSize()
		local rewardScrollView = ccui.ScrollView:create()

		rewardScrollView:setTouchEnabled(true)
		rewardScrollView:setBounceEnabled(false)
		rewardScrollView:setDirection(ccui.ScrollViewDir.horizontal)
		rewardScrollView:setContentSize(size)
		rewardScrollView:setPosition(cc.p(0, 0))
		rewardScrollView:setAnchorPoint(cc.p(0, 0))
		self._bottomScorePanel:addChild(rewardScrollView)

		self._rewardScrollView = rewardScrollView
	else
		offset = self._rewardScrollView:getInnerContainerPosition()
	end

	self._rewardScrollView:removeAllChildren()

	local length = #self._scrollDataList
	local contentNode = cc.Node:create()

	self._rewardScrollView:addChild(contentNode)

	local frontImage = self._frontImage:clone()

	frontImage:setVisible(true)
	contentNode:addChild(frontImage)
	frontImage:setPosition(cc.p(0, 102))

	local currentOffX = 0
	local allWidth = 120 * length + 60

	for index = 1, length do
		local cell, markWidth, toNext = self:createScrollCell(index, index == length)

		contentNode:addChild(cell, length - index, length - index)
		cell:setPosition(cc.p(-35 + 120 * (index - 1), 0))

		if markWidth > -1 then
			local scoreMark = self._scoreMark:clone()

			scoreMark:setVisible(true)

			local scoreText = scoreMark:getChildByName("scoreText")

			contentNode:addChild(scoreMark, length, length)

			if index == 1 then
				if markWidth < 85 then
					scoreMark:setPosition(cc.p(85, 102))
				else
					scoreMark:setPosition(cc.p(markWidth, 102))
				end
			else
				scoreMark:setPosition(cc.p(markWidth + 120 * (index - 1), 102))
			end

			currentOffX = 480 - (markWidth + 120 * (index - 1))

			if toNext == 0 then
				if index == length then
					scoreMark:setVisible(false)
				else
					toNext = index == 1 and self._scrollDataList[index].targetScore or self._scrollDataList[index + 1].targetScore - self._scrollDataList[index].targetScore
				end
			end

			local text, huge = CurrencySystem:formatCurrency(toNext)

			if huge then
				text = text .. "W"
			end

			scoreText:setString(text)
		end
	end

	local size = self._rewardScrollView:getContentSize()

	size.height = 220
	size.width = allWidth

	self._rewardScrollView:setInnerContainerSize(size)

	if offset then
		self._rewardScrollView:setInnerContainerPosition(offset)
	elseif currentOffX < 0 then
		self._rewardScrollView:setInnerContainerPosition(cc.p(currentOffX, 0))
	end
end

function ClubResourcesBattleMediator:createScrollCell(index, isLast)
	local markWidth = -1
	local toNext = 0
	local currentScore = self._clubResourcesBattleInfo:getPoint()
	local currentIndexData = self._scrollDataList[index]
	local lastDataScore = 0

	if index > 1 then
		lastDataScore = self._scrollDataList[index - 1].targetScore
	end

	local panel = self._scrollCellPanel:clone()

	panel:setVisible(true)

	local LoadingBar_1 = panel:getChildByName("LoadingBar_1")
	local Image_7 = panel:getChildByName("Image_7")
	local fullImage = panel:getChildByName("fullImage")
	local emptyImage = panel:getChildByName("emptyImage")
	local lastEmptyImage = panel:getChildByName("lastEmptyImage")

	lastEmptyImage:setVisible(false)

	local fullText = panel:getChildByName("fullText")
	local emptyText = panel:getChildByName("emptyText")
	local vPanel = panel:getChildByName("vPanel")
	local vDarkPanel = panel:getChildByName("vDarkPanel")

	vDarkPanel:setVisible(false)

	local fPanel = panel:getChildByName("fPanel")
	local fDarkPanel = panel:getChildByName("fDarkPanel")

	fDarkPanel:setVisible(false)
	fullText:setString(tostring(index))
	emptyText:setString(tostring(index))

	local width = 120

	if currentScore <= currentIndexData.targetScore then
		if currentScore <= lastDataScore then
			LoadingBar_1:setVisible(false)
			fullImage:setVisible(false)
			fullText:setVisible(false)
		else
			LoadingBar_1:setVisible(true)

			local rate = (currentScore - lastDataScore) / (currentIndexData.targetScore - lastDataScore)

			LoadingBar_1:setPercent(rate * 100)
			fullImage:setVisible(false)
			fullText:setVisible(false)

			markWidth = width * rate
			toNext = currentIndexData.targetScore - currentScore

			if rate >= 1 then
				fullImage:setVisible(true)
				fullText:setVisible(true)
				emptyImage:setVisible(false)
				emptyText:setVisible(false)
			end
		end

		if isLast == true then
			lastEmptyImage:setVisible(true)
		end
	else
		LoadingBar_1:setVisible(true)
		LoadingBar_1:setPercent(100)
		emptyImage:setVisible(false)
		emptyText:setVisible(false)
	end

	if currentIndexData.baseRewardId ~= nil and currentIndexData.baseRewardData ~= nil then
		fPanel:setTouchEnabled(true)
		fPanel:setSwallowTouches(false)
		fPanel:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
				self:onClickRewardPanel(sender, 1, currentIndexData)
			end
		end)

		local icon = IconFactory:createRewardIcon(currentIndexData.baseRewardData, {
			isWidget = true
		})

		icon:addTo(fPanel)
		icon:setPosition(cc.p(30, 30))

		if currentIndexData.isBaseBig > 0 then
			icon:setScale(0.68)
		else
			icon:setScale(0.56)
		end

		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), currentIndexData.baseRewardData, {
			needDelay = true
		})

		if currentIndexData.baseRewardHasGet then
			fDarkPanel:setVisible(true)

			if currentIndexData.isBaseBig > 0 then
				fDarkPanel:setScale(1.2143)
			end
		elseif currentIndexData.canBaseReward then
			local fangAnim = cc.MovieClip:create("fang_tongxingzheng")

			fangAnim:setPosition(cc.p(22, 30))
			fangAnim:addTo(fPanel)
			fangAnim:setScale(1.1)

			if currentIndexData.isBaseBig > 0 then
				fangAnim:setScale(1.3)
			end
		end
	end

	if currentIndexData.winRewardId ~= nil and currentIndexData.winRewardData ~= nil then
		vPanel:setTouchEnabled(true)
		vPanel:setSwallowTouches(false)
		vPanel:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
				self:onClickRewardPanel(sender, 2, currentIndexData)
			end
		end)

		local icon = IconFactory:createRewardIcon(currentIndexData.winRewardData, {
			isWidget = true
		})

		icon:addTo(vPanel)
		icon:setPosition(cc.p(30, 30))

		if currentIndexData.isWinBig > 0 then
			icon:setScale(0.68)
		else
			icon:setScale(0.56)
		end

		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), currentIndexData.winRewardData, {
			needDelay = true
		})

		if currentIndexData.winRewardHasGet then
			vDarkPanel:setVisible(true)

			if currentIndexData.isWinBig > 0 then
				vDarkPanel:setScale(1.2143)
			end
		elseif currentIndexData.canWinReward then
			local fangAnim = cc.MovieClip:create("fang_tongxingzheng")

			fangAnim:setPosition(cc.p(22, 30))
			fangAnim:addTo(vPanel)
			fangAnim:setScale(1.1)

			if currentIndexData.isWinBig > 0 then
				fangAnim:setScale(1.3)
			end
		end
	end

	return panel, (currentScore == 0 and lastDataScore == 0 or nil) and 0, toNext
end

function ClubResourcesBattleMediator:createTableView(leftOrRight)
	local function cellSizeForTable(table, idx)
		return 300, 32
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local layout = ccui.Layout:create()

			layout:addTo(cell):posite(0, 0)
			layout:setAnchorPoint(cc.p(0, 0))
			layout:setTag(123)
		end

		local tag = table:getTag()
		local cell_Old = cell:getChildByTag(123)

		self:createCell(cell_Old, ((tag == 2 or nil) and self._rightPlayerList)[idx + 1], idx + 1, leftOrRight)
		cell:setTag(idx)

		return cell
	end

	local function numberOfCellsInTableView(table)
		local tag = table:getTag()

		return tag == 1 and #self._leftPlayerList or #self._rightPlayerList
	end

	local size = self._leftTablePanel:getContentSize()
	local tableView = cc.TableView:create((leftOrRight == 2 or nil) and self._rightTablePanel:getContentSize())

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:setPosition(0, 0)
	tableView:setAnchorPoint(0, 0)
	tableView:setMaxBounceOffset(36)
	tableView:setTag(leftOrRight)

	if leftOrRight == 1 then
		self._leftTableView = tableView

		self._leftTablePanel:addChild(tableView, 1)
	else
		self._rightTableView = tableView

		self._rightTablePanel:addChild(tableView, 1)
	end

	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:reloadData()
	tableView:setBounceable(false)
end

function ClubResourcesBattleMediator:createCell(cell, data, rank, leftOrRight)
	cell:removeAllChildren()

	local panel = self._tableCellPanel:clone()

	panel:setVisible(true)
	panel:addTo(cell):posite(0, 0)

	local rank_1 = panel:getChildByName("rank_1")

	rank_1:setVisible(rank == 1)

	local rank_2 = panel:getChildByName("rank_2")

	rank_2:setVisible(rank == 2)

	local rank_3 = panel:getChildByName("rank_3")

	rank_3:setVisible(rank == 3)

	local rank_4 = panel:getChildByName("rank_4")

	rank_4:setString(tostring(rank))
	rank_4:setVisible(rank >= 4)

	local nameText = panel:getChildByName("nameText")

	nameText:setString(data.name)

	local text, huge = CurrencySystem:formatCurrency(data.score)

	if huge then
		text = text .. "W"
	end

	local scoreText = panel:getChildByName("scoreText")

	scoreText:setString(text)

	local Image_55 = panel:getChildByName("Image_55")

	if self._developSystem:getPlayer():getNickName() == data.name and data.name ~= "" and leftOrRight == 1 then
		Image_55:setVisible(true)
	else
		Image_55:setVisible(false)
	end

	if rank == 1 then
		nameText:setColor(cc.c3b(255, 208, 20))
		scoreText:setColor(cc.c3b(255, 208, 20))
	else
		nameText:setColor(cc.c3b(255, 255, 255))
		scoreText:setColor(cc.c3b(255, 255, 255))
	end
end

function ClubResourcesBattleMediator:doWordLogic()
	local Image_wei = self._wordNode:getChildByName("Image_wei")
	local Image_lie = self._wordNode:getChildByName("Image_lie")
	local Image_li = self._wordNode:getChildByName("Image_li")
	local Image_po = self._wordNode:getChildByName("Image_po")
	local Image_you = self._wordNode:getChildByName("Image_you")

	Image_wei:setVisible(false)
	Image_lie:setVisible(false)
	Image_li:setVisible(false)
	Image_po:setVisible(false)
	Image_you:setVisible(false)

	if self._clubResourcesBattleInfo:getStatus() == "END" then
		return
	end

	if self._clubResourcesBattleInfo:getClubId() ~= "" and self._clubResourcesBattleInfo:getTargetClubId() ~= "" then
		local selfScore = self._clubResourcesBattleInfo:getPoint()
		local targetScore = self._clubResourcesBattleInfo:getTargetPoint()

		if selfScore == 0 and targetScore == 0 then
			Image_li:setVisible(true)
		else
			local leftRate = selfScore / (selfScore + targetScore)

			if leftRate > 0.5 then
				Image_you:setVisible(true)

				if leftRate > 0.75 then
					Image_you:setVisible(false)
					Image_po:setVisible(true)
				end
			elseif leftRate == 0.5 then
				Image_li:setVisible(true)
			else
				Image_lie:setVisible(true)

				if leftRate < 0.25 then
					Image_lie:setVisible(false)
					Image_wei:setVisible(true)
				end
			end
		end
	end
end

function ClubResourcesBattleMediator:doSuccessLogic()
	if self._clubResourcesBattleInfo:getStatus() == "END" then
		self._leftResultAnmNode:removeAllChildren()
		self._rightResultAnmNode:removeAllChildren()

		local winAnim = cc.MovieClip:create("shengliz_jingjijiesuan")

		winAnim:addEndCallback(function()
			winAnim:stop()
		end)
		winAnim:setPositionY(30)

		local winPanel = winAnim:getChildByFullName("winTitle")
		local title = ccui.ImageView:create("zhandou_txt_win.png", 1)

		title:addTo(winPanel)
		winAnim:setScale(0.45)

		local failAnim = cc.MovieClip:create("shibaiz_jingjijiesuan")

		failAnim:addEndCallback(function()
			failAnim:stop()
		end)
		failAnim:setPositionY(-40)

		local losePanel = failAnim:getChildByFullName("loseTitle")
		local title = ccui.ImageView:create("zhandou_txt_fail.png", ccui.TextureResType.plistType)

		title:addTo(losePanel)
		failAnim:setScale(0.45)

		if self._clubResourcesBattleInfo:getWin() then
			self._leftResultAnmNode:addChild(winAnim)
			self._rightResultAnmNode:addChild(failAnim)
		else
			self._rightResultAnmNode:addChild(winAnim)
			self._leftResultAnmNode:addChild(failAnim)
		end
	end
end

function ClubResourcesBattleMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end
end

function ClubResourcesBattleMediator:updateRemainTime()
	if self._clubResourcesBattleInfo:getStatus() == "END" then
		self._timeText:setString(Strings:get("Club_ResourceBattle_15"))

		if self._clubResourcesBattleInfo:getNextMillis() == -1 then
			self._timer:stop()

			self._timer = nil

			return
		end
	end

	if not self._timer then
		local remoteTimestamp = self._gameServerAgent:remoteTimestamp()

		local function checkTimeFunc()
			local refreshTiem = self._clubResourcesBattleInfo:getNextMillis() / 1000

			if self._clubResourcesBattleInfo:getStatus() ~= "END" then
				self._requestTime = self._requestTime - 1

				if self._requestTime < 0 then
					self._requestTime = 10

					self:refreshAllData()
				end
			end

			remoteTimestamp = self._gameServerAgent:remoteTimestamp()

			local remainTime = refreshTiem - remoteTimestamp

			if remainTime <= 0 then
				self:refreshAllData()

				if self._clubResourcesBattleInfo:getStatus() == "END" then
					self:dismiss()

					return
				end
			end

			self:refreshRemainTime(remainTime)
		end

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	end
end

function ClubResourcesBattleMediator:refreshRemainTime(remainTime)
	local str = self._clubSystem:getRemainTime(remainTime)

	if self._clubResourcesBattleInfo:getStatus() == "NOTOPEN" then
		local timeStr = Strings:get("Club_ResourceBattle_8")

		self._timeText:setString(timeStr)
	end

	if self._clubResourcesBattleInfo:getStatus() == "MATCHING" then
		local timeStr = Strings:get("Club_ResourceBattle_8")

		self._timeText:setString(timeStr)
	end

	if self._clubResourcesBattleInfo:getStatus() == "OPEN" then
		local timeStr = Strings:get("Club_ResourceBattle_10") .. str

		self._timeText:setString((remainTime < 0 or nil) and Strings:get("Club_ResourceBattle_15"))
	end

	if self._clubResourcesBattleInfo:getStatus() == "END" then
		self._timeText:setString(Strings:get("Club_ResourceBattle_15"))
	end
end

function ClubResourcesBattleMediator:refreshAllData()
	if self._isDoingRequestData == true then
		return
	end

	self._clubSystem:requestClubBattleData(function()
		if DisposableObject:isDisposed(self) == false then
			self._isDoingRequestData = false
		end
	end, true)
end

function ClubResourcesBattleMediator:onClickBack()
	self:dismiss()
end

function ClubResourcesBattleMediator:onClickShowActivityInfo()
	local HitCharts_Start = ConfigReader:getRecordById("ConfigValue", "HitCharts_Start").content
	local HitCharts_End = ConfigReader:getRecordById("ConfigValue", "HitCharts_End").content
	local tiemData = self._clubResourcesBattleInfo:getStartTimeAndEndTime()
	local param1 = ""
	local param2 = ""

	if HitCharts_Start and HitCharts_End then
		param1 = self._clubSystem:getRemainTime(HitCharts_Start, true)

		if tiemData.startTime and tiemData.endTime then
			local remainTime = tiemData.endTime - tiemData.startTime - HitCharts_Start - HitCharts_End

			param2 = self._clubSystem:getRemainTime(remainTime, true)
		end
	end

	local RuleDesc = ConfigReader:getRecordById("ConfigValue", "HitCharts_Rule").content.Desc

	if RuleDesc ~= nil then
		local view = self:getInjector():getInstance("ArenaRuleView")
		local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			useParam = true,
			rule = RuleDesc,
			param1 = param1,
			param2 = param2
		}, nil)

		self:dispatch(event)
	end
end

function ClubResourcesBattleMediator:onClickRewardPanel(sender, baseOrWin, rewardData)
	if baseOrWin == 1 then
		if rewardData.isBaseRewardBox == true then
			-- block empty
		elseif rewardData.baseRewardHasGet then
			return
		elseif rewardData.canBaseReward then
			self._clubSystem:requestClubBattleReward(rewardData.index, baseOrWin - 1)
		else
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("Club_ResourceBattle_11")
			}))

			return
		end
	elseif rewardData.isWinRewardBox then
		-- block empty
	elseif rewardData.winRewardHasGet then
		return
	elseif rewardData.canWinReward then
		self._clubSystem:requestClubBattleReward(rewardData.index, baseOrWin - 1)
	else
		if rewardData.winScoreEnough == true then
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("Club_ResourceBattle_13")
			}))

			return
		end

		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = Strings:get("Club_ResourceBattle_11")
		}))

		return
	end
end

function ClubResourcesBattleMediator:onForcedLevel(event)
	if DisposableObject:isDisposed(self) then
		return
	end

	self:dismiss()
end

function ClubResourcesBattleMediator:runStartAction()
	print("runStartAction")
	self._mainPanel:stopAllActions()

	local action1 = cc.CSLoader:createTimeline("asset/ui/ClubResourcesBattle.csb")

	self._mainPanel:runAction(action1)
	action1:clearFrameEventCallFunc()
	action1:gotoFrameAndPlay(0, 14, false)
	action1:setTimeSpeed(1)
	performWithDelay(self:getView(), function()
		local anim = cc.MovieClip:create("vsdonghua_jieshedabang")

		anim:addTo(self._vsNode, 1)
		anim:gotoAndPlay(1)
		anim:addCallbackAtFrame(14, function()
			anim:stop()

			local anim_1 = cc.MovieClip:create("vsbenti_jieshedabang")

			anim_1:addTo(self._vsNode, 2)
			anim_1:gotoAndPlay(1)
		end)
	end, 0.23333333333333334)
end
