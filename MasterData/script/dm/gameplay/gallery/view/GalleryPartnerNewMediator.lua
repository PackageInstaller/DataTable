-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryPartnerNewMediator.lua

GalleryPartnerNewMediator = class("GalleryPartnerNewMediator", DmAreaViewMediator, _M)

GalleryPartnerNewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryPartnerNewMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")
GalleryPartnerNewMediator:has("_customDataSystem", {
	is = "r"
}):injectWith("CustomDataSystem")

local kBtnHandlers = {
	["main.rewardBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickReward"
	}
}
local kNums = 4
local kRarityBg = {
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"gallery_img_hblb_r.png",
	"gallery_img_hblb_r.png",
	"gallery_img_hblb_sr.png",
	"gallery_img_hblb_ssr.png",
	"gallery_img_hblb_ur.png"
}
local changeType = {
	{
		index = 1,
		titleStr = Strings:get("Force_Screen")
	},
	{
		index = 2,
		titleStr = Strings:get("HEROS_UI35")
	},
	{
		index = 3,
		titleStr = Strings:get("HEROS_UI30")
	}
}

function GalleryPartnerNewMediator:initialize()
	super.initialize(self)
end

function GalleryPartnerNewMediator:dispose()
	self._customDataSystem:setValue(PrefixType.kGlobal, "GalleryAlbumType", self._albumType)
	super.dispose(self)
end

function GalleryPartnerNewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshBySync)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROCOMPOSE_SUCC, self, self.refreshBySync)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_GALLERY_BOX_GET_SUCC, self, self.refreshRewardRedPoint)
end

function GalleryPartnerNewMediator:enterWithData(data)
	self._main = self:getView():getChildByFullName("main")

	self:setupTopInfoWidget()
	self:setupView(data)
	self:runStartAnim()
end

function GalleryPartnerNewMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function GalleryPartnerNewMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function GalleryPartnerNewMediator:setupView(data)
	self:initData(data)
	self:initWidgetInfo()
	self:initBottomView()
	self:initView()
	self:refreshView(true, true)
	self:initChangePanel()
end

function GalleryPartnerNewMediator:refreshBySync()
	self:refreshData()
	self:refreshView()
end

function GalleryPartnerNewMediator:initWidgetInfo()
	self._bonusPanel = self._main:getChildByFullName("bonusPanel")

	self._bonusPanel:setVisible(false)

	self._loveCount = self._main:getChildByFullName("loveCount")
	self._title = self._main:getChildByFullName("title")
	self._desc = self._main:getChildByFullName("desc")

	self._desc:getVirtualRenderer():setLineHeight(24)

	self._currencyNum = self._main:getChildByFullName("currencyNum")
	self._totalNum = self._main:getChildByFullName("totalNum")
	self._tableViewPanel = self._main:getChildByFullName("tableView")
	self._tabPanelDark = self._main:getChildByFullName("tabPanelDark")
	self._tabPanelLight = self._main:getChildByFullName("tabPanelLight")
	self._rewardBtn = self._main:getChildByFullName("rewardBtn")
	self._cellClone = self._main:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)

	self._partyNode = self._main:getChildByFullName("partyNode")
	self._progressPanel = self._main:getChildByFullName("progressPanel")
	self._touchLayer = self:getView():getChildByFullName("touchLayer")

	self._touchLayer:setVisible(false)

	self._btnClone_2 = self:getView():getChildByFullName("btnClone_2")

	self._btnClone_2:setVisible(false)

	self._bottomPanel = self._main:getChildByFullName("bottomPanel")
	self._buttonNode = self._main:getChildByFullName("bottomPanel.buttonNode")

	self._cellClone:getChildByFullName("loveIcon.text"):enableOutline(cc.c4b(60, 80, 20, 127), 2)
	self._loveCount:getChildByFullName("touchPanel"):setTouchEnabled(true)
	self._loveCount:getChildByFullName("touchPanel"):addTouchEventListener(function(sender, eventType)
		self:onClickBonus(sender, eventType, self._attrData)
	end)
	self._bottomPanel:getChildByFullName("infoBtn"):setTouchEnabled(true)
	self._bottomPanel:getChildByFullName("infoBtn"):addTouchEventListener(function(sender, eventType)
		self:onClickInfoBtn(sender, eventType, self._attrData)
	end)

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._posY_table = self._tableViewPanel:getPositionY()
	self._selectPanel = self._main:getChildByName("Panel_select")
end

function GalleryPartnerNewMediator:initData(data)
	self._albumType = tonumber(self._customDataSystem:getValue(PrefixType.kGlobal, "GalleryAlbumType", 1))

	if data and data.tabType then
		self._tabType = data.tabType or 1
	end

	self._albumArray = self._gallerySystem:getPartyArray()
	self._partyArray = self._albumArray[self._albumType]
	self._curPartyData = self._partyArray[self._tabType]

	self:doLogicForShowHeros()

	self._tabCache = {}
	self._bottomTabCache = {}
	self._attrData = self._gallerySystem:getLoveAddAttr()
	self._tabSelect = {}
	self._tabSelect[self._albumType] = self._tabType
	self._selectTab = false
	self._tabMax = #self._partyArray
end

function GalleryPartnerNewMediator:initView()
	local width = self._tableViewPanel:getContentSize().width

	local function scrollViewDidScroll(view)
		if DisposableObject:isDisposed(self) then
			return
		end

		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		return width, 197
	end

	local function numberOfCellsInTableView(table)
		return math.ceil(#self._selectShowHeros / kNums)
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:createTeamCell(cell, idx + 1)

		return cell
	end

	local tableView = cc.TableView:create(self._tableViewPanel:getContentSize())

	self._heroView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	self._tableViewPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
end

function GalleryPartnerNewMediator:createTeamCell(cell, index)
	cell:removeAllChildren()

	local list = self._selectShowHeros

	for i = 1, kNums do
		local id = list[kNums * (index - 1) + i]

		if id then
			local panel = self._cellClone:clone()

			panel:setVisible(true)
			panel:setTag(i)
			panel:setAnchorPoint(cc.p(0.5, 0.5))

			local rarity = panel:getChildByFullName("rarity")
			local linkImage = panel:getChildByFullName("linkImage")

			if self._heroSystem:isLinkStageHero(id) then
				linkImage:setVisible(true)
			else
				linkImage:setVisible(false)
			end

			local hero = self._heroSystem:getHeroById(id)

			rarity:setVisible(not not hero)

			local roleModel = IconFactory:getRoleModelByKey("HeroBase", id)

			if hero then
				roleModel = hero:getModel()

				local heroRewards = self._gallerySystem:getHeroRewards()
				local canGet = not heroRewards[id]

				if canGet then
					local redPoint = ccui.ImageView:create(IconFactory.redPointPath1, 1)

					redPoint:addTo(panel):posite(137, 184):setScale(0.8)
				end

				local rarityBg = panel:getChildByFullName("rarityBg")

				rarityBg:loadTexture(kRarityBg[hero:getRarity()], 1)

				rarity = rarity:getChildByFullName("rarity")

				local rarityNum = hero:getRarity()

				rarity:loadTexture(GameStyle:getHeroRarityImage(rarityNum), 1)
				rarity:ignoreContentAdaptWithSize(true)
			end

			local heroPanel = panel:getChildByFullName("heroPanel")

			heroPanel:setSwallowTouches(false)
			heroPanel:addTouchEventListener(function(sender, eventType)
				self:onClickHeroIcon(sender, eventType, id)
			end)

			local heroIcon = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe7_4",
				id = roleModel
			})

			heroIcon:addTo(heroPanel)
			heroIcon:setAnchorPoint(cc.p(0.5, 0.5))
			heroIcon:setPosition(cc.p(65.5, 87.5))

			if not self._heroSystem:hasHero(id) then
				panel:setGray(true)
				panel:getChildByFullName("lockIcon"):setVisible(true)
				panel:getChildByFullName("loveIcon"):setVisible(false)
			else
				panel:getChildByFullName("lockIcon"):setVisible(false)
				panel:getChildByFullName("loveIcon"):setVisible(true)

				local hero = self._heroSystem:getHeroById(id)
				local loveNum = hero:getLoveLevel()

				panel:getChildByFullName("loveIcon.text"):setString(loveNum)
			end

			panel:addTo(cell)

			local panelWidth = panel:getContentSize().width
			local posX = panelWidth / 2 + (panelWidth - 12) * (i - 1)

			panel:setPosition(cc.p(posX - 10, 95))

			panel.id = id
			cell.panelList = cell.panelList or {}
			cell.panelList[i] = panel
		end
	end
end

function GalleryPartnerNewMediator:initBottomView()
	self._buttonNode:removeAllChildren()

	self._bottomTabCache = {}

	local cellInterval = 90
	local cellWidth = 70
	local start_x = cellWidth / 2 - 10 + math.floor(#self._partyArray / 2) * -cellInterval + 20 + #self._partyArray % 2 * -55
	local start_y = 0
	local cloneBaseNode = self._btnClone_2

	cellInterval = 74
	cellWidth = 40
	start_x = cellWidth / 2 - 22.5 + math.floor(#self._partyArray / 2) * -cellInterval + 45 + #self._partyArray % 2 * -65
	start_y = 0

	local cloneBaseNode1 = self:getView():getChildByFullName("btnClone_2_0")

	for i = 1, #self._partyArray do
		local data = self._partyArray[i]
		local btn = i == self._tabMax and cloneBaseNode1:clone() or cloneBaseNode:clone()

		btn:setVisible(true)
		btn:addTo(self._buttonNode):posite(0, start_y - (i - 1) * cellInterval)

		local redPoint = btn:getChildByFullName("redPoint")
		local touchPanel = btn:getChildByFullName("touchPanel")

		touchPanel:addClickEventListener(function()
			self:onClickBottomTab(i)
		end)

		local icon = data:getIcon()
		local darkImg = btn:getChildByFullName("Image_dark")
		local lightImg = btn:getChildByFullName("Image_light")

		lightImg:loadTexture(icon[1] .. ".png", ccui.TextureResType.plistType)
		darkImg:loadTexture(icon[2] .. ".png", ccui.TextureResType.plistType)

		self._bottomTabCache[i] = self._bottomTabCache[i] or {
			lightImg,
			darkImg,
			redPoint
		}
	end
end

function GalleryPartnerNewMediator:refreshData(changeAlbumType)
	if changeAlbumType then
		self._albumArray = self._gallerySystem:getPartyArray()
		self._partyArray = self._albumArray[self._albumType]
		self._tabMax = #self._partyArray
	end

	self._curPartyData = self._partyArray[self._tabType] or self._partyArray[kNums - 1]

	self:doLogicForShowHeros()

	self._attrData = self._gallerySystem:getLoveAddAttr()
end

function GalleryPartnerNewMediator:refreshView(hideReload, changeAlbumType)
	self:refreshBottomView()
	self:refreshBottomTabStatus()
	self:refreshRewardRedPoint()

	if not hideReload then
		self._heroView:stopScroll()
		self._heroView:reloadData()
	end

	self._title:setString(self._curPartyData:getTitle())
	self._desc:setString(self._curPartyData:getDesc())

	local curNum, totalNum = self._gallerySystem:getCurNums(self._showHeros)

	self._currencyNum:setString(curNum)
	self._totalNum:setString("/" .. totalNum)
	self._partyNode:removeAllChildren()

	local icon = self._curPartyData:getIcon()

	if icon[3] then
		local img_party = ccui.ImageView:create(icon[3] .. ".png", ccui.TextureResType.plistType)

		img_party:setAnchorPoint(cc.p(0.5, 0.5))
		img_party:addTo(self._partyNode)
	end

	local label = self._loveCount:getChildByName("loveNum")
	local loveLevel = self._gallerySystem:getTotalLoveLevel()

	label:setString(loveLevel)
end

function GalleryPartnerNewMediator:refreshBottomView()
	self._redPointTab = {}

	for i = 1, #self._partyArray do
		local data = self._partyArray[i]
		local redPoint = self._bottomTabCache[i][3]

		if i == self._tabMax then
			local r = table.indexof(self._redPointTab, true)

			redPoint:setVisible(r ~= nil)
		else
			local canGain = self._gallerySystem:checkcanReceive(data:getPartyId())

			canGain = canGain or self._gallerySystem:checkCanGetHeroReward(data:getPartyId())

			table.insert(self._redPointTab, canGain)
			redPoint:setVisible(canGain)
		end
	end
end

function GalleryPartnerNewMediator:refreshBottomTabStatus()
	for i = 1, #self._bottomTabCache do
		self._bottomTabCache[i][1]:setVisible(self._tabType == i)

		if self._bottomTabCache[i][2] then
			self._bottomTabCache[i][2]:setVisible(self._tabType ~= i)
		end
	end

	local colectText = self._bottomPanel:getChildByFullName("colectText")
	local currentScoreText = self._bottomPanel:getChildByFullName("currentScoreText")
	local targetScoreText = self._bottomPanel:getChildByFullName("targetScoreText")
	local loadingNode = self._bottomPanel:getChildByFullName("loadingNode")
	local loadingBar = loadingNode:getChildByName("loading")
	local allCountHero = 0
	local currentCountHero = 0

	for i = 1, #self._showHeros do
		local id = self._showHeros[i]

		if self._heroSystem:isLinkStageHero(id) == false then
			allCountHero = allCountHero + 1

			if self._heroSystem:hasHero(id) then
				currentCountHero = currentCountHero + 1
			end
		end
	end

	if allCountHero ~= 0 then
		loadingNode:setVisible(true)
		colectText:setVisible(true)
		currentScoreText:setVisible(true)
		targetScoreText:setVisible(true)

		local rate = currentCountHero / allCountHero

		colectText:setString(Strings:get("NewAlbum_UI01", {
			percent = string.format("%.1f", rate * 100)
		}) .. "%")
		currentScoreText:setString("" .. currentCountHero)
		targetScoreText:setString("/" .. allCountHero)
		loadingBar:setPercent(rate * 100)
	else
		loadingNode:setVisible(false)
		colectText:setVisible(false)
		currentScoreText:setVisible(false)
		targetScoreText:setVisible(false)
	end
end

function GalleryPartnerNewMediator:refreshRewardRedPoint()
	local canReceive, hasReward = self._gallerySystem:canRevieveReward(self._curPartyData:getPartyId())

	self._rewardBtn:getChildByFullName("redMark"):setVisible(canReceive)
	self._rewardBtn:setVisible(hasReward)
end

function GalleryPartnerNewMediator:onClickHeroIcon(sender, eventType, id)
	if eventType == ccui.TouchEventType.began then
		local parent = sender:getParent()

		self._isReturn = true

		local scale1 = cc.ScaleTo:create(0.1, 0.9)

		parent:runAction(scale1)
	elseif eventType == ccui.TouchEventType.ended then
		local parent = sender:getParent()

		if self._isReturn then
			AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)
			self._touchLayer:setVisible(true)

			local scale3 = cc.ScaleTo:create(0.12, 1)
			local callfunc = cc.CallFunc:create(function()
				local view = self:getInjector():getInstance("GalleryPartnerInfoNewView")

				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
					id = id,
					ids = self._showHeros
				}))

				self._isReturn = true

				self._touchLayer:setVisible(false)
			end)
			local seq = cc.Sequence:create(scale3, callfunc)

			parent:runAction(seq)
		else
			parent:stopAllActions()
			parent:setScale(1)
		end
	elseif eventType == ccui.TouchEventType.canceled then
		local parent = sender:getParent()

		parent:stopAllActions()
		parent:setScale(1)
	end
end

function GalleryPartnerNewMediator:onClickReward()
	local view = self:getInjector():getInstance("GalleryPartnerRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rewardIds = self._curPartyData:getRewardIds(),
		partyType = self._curPartyData:getPartyId(),
		tabType = self._tabType
	}, nil))
end

function GalleryPartnerNewMediator:onClickTab(index)
	AudioEngine:getInstance():playEffect("Se_Click_Tab_Carera", false)

	self._tabSelect[self._albumType] = self._tabType
	self._albumType = index
	self._tabType = self._tabSelect[self._albumType] and self._tabSelect[self._albumType] or 1

	self:refreshData(true)
	self:refreshView(nil, true)
end

function GalleryPartnerNewMediator:onClickBottomTab(index)
	if self._tabType == index then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Tab_Carera", false)

	self._tabType = index

	self:refreshData()
	self:refreshView()
end

function GalleryPartnerNewMediator:onClickBonus(sender, eventType, data)
	if eventType == ccui.TouchEventType.began then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local targetPos = sender:getParent():convertToWorldSpace(cc.p(sender:getPosition()))

		self._bonusPanel:setPositionX(self._bonusPanel:getParent():convertToNodeSpace(targetPos).x)
		self._bonusPanel:setVisible(true)

		local height = self:refreshInnerAttrPanel(data)

		self._bonusPanel:setPositionY(self._bonusPanel:getParent():convertToNodeSpace(targetPos).y + 30 + height)
	elseif eventType == ccui.TouchEventType.canceled or eventType == ccui.TouchEventType.ended then
		self._bonusPanel:setVisible(false)
	end
end

function GalleryPartnerNewMediator:refreshInnerAttrPanel(data)
	local list = data

	if #list == 0 then
		self._bonusPanel:setVisible(false)

		return
	end

	local textLabel = self._bonusPanel:getChildByName("text")

	textLabel:setVisible(false)

	local width = 0
	local height = 23
	local posY = 175

	self._bonusPanel:getChildByName("panel"):removeAllChildren()

	for i = 1, #list do
		local text = textLabel:clone()

		text:setVisible(true)
		text:addTo(self._bonusPanel:getChildByName("panel"))
		text:setTag(12138)
		text:setString(list[i])
		text:setPositionY(posY - (i - 1) * 30)

		width = math.max(width, text:getContentSize().width)
		height = height + 30
	end

	self._bonusPanel:getChildByName("imageBg"):setContentSize(cc.size(width + 40, height))

	return height
end

function GalleryPartnerNewMediator:runStartAnim()
	self._main:stopAllActions()
	self._tableViewPanel:stopAllActions()
	self._main:setPosition(cc.p(1380, -404))
	self._main:setRotation(-15)

	local rotate = cc.RotateTo:create(0.3, 0)
	local moveto1 = cc.MoveTo:create(0.2, cc.p(500, 320))
	local moveto2 = cc.MoveTo:create(0.1, cc.p(568, 320))
	local seq = cc.Sequence:create(moveto1, moveto2)
	local spawn = cc.Spawn:create(rotate, seq)

	self._main:runAction(spawn)
	self._tableViewPanel:setOpacity(0)
	self._loveCount:setOpacity(0)
	self._tableViewPanel:setPosition(cc.p(550, self._posY_table + 30))

	local delay = cc.DelayTime:create(0.4)
	local moveto = cc.MoveTo:create(0.3, cc.p(550, self._posY_table))
	local fadeIn = cc.FadeIn:create(0.2)
	local callback = cc.CallFunc:create(function()
		self._heroView:reloadData()
		self._loveCount:fadeIn({
			time = 0.2
		})
	end)

	spawn = cc.Spawn:create(moveto, fadeIn, callback)

	local endCallFunc = cc.CallFunc:create(function()
		self:setupClickEnvs()
	end)

	seq = cc.Sequence:create(delay, spawn, endCallFunc)

	self._tableViewPanel:runAction(seq)
end

function GalleryPartnerNewMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local cellOne = self._heroView:cellAtIndex(0)

	if cellOne then
		local panelList = cellOne.panelList

		if panelList and panelList[1] then
			local firstPanel = panelList[1]
			local firstPanelId = panelList[1].id

			storyDirector:setClickEnv("GalleryPartnerNewMediator.firstPanel", firstPanel, function(sender, eventType)
				self:onClickHeroIcon(sender, ccui.TouchEventType.began, firstPanelId)
				self:onClickHeroIcon(sender, ccui.TouchEventType.ended, firstPanelId)
			end)
		end
	end

	storyDirector:notifyWaiting("enter_GalleryPartnerNewMediator")
end

function GalleryPartnerNewMediator:onClickInfoBtn(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local targetPos = sender:getParent():convertToWorldSpace(cc.p(sender:getPosition()))

		self._bonusPanel:setPositionX(self._bonusPanel:getParent():convertToNodeSpace(targetPos).x)
		self._bonusPanel:setVisible(true)

		local height = self:refreshInnerAttrPanel({
			Strings:get("NewAlbum_UI04")
		})

		self._bonusPanel:setPositionY(self._bonusPanel:getParent():convertToNodeSpace(targetPos).y + 30 + height)
	elseif eventType == ccui.TouchEventType.canceled or eventType == ccui.TouchEventType.ended then
		self._bonusPanel:setVisible(false)
	end
end

function GalleryPartnerNewMediator:doLogicForShowHeros()
	local Hero_Album_Feminine = ConfigReader:getRecordById("ConfigValue", "Hero_Album_Feminine").content

	self._showHeros = {}

	if self._curPartyData:getType() == 3 then
		for i, v in ipairs(Hero_Album_Feminine) do
			local hero = self._heroSystem:getHeroById(v)

			if hero then
				local rerity = hero:getRarity()

				if rerity == RareityStringToNumber[self._curPartyData:getPartyId()] then
					self._showHeros[#self._showHeros + 1] = v
				end
			end
		end
	end

	local showHeroIds = self._curPartyData:getHeroIds()

	for i = 1, #showHeroIds do
		local ifHidden = ConfigReader:getRecordById("HeroBase", showHeroIds[i]).IfHidden

		if ifHidden == 1 then
			self._showHeros[#self._showHeros + 1] = showHeroIds[i]
		end
	end

	self._selectShowHeros = self._showHeros
end

function GalleryPartnerNewMediator:initChangePanel()
	local upPanel = self._selectPanel:getChildByName("Panel_up")

	upPanel:setVisible(false)

	self._selectButtons = {}

	local count = 1

	for i = 1, 3 do
		local typeData = changeType[i]

		if typeData.index ~= self._albumType then
			local selectBtn = upPanel:getChildByName("select" .. count)
			local nameText = selectBtn:getChildByName("Text_name")

			nameText:setString(typeData.titleStr)

			selectBtn.typeData = typeData

			local function callFunc()
				upPanel:setVisible(false)

				self._albumType = selectBtn.typeData.index
				self._tabType = 1

				self:refreshSelectView()
				self:refreshData(true)
				self:initBottomView()
				self:refreshView()
			end

			mapButtonHandlerClick(nil, selectBtn, {
				func = callFunc
			})

			self._selectButtons[count] = selectBtn
			count = count + 1
		else
			local cueSelectBtn = self._selectPanel:getChildByName("currselect")
			local nameText = cueSelectBtn:getChildByName("Text_name")

			nameText:setString(typeData.titleStr)

			local function callFunc()
				local show = not upPanel:isVisible()

				upPanel:setVisible(show)
			end

			mapButtonHandlerClick(nil, cueSelectBtn, {
				func = callFunc
			})

			self._selectButtons[3] = cueSelectBtn
		end
	end
end

function GalleryPartnerNewMediator:refreshSelectView()
	local count = 1

	for i = 1, 3 do
		local typeData = changeType[i]

		if typeData.index ~= self._albumType then
			local button = self._selectButtons[count]

			button.typeData = typeData

			local nameText = button:getChildByName("Text_name")

			nameText:setString(typeData.titleStr)

			count = count + 1
		else
			local button = self._selectButtons[3]
			local nameText = button:getChildByName("Text_name")

			nameText:setString(typeData.titleStr)
		end
	end
end
