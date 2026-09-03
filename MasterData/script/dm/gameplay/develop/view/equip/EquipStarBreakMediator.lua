-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/equip/EquipStarBreakMediator.lua

EquipStarBreakMediator = class("EquipStarBreakMediator", DmPopupViewMediator, _M)

EquipStarBreakMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kNum = 6
local kCellType = {
	kEquip = "equip",
	kTitle = "title",
	kItem = "item"
}
local kBtnHandlers = {}

function EquipStarBreakMediator:initialize()
	super.initialize(self)
end

function EquipStarBreakMediator:dispose()
	super.dispose(self)
end

function EquipStarBreakMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._equipSystem = self._developSystem:getEquipSystem()
	self._bagSystem = self._developSystem:getBagSystem()
	self._bgWidget = bindWidget(self, "main.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onOkClicked, self)
		},
		title = Strings:get("Equip_UI68"),
		title1 = Strings:get("Equip_UI84"),
		bgSize = {
			width = 837,
			height = 574
		}
	})
	self._sureWidget = self:bindWidget("main.okBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onClickSure, self)
		},
		btnSize = {
			width = 188,
			height = 96
		}
	})

	self.mapEventListener(self, self:getEventDispatcher(), EVT_EQUIP_LOCK_SUCC, self, self.refreshViewByLock)
end

function EquipStarBreakMediator:enterWithData(data)
	self:initData(data)
	self:initView()
	self:initTableView()
	self:refreshView()
end

function EquipStarBreakMediator:initData(data)
	self._callback = data.callback
	self._equipId = data.equipId
	self._needNum = data.needNum
	self._consumeTemp = {
		items = {},
		equips = {}
	}
	self._equipData = self._equipSystem:getEquipById(self._equipId)

	self:refreshData()
end

function EquipStarBreakMediator:refreshData()
	local checkParam = {
		equipBaseId = self._equipData:getEquipId(),
		exceptEquipId = self._equipData:getId(),
		position = self._equipData:getPosition()
	}

	self._equipList = self._equipSystem:getEquipList(EquipsShowType.kStarBreak, checkParam)

	local commonItemId = self._equipData:getCommonItemId()

	self._stiveItem = self._equipSystem:getStarBreakItems(commonItemId)
	self._cellsHeight = {}
	self._cellNum = 0

	local stiveNum = #self._stiveItem

	if stiveNum > 0 then
		self._cellNum = self._cellNum + 1
		self._cellsHeight[self._cellNum] = {
			type = kCellType.kTitle,
			str = Strings:get("Equip_UI87")
		}

		local num = math.ceil(stiveNum / kNum)

		for i = 1, num do
			self._cellNum = self._cellNum + 1
			self._cellsHeight[self._cellNum] = {
				type = kCellType.kItem,
				index = i
			}
		end
	end

	local equipNum = #self._equipList

	if equipNum > 0 then
		self._cellNum = self._cellNum + 1
		self._cellsHeight[self._cellNum] = {
			type = kCellType.kTitle,
			str = Strings:get("Equip_UI71")
		}

		local num = math.ceil(equipNum / kNum)

		for i = 1, num do
			self._cellNum = self._cellNum + 1
			self._cellsHeight[self._cellNum] = {
				type = kCellType.kEquip,
				index = i
			}
		end
	end
end

function EquipStarBreakMediator:initView()
	self._main = self:getView():getChildByFullName("main")
	self._emptyTip = self._main:getChildByFullName("emptyTip")

	self._emptyTip:setVisible(false)

	self._viewPanel = self._main:getChildByFullName("panel")
	self._cloneCell = self._main:getChildByFullName("cloneCell")

	self._cloneCell:setVisible(false)

	self._itemClone = self._main:getChildByFullName("itemClone")

	self._itemClone:setVisible(false)

	self._itemCellTop = self:getView():getChildByFullName("cell_top")

	self._itemCellTop:setVisible(false)

	self._itemCellLock = self:getView():getChildByFullName("cell_lock")

	self._itemCellLock:setVisible(false)
end

function EquipStarBreakMediator:initTableView()
	self._cellWidth = self._cloneCell:getContentSize().width
	self._cellHeight = self._cloneCell:getContentSize().height
	self._itemHeight = self._itemClone:getContentSize().height

	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		local param = self._cellsHeight[idx + 1]

		if param.type == kCellType.kTitle then
			return self._cellWidth, self._cellHeight
		end

		return self._cellWidth, self._itemHeight
	end

	local function numberOfCellsInTableView(table)
		return self._cellNum
	end

	local function tableCellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		cell:setTag(index)
		self:createTeamCell(cell, index)

		return cell
	end

	local tableView = cc.TableView:create(self._viewPanel:getContentSize())

	self._tableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	tableView:setBounceable(false)
	self._viewPanel:addChild(tableView)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:reloadData()
end

function EquipStarBreakMediator:createTeamCell(cell, index)
	cell:removeAllChildren()

	local param = self._cellsHeight[index]
	local height = self._itemHeight

	if param.type == kCellType.kTitle then
		height = self._cellHeight

		local node = self._cloneCell:clone()

		node:setVisible(true)
		node:addTo(cell):posite(0, 0)
		node:getChildByFullName("titleNode.text"):setString(param.str)
		node:getChildByFullName("line"):setVisible(index ~= 1)
	elseif param.type == kCellType.kItem then
		local indexTemp = param.index

		for j = 1, kNum do
			local itemData = self._stiveItem[kNum * (indexTemp - 1) + j]

			if itemData then
				local node = self._itemClone:clone()

				node:setVisible(true)
				node:addTo(cell):posite(57 + (j - 1) * 115, 0)

				local itemPanel = node:getChildByFullName("itemNode")
				local item = IconFactory:createItemIcon({
					id = itemData.itemId,
					amount = itemData.allCount
				})

				item:addTo(itemPanel):center(itemPanel:getContentSize())
				item:setScale(0.83)
				itemPanel:setSwallowTouches(false)
				itemPanel:addTouchEventListener(function(sender, eventType)
					self:onEatItemClicked(sender, eventType, itemData)
				end)

				itemPanel.data = itemData

				if self._consumeTemp.items[itemData.itemId] then
					local image = ccui.ImageView:create("asset/common/pt_hc_gou2.png")

					image:addTo(itemPanel):center(itemPanel:getContentSize())
				end
			end
		end
	elseif param.type == kCellType.kEquip then
		local indexTemp = param.index

		for j = 1, kNum do
			local itemData = self._equipList[kNum * (indexTemp - 1) + j]

			if itemData then
				local node = self._itemClone:clone()

				node:setVisible(true)
				node:addTo(cell):posite(57 + (j - 1) * 115, 0)

				local rarity = itemData:getRarity()
				local level = itemData:getLevel()
				local star = itemData:getStar()
				local unlock = itemData:getUnlock()
				local heroId = itemData:getHeroId()
				local equipParam = {
					id = itemData:getEquipId(),
					level = level,
					star = star,
					rarity = rarity
				}
				local itemPanel = node:getChildByFullName("itemNode")
				local item = IconFactory:createEquipIcon(equipParam)

				item:addTo(itemPanel):center(itemPanel:getContentSize())
				item:setScale(0.83)

				local canTouch = unlock and heroId == ""
				local color = cc.c3b(255, 255, 255)

				if heroId ~= "" then
					color = cc.c3b(180, 180, 180)
				else
					local node_lock = self._itemCellLock:clone()

					node_lock:setVisible(true)
					node_lock:addTo(node):center(node:getContentSize())

					local Panel_unlock = node_lock:getChildByFullName("Panel_unlock")
					local Panel_lock = node_lock:getChildByFullName("Panel_lock")

					Panel_unlock:addTouchEventListener(function(sender, eventType)
						self:onUnlockOrLockEquip(sender, eventType, itemData)
					end)
					Panel_lock:addTouchEventListener(function(sender, eventType)
						self:onUnlockOrLockEquip(sender, eventType, itemData)
					end)

					if unlock then
						Panel_unlock:setVisible(true)
						Panel_lock:setVisible(false)
					else
						Panel_unlock:setVisible(false)
						Panel_lock:setVisible(true)

						color = cc.c3b(127, 127, 127)
					end
				end

				item:setColor(color)

				if heroId ~= "" then
					local itemCellTop = self._itemCellTop:clone()

					itemCellTop:setVisible(true)
					itemCellTop:setName("itemCellTop")
					itemCellTop:addTo(itemPanel):center(itemPanel:getContentSize())

					local heroNode = itemCellTop:getChildByFullName("heroIcon")
					local heroInfo = {
						id = IconFactory:getRoleModelByKey("HeroBase", heroId)
					}
					local headImgName = IconFactory:createRoleIconSpriteNew(heroInfo)

					headImgName:setScale(0.2)

					headImgName = IconFactory:addStencilForIcon(headImgName, 2, cc.size(31, 31))

					headImgName:addTo(heroNode):center(heroNode:getContentSize())
				end

				itemPanel:setTouchEnabled(canTouch)
				itemPanel:setSwallowTouches(false)
				itemPanel:addTouchEventListener(function(sender, eventType)
					self:onEatItemClicked(sender, eventType, itemData)
				end)

				itemPanel.data = itemData

				if self._consumeTemp.equips[itemData.expData.id] then
					local image = ccui.ImageView:create("asset/common/pt_hc_gou2.png")

					image:addTo(itemPanel):center(itemPanel:getContentSize())
				end
			end
		end
	end
end

function EquipStarBreakMediator:getCellNum()
	local num = 0
	local index = 0

	if self._stiveItem then
		num = num + 1
		index = index + 1
		self._cellsHeight[index] = self._cellHeight
	end

	for i = 1, #self._rarityItems do
		local itemNum = #self._rarityItems[i].items

		if itemNum > 0 then
			num = num + 1
			index = index + 1
			self._cellsHeight[index] = self._cellHeight + self._itemPanelHeight * (math.ceil(itemNum / kNum) - 1)
		end
	end

	return num
end

function EquipStarBreakMediator:hasSelectItems()
	return table.nums(self._consumeTemp.items) ~= 0 or table.nums(self._consumeTemp.equips) ~= 0
end

function EquipStarBreakMediator:refreshView()
	self._emptyTip:setVisible(#self._stiveItem == 0 and #self._equipList == 0)
	self._sureWidget:getView():setGray(self._emptyTip:isVisible() or not self:hasSelectItems())
end

function EquipStarBreakMediator:onClickSure()
	if not self:hasSelectItems() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI72")
		}))

		return
	end

	local function callback()
		self._equipSystem:setEquipStarUpItem(self._needNum, self._consumeTemp)

		if self._callback then
			self._callback()
		end

		self:close()
	end

	callback()
end

function EquipStarBreakMediator:onOkClicked()
	self._equipSystem:resetEquipStarUpItem()

	if self._callback then
		self._callback()
	end

	self:close()
end

function EquipStarBreakMediator:onEatItemClicked(sender, eventType, itemData)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		if itemData.expData and self._consumeTemp.equips[itemData.expData.id] then
			return
		elseif not itemData.expData and self._consumeTemp.items[itemData.itemId] then
			return
		end

		self._consumeTemp.items = {}
		self._consumeTemp.equips = {}

		if itemData.expData then
			self._consumeTemp.equips[itemData.expData.id] = {
				eatCount = self._needNum,
				baseId = itemData:getEquipId()
			}
		else
			self._consumeTemp.items[itemData.itemId] = {
				eatCount = self._needNum
			}
		end

		local offsetY = self._tableView:getContentOffset().y

		self._tableView:reloadData()
		self._tableView:setContentOffset(cc.p(0, offsetY))
		self:refreshView()
	end
end

function EquipStarBreakMediator:onUnlockOrLockEquip(sender, eventType, itemData)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		local params = {
			viewtype = 2,
			equipId = itemData:getId()
		}

		self._doTip_Unlock = itemData:getUnlock()
		self._itemData_change = itemData

		self._equipSystem:requestEquipLock(params)
	end
end

function EquipStarBreakMediator:refreshViewByLock()
	if self._itemData_change and self._itemData_change.expData and self._doTip_Unlock then
		self._consumeTemp.equips[self._itemData_change.expData.id] = nil
	end

	if self._doTip_Unlock then
		local var_26_0 = Strings:get("Equip_Lock_Tips_2")

		if not var_26_0 then
			var_26_0 = Strings:get("Equip_Lock_Tips_1")

			local tip = var_26_0

			self:dispatch(ShowTipEvent({
				tip = tip
			}))
			self:refreshData()

			local offsetY = self._tableView:getContentOffset().y

			self._tableView:reloadData()
			self._tableView:setContentOffset(cc.p(0, offsetY))
			self:refreshView()
		end
	end
end
