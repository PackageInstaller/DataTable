-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryLegendMediator.lua

GalleryLegendMediator = class("GalleryLegendMediator", DmAreaViewMediator, _M)

GalleryLegendMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryLegendMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")

local kBtnHandlers = {
	descBtn = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onClickShowTips"
	},
	PanelTouch_tip = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickHideTips"
	}
}

function GalleryLegendMediator:initialize()
	super.initialize(self)
end

function GalleryLegendMediator:dispose()
	super.dispose(self)
end

function GalleryLegendMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshBySync)
end

function GalleryLegendMediator:enterWithData(data)
	self:setupTopInfoWidget()
	self:setupView(data)
	self:runStartAnim()
end

function GalleryLegendMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		title = Strings:get("Gallery_Legend_UI1"),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function GalleryLegendMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function GalleryLegendMediator:setupView()
	self:initData()
	self:initWidgetInfo()
	self:initView()
end

function GalleryLegendMediator:refreshBySync()
	self:refreshData()
	self:refreshView()
end

function GalleryLegendMediator:initWidgetInfo()
	self._touchLayer = self:getView():getChildByFullName("touchLayer")

	self._touchLayer:setVisible(false)

	self._main = self:getView():getChildByFullName("main")
	self._tableViewPanel = self._main:getChildByFullName("tableView")
	self._cellClone = self._main:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)
end

function GalleryLegendMediator:initData()
	self._showList = self._gallerySystem:getLegendList()
end

function GalleryLegendMediator:initView()
	local width, height = self._cellClone:getContentSize().width, self._tableViewPanel:getContentSize().width

	local function scrollViewDidScroll(view)
		if DisposableObject:isDisposed(self) then
			return
		end

		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		return width + 12, height
	end

	local function numberOfCellsInTableView(table)
		return #self._showList
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local panel = self._cellClone:clone()

			panel:setVisible(true)
			panel:addTo(cell):setName("CellClone")
			panel:posite((width + 12) / 2, 0)
		end

		self:createTeamCell(cell, idx + 1)

		return cell
	end

	local tableView = cc.TableView:create(self._tableViewPanel:getContentSize())

	self._heroView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	self._tableViewPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)

	self._tipsPanel = self._main:getChildByName("tipsPanel")

	self._tipsPanel:setVisible(false)

	self._tipsTouchPanel = self:getView():getChildByName("PanelTouch_tip")

	self._tipsTouchPanel:setVisible(false)

	local tips = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HerosLegendRule", "content")
	local space = 18

	if getCurrentLanguage() ~= GameLanguageType.CN then
		space = 13

		self._tipsPanel:setContentSize(cc.size(400, 230))
	end

	local panelSize = self._tipsPanel:getContentSize()

	for i = 1, #tips do
		local str = Strings:get(tips[i])
		local text = ccui.Text:create(str, TTF_FONT_FZYH_M, 18)

		text:setLineSpacing(space)
		text:getVirtualRenderer():setMaxLineWidth(380)
		text:addTo(self._tipsPanel):setTag(i)
		text:setAnchorPoint(cc.p(0, 1))

		local prewText = self._tipsPanel:getChildByTag(i - 1)

		if prewText then
			local topPosY = prewText:getPositionY() - prewText:getContentSize().height

			text:setPosition(cc.p(10, topPosY - space))
		else
			text:setPosition(cc.p(10, panelSize.height - 15))
		end
	end
end

function GalleryLegendMediator:createTeamCell(cell, index)
	local data = self._showList[index]
	local panel = cell:getChildByFullName("CellClone")
	local posY = index % 2 == 0 and 193 or 300

	panel:setPositionY(posY)

	local bg = panel:getChildByFullName("bg")

	bg:loadTexture(data:getOutsideBG())

	local text = panel:getChildByFullName("text")

	text:setString(data:getName())

	local heroPanel = panel:getChildByFullName("heroPanel")

	heroPanel:removeAllChildren()
	heroPanel:setSwallowTouches(false)
	heroPanel:addTouchEventListener(function(sender, eventType)
		self:onClickHeroIcon(sender, eventType, data)
	end)

	local hasHero = false

	for heroId, v in pairs(data:getHeroes()) do
		local value = v.outside
		local hero = self._heroSystem:getHeroById(heroId)
		local model = IconFactory:getRoleModelByKey("HeroBase", heroId)
		local has = false

		if hero then
			hasHero = true
			has = true
		end

		local portrait, _, spineani = IconFactory:createRoleIconSpriteNew({
			iconType = "Portrait",
			id = model
		})

		portrait:addTo(heroPanel)

		if not has then
			bg:setGray(true)
			portrait:setBrightness(-80)
			portrait:setSaturation(-80)
		end

		portrait:setPosition(cc.p(value.x, value.y))
		portrait:setScale(value.scale)
		portrait:setLocalZOrder(value.zOrder)
	end

	bg:setGray(not hasHero)
end

function GalleryLegendMediator:refreshData()
	self._showList = self._gallerySystem:getLegendList()
end

function GalleryLegendMediator:refreshView(hideReload)
	self._heroView:stopScroll()
	self._heroView:reloadData()
end

function GalleryLegendMediator:refreshTabStatus()
	for i = 1, #self._tabCache do
		self._tabCache[i][1]:setVisible(self._tabType ~= i)
		self._tabCache[i][2]:setVisible(self._tabType == i)
	end
end

function GalleryLegendMediator:refreshRewardRedPoint()
	local canReceive = self._gallerySystem:canRevieveReward(self._curPartyData:getPartyId())

	self._rewardBtn:getChildByFullName("redMark"):setVisible(canReceive)

	for i = 1, #self._tabCache do
		local btn = self._tabCache[i][2]
		local partyId = self._partyArray[i]:getPartyId()

		if not self._tabPanelLight:getChildByName("RedPoint_" .. i) then
			local redPoint = ccui.ImageView:create(IconFactory.redPointPath, 1)

			redPoint:setName("RedPoint_" .. i)
			redPoint:addTo(self._tabPanelLight):posite(btn:getPositionX() + 40, btn:getPositionY() + 40)
		end

		canReceive = self._gallerySystem:checkcanReceive(partyId) or self._gallerySystem:checkCanGetHeroReward(partyId)

		self._tabPanelLight:getChildByName("RedPoint_" .. i):setVisible(canReceive)
	end
end

function GalleryLegendMediator:onClickHeroIcon(sender, eventType, data)
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
				local view = self:getInjector():getInstance("GalleryLegendInfoView")

				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
					id = data:getId(),
					ids = self._showList
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

function GalleryLegendMediator:onClickShowTips(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._tipsPanel:setVisible(true)
		self._tipsTouchPanel:setVisible(true)
	end
end

function GalleryLegendMediator:onClickHideTips(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._tipsPanel:setVisible(false)
		self._tipsTouchPanel:setVisible(false)
	end
end

function GalleryLegendMediator:runStartAnim()
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
	self._tableViewPanel:setPosition(cc.p(140, 80))

	local delay = cc.DelayTime:create(0.2)
	local moveto = cc.MoveTo:create(0.3, cc.p(140, 49))
	local fadeIn = cc.FadeIn:create(0.2)
	local callback = cc.CallFunc:create(function()
		self._heroView:reloadData()
	end)

	spawn = cc.Spawn:create(moveto, fadeIn, callback)

	local endCallFunc = cc.CallFunc:create(function()
		return
	end)

	seq = cc.Sequence:create(delay, spawn, endCallFunc)

	self._tableViewPanel:runAction(seq)
end
