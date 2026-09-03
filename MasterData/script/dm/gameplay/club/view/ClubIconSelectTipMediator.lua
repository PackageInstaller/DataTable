-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubIconSelectTipMediator.lua

ClubIconSelectTipMediator = class("ClubIconSelectTipMediator", DmPopupViewMediator, _M)

ClubIconSelectTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubIconSelectTipMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {
	["main.btn_ok.button"] = {
		clickAudio = "Se_Click_Confirm",
		func = "onOkClicked"
	}
}
local clubIconList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Icon", "content")

function ClubIconSelectTipMediator:initialize()
	super.initialize(self)
end

function ClubIconSelectTipMediator:dispose()
	super.dispose(self)
end

function ClubIconSelectTipMediator:userInject()
	return
end

function ClubIconSelectTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.btn_ok", OneLevelViceButton, {})
end

function ClubIconSelectTipMediator:createBgWidget()
	local injector = self:getInjector()
	local bgNode = self:getView():getChildByFullName("main.bg")
	local widget = self:bindWidget(bgNode, PopupNormalWidget, {
		bg = "paihangbang_bg_di_4.png",
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("Club_Text16"),
		title1 = Strings:get("UITitle_EN_Xiugaijieshetubiao"),
		bgSize = {
			width = 837.8,
			height = 509
		}
	})
end

function ClubIconSelectTipMediator:enterWithData()
	self._curIndex = -1
	self._curCell = nil
	self._main = self:getView():getChildByName("main")
	self._cellPanel = self._main:getChildByName("cellpanel")

	self._cellPanel:setVisible(false)
	self:createBgWidget()
	self:createTableView()
	self:initState()
end

function ClubIconSelectTipMediator:initState()
	local clubIconIndex = self:getClubSystem():getClubInfoOj():getIcon()

	for k, v in pairs(clubIconList) do
		if v.id == clubIconIndex then
			self._curIndex = k
		end
	end

	if self._curIndex ~= -1 then
		local lineIndex = math.modf((self._curIndex - 1) / 4)
		local cell = self._tableView:cellAtIndex(lineIndex):getChildByTag(self._curIndex - 4 * lineIndex)
		local backImg = ccui.Scale9Sprite:createWithSpriteFrameName("legend_img_select.png")

		backImg:addTo(cell):center(cell:getContentSize()):setTag(1517)
		backImg:setContentSize(cc.rect(0, 0, cell:getContentSize().width, cell:getContentSize().height + 2))

		self._curCell = cell
	end
end

function ClubIconSelectTipMediator:createTableView()
	local viewSize = self._cellPanel:getContentSize()
	local kColumnNum = 4
	local kIntervalX = 5
	local kCellWidth = viewSize.width * kColumnNum + kIntervalX * (kColumnNum + 1)
	local kCellHeight = viewSize.height + kIntervalX * 2
	local tableView = cc.TableView:create(cc.size(506, 255))

	local function numberOfCells(view)
		return math.ceil(#clubIconList / kColumnNum)
	end

	local function cellTouched(table, cell)
		if self._curEntryCell ~= nil then
			-- block empty
		end
	end

	local function cellSize(table, idx)
		return kCellWidth, kCellHeight
	end

	local function cellAtIndex(table, idx)
		local bar = table:dequeueCell()

		if bar == nil then
			bar = cc.TableViewCell:new()

			bar:setContentSize(cc.size(kCellWidth, kCellHeight))

			for i = 1, kColumnNum do
				local iconCell = self._cellPanel:clone()

				iconCell:setTouchEnabled(true)
				iconCell:setSwallowTouches(false)

				local posX = (i - 1) * kIntervalX + (i - 1) * viewSize.width

				iconCell:setAnchorPoint(0, 0)
				iconCell:setPosition(cc.p(posX + 15, kIntervalX))
				bar:addChild(iconCell, 0, i)
			end
		end

		for i = 1, kColumnNum do
			local curIndex = idx * kColumnNum + i
			local iconCell = bar:getChildByTag(i)

			iconCell:addTouchEventListener(function(sender, eventType)
				self:onIconSelectClicked(sender, eventType, curIndex)
			end)
			iconCell:setVisible(clubIconList[curIndex] ~= nil)

			if iconCell:isVisible() then
				self:updateCell(iconCell, curIndex)
			end
		end

		return bar
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setPosition(cc.p(290, 230))
	tableView:setDelegate()
	tableView:setLocalZOrder(100)
	self._main:addChild(tableView)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)

	self._tableView = tableView

	tableView:reloadData()
end

function ClubIconSelectTipMediator:updateCell(iconCell, index)
	if clubIconList[index] then
		local iconId = clubIconList[index].id

		iconCell:removeAllChildren()

		local icon = IconFactory:createClubIcon({
			id = iconId
		})

		icon:setAnchorPoint(0, 0)
		icon:addTo(iconCell):center(iconCell:getContentSize())
	end
end

function ClubIconSelectTipMediator:onClickCreate(sender, eventType)
	return
end

function ClubIconSelectTipMediator:onCloseClicked(sender, eventType)
	self:close()
end

function ClubIconSelectTipMediator:onIconSelectClicked(sender, eventType, index)
	if eventType == ccui.TouchEventType.began then
		self._offsetY = self._tableView:getContentOffset().y
	elseif eventType == ccui.TouchEventType.ended then
		local offsetY = self._tableView:getContentOffset().y

		if math.abs(offsetY - self._offsetY) < 2 then
			if self._curIndex == index then
				return
			end

			local backImg = ccui.Scale9Sprite:createWithSpriteFrameName("legend_img_select.png")

			backImg:addTo(sender):center(sender:getContentSize()):setTag(1517)
			backImg:setContentSize(cc.rect(0, 0, sender:getContentSize().width, sender:getContentSize().height + 2))

			self._curIndex = index

			if self._curCell then
				self._curCell:removeChildByTag(1517)
			end

			self._curCell = sender

			AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)
		end
	end
end

function ClubIconSelectTipMediator:onOkClicked(sender, eventType)
	if self._curIndex == -1 then
		self:close()
	else
		self:close({
			index = self._curIndex
		})
	end
end
