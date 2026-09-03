-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopURExchangeMediator.lua

ShopURExchangeMediator = class("ShopURExchangeMediator", DmPopupViewMediator, _M)

local URmap_Shop_TransItem = ConfigReader:getDataByNameIdAndKey("ConfigValue", "URmap_Shop_TransItem", "content")
local kBtnHandlers = {}

function ShopURExchangeMediator:initialize()
	super.initialize(self)
end

function ShopURExchangeMediator:dispose()
	super.dispose(self)
end

function ShopURExchangeMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local developSystem = self:getInjector():getInstance("DevelopSystem")

	self._bagSystem = developSystem:getBagSystem()
	self._main = self:getView():getChildByName("main")
	self._cancelBtn = self:bindWidget("main.btn_cancel", OneLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Cancle",
			func = bind1(self.onSelectAllClicked, self)
		}
	})
	self._sureBtn = self:bindWidget("main.btn_ok", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onOKClicked, self)
		}
	})

	local bgNode = self._main:getChildByFullName("bg")
	local tempNode = bindWidget(self, bgNode, PopupNormalWidget, {
		title1 = "",
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("Shop_URMap_Transform_Title"),
		bgSize = {
			width = 840,
			height = 580
		}
	})
	local itemIcon = self._main:getChildByFullName("Image_1")
	local icon = IconFactory:createItemPic({
		scaleRatio = 0.45,
		id = URmap_Shop_TransItem.itemID
	})

	icon:addTo(itemIcon):posite(20, 26)
end

function ShopURExchangeMediator:userInject()
	return
end

function ShopURExchangeMediator:enterWithData(data)
	self._data = data

	self:setUpView()
end

local size_W = 650
local size_H = 126

function ShopURExchangeMediator:setUpView()
	local itemList = self._main:getChildByFullName("Panel_7")

	itemList:removeAllChildren()

	self._itemClone = self._main:getChildByFullName("cellClone")

	self._itemClone:setVisible(false)

	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		return size_W, size_H
	end

	local function numberOfCellsInTableView(table)
		return math.ceil(#self._data / 5)
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		cell:setTag(idx)
		self:createCell(cell, idx + 1)

		return cell
	end

	local tableView = cc.TableView:create(itemList:getContentSize())

	self._tableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(cc.p(0, 0))
	tableView:setPosition(0, 0)
	tableView:setDelegate()
	itemList:addChild(tableView)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setTouchEnabled(true)
	tableView:reloadData()
	self:refreshBottom()
end

function ShopURExchangeMediator:createCell(cell, idx)
	cell:removeAllChildren()

	local layerPanel = ccui.Layout:create()

	layerPanel:setContentSize(cc.size(size_W, size_H))
	layerPanel:removeAllChildren()
	layerPanel:addTo(cell)

	for i = 1, 5 do
		local index = i + (idx - 1) * 5

		if self._data[index] then
			local data = self._data[index]
			local layer = self._itemClone:clone()

			layer:setVisible(true)
			layer:setPosition(cc.p(20 + (i - 1) * 130, 10))
			layer:addTo(layerPanel)
			layer:setTouchEnabled(true)
			layer:setSwallowTouches(false)

			local icon = IconFactory:createIcon({
				id = data.itemId,
				amount = data.allCount
			}, {
				showAmount = true
			})

			icon:addTo(layer, -1):posite(layer:getContentSize().width / 2, layer:getContentSize().height / 2)
			icon:setScale(0.85)

			local select = layer:getChildByFullName("Image_select")

			select:setVisible(data.isEatAll)

			layer.data = data
			layer.index = index

			layer:addTouchEventListener(function(sender, eventType)
				self:onEatItemClicked(sender, eventType)
			end)
		end
	end
end

function ShopURExchangeMediator:onEatItemClicked(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

		local index = sender.index

		if self._data[index] then
			self._data[index].isEatAll = not self._data[index].isEatAll

			local select = sender:getChildByFullName("Image_select")

			select:setVisible(self._data[index].isEatAll)
		end

		self:refreshBottom()
	end
end

function ShopURExchangeMediator:refreshBottom()
	local desNum = self._main:getChildByFullName("Text_descNum")
	local transRate = URmap_Shop_TransItem.transNum
	local total = 0

	self._isAllSelect = true

	for i, v in ipairs(self._data) do
		if v.isEatAll then
			total = total + v.allCount
		else
			self._isAllSelect = false
		end
	end

	desNum:setString(total * transRate)
	self._cancelBtn:setButtonName((self._isAllSelect or nil) and (Strings:get("Shop_URMap_Button_Desc4") or Strings:get("Shop_URMap_Button_Desc1")))
end

function ShopURExchangeMediator:onSelectAllClicked(sender, eventType)
	if self._isAllSelect then
		for i, v in ipairs(self._data) do
			v.isEatAll = false
		end
	else
		for i, v in ipairs(self._data) do
			v.isEatAll = true
		end
	end

	local offY = self._tableView:getContentOffset().y

	self._tableView:reloadData()
	self._tableView:setContentOffset(cc.p(0, offY))
	self:refreshBottom()
end

function ShopURExchangeMediator:onOKClicked(sender, eventType)
	local sendParam = {}

	for i, v in ipairs(self._data) do
		if v.isEatAll then
			sendParam[v.itemId] = v.allCount
		end
	end

	if next(sendParam) then
		self._bagSystem:transferURScroll(sendParam, function()
			if checkDependInstance(self) then
				self._data = self._bagSystem:getRepeatURItems()

				self._tableView:reloadData()
				self:refreshBottom()
			end
		end)
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Shop_URMap_Button_Desc5")
		}))
	end
end

function ShopURExchangeMediator:onCloseClicked(sender, eventType)
	self:close()
end
