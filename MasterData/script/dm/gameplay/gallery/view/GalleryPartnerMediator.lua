-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryPartnerMediator.lua

GalleryPartnerMediator = class("GalleryPartnerMediator", DmAreaViewMediator, _M)

GalleryPartnerMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryPartnerMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")

local kBtnHandlers = {
	["main.rewardBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickReward"
	}
}
local AlbumGroupType = {
	{
		"Party",
		"Force_Screen"
	},
	{
		"Profession",
		"HEROS_UI35"
	},
	{
		"Rareity",
		"HEROS_UI30"
	}
}
local kNums = 4
local kImageParty = {
	XD = {
		"common_btn_xd.png",
		"img_gallery_sl_xd.png"
	},
	MNJH = {
		"common_btn_mnjh.png",
		"img_gallery_sl_mnjh.png"
	},
	BSNCT = {
		"common_btn_bsn.png",
		"img_gallery_sl_bsn.png"
	},
	DWH = {
		"common_btn_dwh.png",
		"img_gallery_sl_dwh.png"
	},
	WNSXJ = {
		"common_btn_wnsxj.png",
		"img_gallery_sl_wnsxj.png"
	},
	SSZS = {
		"common_btn_smzs.png",
		"img_gallery_sl_smzs.png"
	},
	UNKNOWN = {
		"common_btn_unknown.png",
		"img_gallery_sl_unknown.png"
	}
}
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
	"asset/ui/gallery/album_bg_archives_txd_r.png",
	"asset/ui/gallery/album_bg_archives_txd_r.png",
	"asset/ui/gallery/album_bg_archives_txd_sr.png",
	"asset/ui/gallery/album_bg_archives_txd_ssr.png",
	"asset/ui/gallery/album_bg_archives_txd_sp.png"
}

function GalleryPartnerMediator:initialize()
	super.initialize(self)
end

function GalleryPartnerMediator:dispose()
	super.dispose(self)
end

function GalleryPartnerMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshBySync)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROCOMPOSE_SUCC, self, self.refreshBySync)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_GALLERY_BOX_GET_SUCC, self, self.refreshRewardRedPoint)
end

function GalleryPartnerMediator:enterWithData(data)
	self:setupTopInfoWidget()
	self:setupView(data)
	self:runStartAnim()
end

function GalleryPartnerMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		title = Strings:get("GALLERY_UI1"),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function GalleryPartnerMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function GalleryPartnerMediator:setupView(data)
	self:initData(data)
	self:initWidgetInfo()
	self:initView()
	self:refreshView(true, true)
end

function GalleryPartnerMediator:refreshBySync()
	self:refreshData()
	self:refreshView()
end

function GalleryPartnerMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
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

	self._btnClone_1 = self:getView():getChildByFullName("btnClone_1")

	self._btnClone_1:setVisible(false)

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

	self._slider = self._progressPanel:getChildByFullName("slider")

	self._slider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			self:onSliderChanged()
		end
	end)

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._tableViewPanel:setContentSize(cc.size(630, winSize.height - 128 - 133))

	self._posY_table = self._tableViewPanel:getPositionY()
end

function GalleryPartnerMediator:initData(data)
	if data and data.albumType then
		self._albumType = data.albumType or 1
	end

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
end

function GalleryPartnerMediator:initView()
	for i = 1, #self._albumArray do
		local tabBtn = self._tabPanelLight:getChildByFullName("btn_" .. i)

		tabBtn:addClickEventListener(function()
			self:onClickTab(i)
		end)

		local darkImg = self._tabPanelDark:getChildByFullName("tab_" .. i)
		local lightImg = self._tabPanelLight:getChildByFullName("tab_" .. i)
		local nameText_1 = darkImg:getChildByFullName("nameText")
		local nameText_2 = lightImg:getChildByFullName("nameText")

		nameText_1:getVirtualRenderer():setDimensions(60, 35)
		nameText_2:getVirtualRenderer():setDimensions(60, 35)
		nameText_1:setString(Strings:get(AlbumGroupType[i][2]))
		nameText_2:setString(Strings:get(AlbumGroupType[i][2]))

		self._tabCache[i] = self._tabCache[i] or {
			darkImg,
			lightImg
		}
	end

	self:refreshTabStatus()

	local width = self._tableViewPanel:getContentSize().width

	local function scrollViewDidScroll(view)
		if DisposableObject:isDisposed(self) then
			return
		end

		self._isReturn = false

		local offY = view:getContentOffset().y
		local maxOffset = view:minContainerOffset().y
		local percent = math.abs(offY / maxOffset)

		self._slider:setPercent((1 - percent) * 100)
	end

	local function cellSizeForTable(table, idx)
		return width, 197
	end

	local function numberOfCellsInTableView(table)
		return math.ceil(#self._showHeros / kNums)
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

function GalleryPartnerMediator:createTeamCell(cell, index)
	cell:removeAllChildren()

	local list = self._showHeros

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

				rarityBg:loadTexture(kRarityBg[hero:getRarity()])

				rarity = rarity:getChildByFullName("rarity")

				local rarityNum = hero:getRarity()

				rarity:loadTexture(GameStyle:getHeroRarityImage(rarityNum), 1)
				rarity:ignoreContentAdaptWithSize(true)
			end

			local heroPanel = panel:getChildByFullName("heroPanel")

			heroPanel:setScale(1)
			heroPanel:setSwallowTouches(false)
			heroPanel:addTouchEventListener(function(sender, eventType)
				self:onClickHeroIcon(sender, eventType, id)
			end)

			local heroIcon = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe7_1",
				id = roleModel
			})

			heroIcon:setScale(0.5)
			heroIcon:addTo(heroPanel)
			heroIcon:setAnchorPoint(cc.p(0.5, 0.5))
			heroIcon:setPosition(cc.p(heroPanel:getContentSize().width / 2 + 5, heroPanel:getContentSize().height / 2))

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
			local posX = panelWidth / 2 + (panelWidth - 23) * (i - 1)

			panel:setPosition(cc.p(posX, 95))

			panel.id = id
			cell.panelList = cell.panelList or {}
			cell.panelList[i] = panel
		end
	end
end

function GalleryPartnerMediator:refreshData(changeAlbumType)
	if changeAlbumType then
		self._albumArray = self._gallerySystem:getPartyArray()
		self._partyArray = self._albumArray[self._albumType]
	end

	self._curPartyData = self._partyArray[self._tabType]

	self:doLogicForShowHeros()

	self._attrData = self._gallerySystem:getLoveAddAttr()
end

function GalleryPartnerMediator:refreshView(hideReload, changeAlbumType)
	self:refreshTabStatus()
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

	if kImageParty[self._curPartyData:getPartyId()] then
		local img_party = ccui.ImageView:create("asset/ui/gallery/" .. kImageParty[self._curPartyData:getPartyId()][2], ccui.TextureResType.localType)

		img_party:setAnchorPoint(cc.p(0, 1))
		img_party:addTo(self._partyNode)
	end

	local label = self._loveCount:getChildByName("loveNum")
	local loveLevel = self._gallerySystem:getTotalLoveLevel()

	label:setString(loveLevel)
end

function GalleryPartnerMediator:refreshBottomView()
	self._buttonNode:removeAllChildren()

	self._bottomTabCache = {}

	local cellInterval = 90
	local cellWidth = 70
	local start_x = cellWidth / 2 - 10 + math.floor(#self._partyArray / 2) * -cellInterval + 20 + #self._partyArray % 2 * -55
	local cloneBaseNode = self._btnClone_1

	if self._albumType == 1 then
		cloneBaseNode = self._btnClone_2
		cellInterval = 85
		cellWidth = 40
		start_x = cellWidth / 2 - 22.5 + math.floor(#self._partyArray / 2) * -cellInterval + 45 + #self._partyArray % 2 * -65
	elseif self._albumType == 2 then
		cellInterval = 88
		cellWidth = 68
		start_x = -20 + cellWidth / 2 - 10 + math.floor(#self._partyArray / 2) * -cellInterval + 20 + #self._partyArray % 2 * -54
	end

	for i = 1, #self._partyArray do
		local data = self._partyArray[i]
		local btn = cloneBaseNode:clone()

		btn:setVisible(true)
		btn:addTo(self._buttonNode):posite(start_x + (i - 1) * cellInterval, 0)

		local touchPanel = btn:getChildByFullName("touchPanel")

		touchPanel:addClickEventListener(function()
			self:onClickBottomTab(i)
		end)

		local darkImg = btn:getChildByFullName("Image_dark")
		local lightImg = btn:getChildByFullName("Image_light")
		local name = btn:getChildByFullName("name")

		if name then
			if self._albumType == 2 then
				name:setString(Strings:get(GameStyle:getHeroOccupation(data:getPartyId())))
			elseif self._albumType == 3 then
				name:setString(data:getPartyId())
			end
		end

		if self._albumType == 1 then
			local Image_icon = btn:getChildByFullName("Image_3")

			Image_icon:loadTexture(kImageParty[data:getPartyId()][1], ccui.TextureResType.plistType)

			local redPoint = btn:getChildByFullName("redPoint")
			local canGain = self._gallerySystem:checkcanReceive(data:getPartyId())

			canGain = canGain or self._gallerySystem:checkCanGetHeroReward(data:getPartyId())

			redPoint:setVisible(canGain)
		end

		self._bottomTabCache[i] = self._bottomTabCache[i] or {
			lightImg,
			darkImg
		}
	end
end

function GalleryPartnerMediator:refreshBottomTabStatus()
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

function GalleryPartnerMediator:refreshTabStatus()
	for i = 1, #self._tabCache do
		self._tabCache[i][1]:setVisible(self._albumType ~= i)
		self._tabCache[i][2]:setVisible(self._albumType == i)
	end
end

function GalleryPartnerMediator:refreshRewardRedPoint()
	local canReceive, hasReward = self._gallerySystem:canRevieveReward(self._curPartyData:getPartyId())

	self._rewardBtn:getChildByFullName("redMark"):setVisible(canReceive)
	self._rewardBtn:setVisible(hasReward)

	for i = 1, #self._tabCache do
		local btn = self._tabCache[i][2]

		if not self._tabPanelLight:getChildByName("RedPoint_" .. i) then
			local redPoint = ccui.ImageView:create(IconFactory.redPointPath, 1)

			redPoint:setName("RedPoint_" .. i)
			redPoint:addTo(self._tabPanelLight):posite(btn:getPositionX() + 35, btn:getPositionY() + 60)
		end

		local partyArray = self._albumArray[i]

		for j = 1, #partyArray do
			local partyId = partyArray[j]:getPartyId()
			local canGain = self._gallerySystem:checkcanReceive(partyId)

			canGain = canGain or self._gallerySystem:checkCanGetHeroReward(partyId)

			if canGain then
				canReceive = true

				self._tabPanelLight:getChildByName("RedPoint_" .. i):setVisible(true)

				return
			end
		end

		self._tabPanelLight:getChildByName("RedPoint_" .. i):setVisible(canReceive)
	end
end

function GalleryPartnerMediator:onClickHeroIcon(sender, eventType, id)
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
				local view = self:getInjector():getInstance("GalleryPartnerInfoView")

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

function GalleryPartnerMediator:onClickReward()
	local view = self:getInjector():getInstance("GalleryPartnerRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rewardIds = self._curPartyData:getRewardIds(),
		partyType = self._curPartyData:getPartyId(),
		tabType = self._tabType
	}, nil))
end

function GalleryPartnerMediator:onClickTab(index)
	AudioEngine:getInstance():playEffect("Se_Click_Tab_Carera", false)

	self._tabSelect[self._albumType] = self._tabType
	self._albumType = index
	self._tabType = self._tabSelect[self._albumType] and self._tabSelect[self._albumType] or 1

	self:refreshData(true)
	self:refreshView(nil, true)
end

function GalleryPartnerMediator:onClickBottomTab(index)
	AudioEngine:getInstance():playEffect("Se_Click_Tab_Carera", false)

	self._tabType = index

	self:refreshData()
	self:refreshView()
end

function GalleryPartnerMediator:onClickBonus(sender, eventType, data)
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

function GalleryPartnerMediator:refreshInnerAttrPanel(data)
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
		text:getVirtualRenderer():setDimensions(260, 0)
		text:setString(list[i])

		if i == 1 then
			posY = posY - (text:getContentSize().height - 30) / 2
		end

		text:setPositionY(posY)

		posY = posY - text:getContentSize().height
		width = math.max(width, text:getContentSize().width)
		height = height + text:getContentSize().height
	end

	self._bonusPanel:getChildByName("imageBg"):setContentSize(cc.size(width + 40, height))

	return height
end

function GalleryPartnerMediator:onSliderChanged()
	local percent = self._slider:getPercent()
	local minOffset = self._heroView:minContainerOffset().y

	self._heroView:setContentOffset(cc.p(0, minOffset * (1 - percent * 0.01)), false)
end

function GalleryPartnerMediator:runStartAnim()
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
	self._tableViewPanel:setPosition(cc.p(630, self._posY_table + 30))

	local delay = cc.DelayTime:create(0.4)
	local moveto = cc.MoveTo:create(0.3, cc.p(630, self._posY_table))
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

function GalleryPartnerMediator:setupClickEnvs()
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

			storyDirector:setClickEnv("GalleryPartnerMediator.firstPanel", firstPanel, function(sender, eventType)
				self:onClickHeroIcon(sender, ccui.TouchEventType.began, firstPanelId)
				self:onClickHeroIcon(sender, ccui.TouchEventType.ended, firstPanelId)
			end)
		end
	end

	storyDirector:notifyWaiting("enter_GalleryPartnerMediator")
end

function GalleryPartnerMediator:onClickInfoBtn(sender, eventType)
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

function GalleryPartnerMediator:doLogicForShowHeros()
	self._showHeros = {}

	local specialHeroIds = self._gallerySystem:getAlbumFeminineHeroForRareityString(self._curPartyData:getPartyId())

	for i = 1, #specialHeroIds do
		self._showHeros[#self._showHeros + 1] = specialHeroIds[i]
	end

	local showHeroIds = self._curPartyData:getHeroIds()

	for i = 1, #showHeroIds do
		self._showHeros[#self._showHeros + 1] = showHeroIds[i]
	end
end
