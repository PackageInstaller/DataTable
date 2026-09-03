-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/equip/EquipStarLevelMediator.lua

EquipStarLevelMediator = class("EquipStarLevelMediator", DmPopupViewMediator, _M)

EquipStarLevelMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kNum = 6
local kCellType = {
	kEquip = "equip",
	kTitle = "title",
	kItem = "item"
}
local kBtnHandlers = {
	["main.infoNode.button"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickRule"
	},
	["main.selectBtn"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickSelect"
	}
}

function EquipStarLevelMediator:initialize()
	super.initialize(self)
end

function EquipStarLevelMediator:dispose()
	self:closeAllScheduler()
	super.dispose(self)
end

function EquipStarLevelMediator:onRegister()
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
	self._quickWidget = self:bindWidget("main.quickBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onClickQuick, self)
		},
		btnSize = {
			width = 188,
			height = 96
		}
	})

	self.mapEventListener(self, self:getEventDispatcher(), EVT_EQUIP_LOCK_SUCC, self, self.refreshViewByLock)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ITEM_LOCK_SUCC, self, self.refreshViewByItemLock)
end

function EquipStarLevelMediator:enterWithData(data)
	self:initData(data)
	self:initView()
	self:initTableView()
	self:refreshView()
end

function EquipStarLevelMediator:initData(data)
	self._callback = data.callback
	self._equipId = data.equipId
	self._needNum = data.needNum
	self._itemId = data.itemId
	self._useCompose = data.useCompose
	self._equipData = self._equipSystem:getEquipById(self._equipId)

	if self._useCompose then
		self:refreshComposeData()
	else
		self:refreshData()
	end

	self._consumeTemp = {
		items = {},
		equips = {}
	}
	self._curExp = self._equipData:getOverflowStarExp()

	if self._useCompose then
		self._curExp = 0
	end

	self._finalExp = self._curExp
	self._eatExp = 0
	self._addExp = 0
	self._isAdd = true
	self._seeTime = 10
	self._itemMap = {}
end

function EquipStarLevelMediator:refreshData()
	local checkParam = {
		equipBaseId = self._equipData:getEquipId(),
		exceptEquipId = self._equipData:getId(),
		position = self._equipData:getPosition()
	}

	self._equipList = self._equipSystem:getEquipList(EquipsShowType.kStar, checkParam)
	self._stiveItem = self._equipSystem:getStarItems()
	self._cellsHeight = {}
	self._cellNum = 0

	local stiveNum = #self._stiveItem

	if stiveNum > 0 then
		self._cellNum = self._cellNum + 1
		self._cellsHeight[self._cellNum] = {
			type = kCellType.kTitle,
			str = Strings:get("Equip_UI68")
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
			str = Strings:get("Equip_UI70")
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

function EquipStarLevelMediator:refreshComposeData()
	self._stiveItem = {}
	self._cellsHeight = {}
	self._cellNum = 0

	local haveCount = self._bagSystem:getItemCount(self._itemId)

	if haveCount == 0 then
		self._cellNum = self._cellNum + 1
		self._cellsHeight[self._cellNum] = {
			type = kCellType.kTitle,
			str = Strings:get("Equip_Ur_Mix_1")
		}
		self._cellNum = self._cellNum + 1

		local param = {
			index = 1,
			type = kCellType.kItem
		}
		local entry = self._bagSystem:getEntryById(self._itemId)

		self._stiveItem = {
			{
				exp = 1,
				allCount = 0,
				eatCount = 0,
				itemId = self._itemId
			}
		}
		self._cellsHeight[self._cellNum] = param
	end

	if haveCount > 0 then
		self._cellNum = self._cellNum + 1
		self._cellsHeight[self._cellNum] = {
			type = kCellType.kTitle,
			str = Strings:get("Equip_Ur_Mix_1")
		}
		self._cellNum = self._cellNum + 1

		local param = {
			index = 1,
			type = kCellType.kItem
		}
		local entry = self._bagSystem:getEntryById(self._itemId)

		self._stiveItem = {
			{
				eatCount = 0,
				exp = 1,
				itemId = self._itemId,
				allCount = entry.count,
				quality = entry.item:getQuality(),
				sort = entry.item:getSort()
			}
		}
		self._cellsHeight[self._cellNum] = param
	end

	local repleaseItems = self._bagSystem:getAllComposeEntrys(self._itemId)

	self._repleaseItems = repleaseItems

	local repleaseNum = #repleaseItems

	self._composeItems = {}

	if repleaseNum > 0 then
		self._cellNum = self._cellNum + 1
		self._cellsHeight[self._cellNum] = {
			type = kCellType.kTitle,
			str = Strings:get("Equip_Ur_Mix_2")
		}

		for i = 1, repleaseNum do
			local entry = self._bagSystem:getEntryById(repleaseItems[i])

			if entry and entry.item and entry.count > 0 then
				local tmpCount = entry.count
				local composeTimes = self._bagSystem:getComposeTimes()
				local currentTime = composeTimes[repleaseItems[i]]

				if (currentTime and currentTime >= 1 or nil) and false then
					tmpCount = tmpCount - 1
				end

				local item = {
					eatCount = 0,
					exp = 1,
					itemId = repleaseItems[i],
					allCount = tmpCount,
					quality = entry.item:getQuality(),
					sort = entry.item:getSort(),
					unlock = entry.unlock and 1 or 0
				}

				table.insert(self._composeItems, item)
				table.sort(self._composeItems, function(a, b)
					if a.unlock == b.unlock then
						return a.sort < b.sort
					end

					return a.unlock > b.unlock
				end)
			end
		end

		local num = math.ceil(repleaseNum / kNum)

		for i = 1, num do
			self._cellNum = self._cellNum + 1
			self._cellsHeight[self._cellNum] = {
				forCompose = true,
				type = kCellType.kItem,
				index = i
			}
		end
	end
end

function EquipStarLevelMediator:initView()
	self._main = self:getView():getChildByFullName("main")
	self._ruleNode = self._main:getChildByFullName("ruleNode")

	self._ruleNode:setVisible(false)
	self._ruleNode:setSwallowTouches(false)
	self._ruleNode:addClickEventListener(function()
		self._ruleNode:setVisible(false)
	end)

	self._infoNode = self._main:getChildByFullName("infoNode")
	self._emptyTip = self._main:getChildByFullName("emptyTip")

	self._emptyTip:setVisible(false)

	self._progressLabel = self._infoNode:getChildByFullName("progressLabel")
	self._loadingBar = self._infoNode:getChildByFullName("loadingBar")

	self._loadingBar:setScale9Enabled(true)
	self._loadingBar:setCapInsets(cc.rect(8, 8, 2, 3))

	self._viewPanel = self._main:getChildByFullName("panel")
	self._cloneCell = self._main:getChildByFullName("cloneCell")

	self._cloneCell:setVisible(false)

	self._itemClone = self._main:getChildByFullName("itemClone")

	self._itemClone:setVisible(false)

	self._itemCellTop = self:getView():getChildByFullName("cell_top")

	self._itemCellTop:setVisible(false)

	self._itemCellLock = self:getView():getChildByFullName("cell_lock")

	self._itemCellLock:setVisible(false)

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(127, 127, 127, 255)
		}
	}

	self._progressLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))

	local text = self._ruleNode:getChildByFullName("text")

	text:setString(Strings:get("Equip_UI73"))

	if self._useCompose then
		local pos = self._bagSystem:getComposePos(self._itemId)
		local iconNode = self._infoNode:getChildByFullName("Node")

		iconNode:removeAllChildren()

		local debrisIcon = ccui.ImageView:create(composePosImage_icon[pos][2], 1)

		debrisIcon:addTo(iconNode)
		self._infoNode:getChildByFullName("text1"):setVisible(false)
		text:setString(Strings:get("Equip_Ur_Mix_3"))
	end

	local backimg = self._ruleNode:getChildByFullName("backimg")

	backimg:setContentSize(cc.size(text:getContentSize().width + 45, text:getContentSize().height + 50))
end

function EquipStarLevelMediator:initTableView()
	self._cellWidth = self._cloneCell:getContentSize().width
	self._cellHeight = self._cloneCell:getContentSize().height
	self._itemHeight = self._itemClone:getContentSize().height

	local function scrollViewDidScroll(view)
		self:closeSleepScheduler()
		self:closeLongAddScheduler()
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

function EquipStarLevelMediator:createTeamCell(cell, index)
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
			local itemData = ((param.forCompose or nil) and self._composeItems)[kNum * (indexTemp - 1) + j]

			if itemData then
				local node = self._itemClone:clone()

				node:setVisible(true)
				node:addTo(cell):posite(57 + (j - 1) * 115, 0)

				local itemPanel = node:getChildByFullName("itemNode")
				local info = {
					id = itemData.itemId,
					amount = itemData.allCount
				}

				if itemData.allCount == 0 then
					info.useNoEnough = false
				end

				local item = IconFactory:createItemIcon(info)

				item:addTo(itemPanel):center(itemPanel:getContentSize())
				item:setScale(0.83)

				local numPanel = node:getChildByFullName("numPanel")
				local curNum = itemData.eatCount
				local expLabel = numPanel:getChildByFullName("exp")

				expLabel:setColor(cc.c3b(255, 255, 255))

				local numLabel = numPanel:getChildByFullName("num")

				expLabel:setString("+" .. itemData.exp)

				local numStr = curNum == 0 and "" or string.format("(%d)", curNum)

				numLabel:setString(numStr)
				expLabel:setPositionX(0)
				numLabel:setPositionX(expLabel:getContentSize().width)
				numPanel:setContentSize(cc.size(expLabel:getContentSize().width + numLabel:getContentSize().width, 30))

				local node_lock = self._itemCellLock:clone()

				node_lock:setVisible(true)
				node_lock:addTo(node):posite(55, 75)

				local Panel_unlock = node_lock:getChildByFullName("Panel_unlock")
				local Panel_lock = node_lock:getChildByFullName("Panel_lock")
				local entry = self._bagSystem:getEntryById(itemData.itemId)

				if not entry then
					Panel_unlock:setVisible(false)
					Panel_lock:setVisible(false)
					itemPanel:setSwallowTouches(false)
				elseif entry.item:getCanLock() then
					Panel_unlock:addTouchEventListener(function(sender, eventType)
						self:onUnlockOrLockItem(sender, eventType, itemData)
					end)
					Panel_lock:addTouchEventListener(function(sender, eventType)
						self:onUnlockOrLockItem(sender, eventType, itemData)
					end)

					if entry.unlock then
						Panel_unlock:setVisible(true)
						Panel_lock:setVisible(false)
						itemPanel:setSwallowTouches(false)
						itemPanel:addTouchEventListener(function(sender, eventType)
							self:onEatItemClicked(sender, eventType, true)
						end)
					else
						Panel_unlock:setVisible(false)
						Panel_lock:setVisible(true)
					end
				else
					Panel_unlock:setVisible(false)
					Panel_lock:setVisible(false)
					itemPanel:setSwallowTouches(false)
					itemPanel:addTouchEventListener(function(sender, eventType)
						self:onEatItemClicked(sender, eventType, true)
					end)
				end

				local minusBtn = node:getChildByFullName("minusbtn")

				minusBtn:setVisible(curNum > 0)
				minusBtn:addTouchEventListener(function(sender, eventType)
					self:onEatItemClicked(sender, eventType, false)
				end)

				itemPanel.data = itemData
				itemPanel.numPanel = numPanel
				itemPanel.minusBtn = minusBtn
				minusBtn.data = itemData
				minusBtn.numPanel = numPanel
				minusBtn.minusBtn = minusBtn
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
					node_lock:addTo(node):posite(55, 75)

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

				local numPanel = node:getChildByFullName("numPanel")
				local curNum = itemData.expData.eatCount
				local expLabel = numPanel:getChildByFullName("exp")
				local numLabel = numPanel:getChildByFullName("num")

				expLabel:setString("+" .. itemData.expData.exp)
				numLabel:setString("")
				expLabel:setPositionX(0)
				numLabel:setPositionX(expLabel:getContentSize().width)
				numPanel:setContentSize(cc.size(expLabel:getContentSize().width + numLabel:getContentSize().width, 30))
				itemPanel:setTouchEnabled(canTouch)
				itemPanel:setSwallowTouches(false)
				itemPanel:addTouchEventListener(function(sender, eventType)
					self:onEatItemClicked(sender, eventType, true)
				end)

				local minusBtn = node:getChildByFullName("minusbtn")

				minusBtn:setVisible(curNum > 0)
				minusBtn:addTouchEventListener(function(sender, eventType)
					self:onEatItemClicked(sender, eventType, false)
				end)

				itemPanel.data = itemData
				itemPanel.numPanel = numPanel
				itemPanel.minusBtn = minusBtn
				minusBtn.data = itemData
				minusBtn.numPanel = numPanel
				minusBtn.minusBtn = minusBtn

				if self._equipData:getEquipId() == itemData.expData.equipBaseId then
					local image = ccui.ImageView:create("asset/common/common_bg_xb_5.png")

					image:setScale(0.86)
					image:addTo(itemPanel):posite(22, 83)

					local str = cc.Label:createWithTTF(Strings:get("Equip_UI71"), TTF_FONT_FZYH_R, 16)

					str:setOverflow(cc.LabelOverflow.SHRINK)
					str:setDimensions(image:getContentSize().width * 0.7, image:getContentSize().height * 0.8)
					GameStyle:setCommonOutlineEffect(str)
					str:addTo(itemPanel):posite(30, 83)
					expLabel:setColor(cc.c3b(191, 241, 26))
				else
					expLabel:setColor(cc.c3b(255, 255, 255))
				end
			end
		end
	end
end

function EquipStarLevelMediator:refreshView()
	self._progressLabel:setString(self._curExp .. "/" .. self._needNum)
	self._loadingBar:setPercent(self._curExp / self._needNum * 100)

	local var_26_0

	if #self._stiveItem == 0 then
		var_26_0 = self._equipList

		if self._equipList then
			if #self._equipList == 0 then
				var_26_0 = self._repleaseItemsand and #self._repleaseItemsand == 0
			end
		end
	end

	self._emptyTip:setVisible(var_26_0)
	self._sureWidget:getButton():setGray(self._curExp < self._needNum)
end

function EquipStarLevelMediator:onClickQuick()
	self:resetTableView()

	if self._curExp >= self._needNum then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI79")
		}))

		return
	end

	self:getQuickItems()
	self._tableView:reloadData()
	self:refreshProgrView(self._curExp)
	self:dispatch(ShowTipEvent({
		tip = Strings:get("Equip_UI79")
	}))
end

function EquipStarLevelMediator:getQuickItems()
	local selectData = self._equipSystem:getSelectData()

	if ((self._useCompose or nil) and selectData.canUseStone) == "1" then
		for i = 1, #self._stiveItem do
			if self._curExp >= self._needNum then
				return self._curExp
			end

			local itemData = self._stiveItem[i]
			local itemId = itemData.itemId
			local exp = itemData.exp
			local allCount = itemData.allCount

			if self._consumeTemp.items[itemId] then
				if not self._consumeTemp.items[itemId].eatCount then
					local eatCount = 0

					for jj = eatCount + 1, allCount do
						if self._curExp >= self._needNum then
							return self._curExp
						end

						self._curExp = self._curExp + exp
						self._stiveItem[i].eatCount = self._stiveItem[i].eatCount + 1
						self._consumeTemp.items[itemId] = {
							eatCount = self._stiveItem[i].eatCount,
							exp = exp
						}
					end
				end
			end
		end
	end

	if self._useCompose and selectData.canUseCompose == "1" then
		for i = 1, #self._composeItems do
			if self._curExp >= self._needNum then
				return self._curExp
			end

			local itemData = self._composeItems[i]
			local itemId = itemData.itemId
			local entry = self._bagSystem:getEntryById(itemId)

			if entry and entry.unlock == true then
				local exp = itemData.exp
				local allCount = itemData.allCount

				if self._consumeTemp.items[itemId] then
					if not self._consumeTemp.items[itemId].eatCount then
						local eatCount = 0

						for jj = eatCount + 1, allCount do
							if self._curExp >= self._needNum then
								return self._curExp
							end

							self._curExp = self._curExp + exp
							self._composeItems[i].eatCount = self._composeItems[i].eatCount + 1
							self._consumeTemp.items[itemId] = {
								eatCount = self._composeItems[i].eatCount,
								exp = exp
							}
						end
					end
				end
			end
		end
	end

	if self._equipList then
		for i = 1, #self._equipList do
			if self._curExp >= self._needNum then
				return self._curExp
			end

			local equip = self._equipList[i]
			local unlock = equip:getUnlock()
			local rarity = equip:getRarity()
			local heroId = equip:getHeroId()
			local star = equip:getStar()
			local onlyOneStar = selectData.onlyOneStar == "1"
			local canUse = unlock and heroId == ""

			if canUse and selectData[tostring(rarity)] == "1" and (not onlyOneStar or onlyOneStar and star == 1) then
				local itemData = equip.expData
				local eatCount = itemData.eatCount
				local id = itemData.id
				local exp = itemData.exp

				if eatCount == 0 then
					self._curExp = self._curExp + exp
					self._equipList[i].expData.eatCount = self._equipList[i].expData.eatCount + 1
					self._consumeTemp.equips[id] = {
						eatCount = self._equipList[i].expData.eatCount,
						exp = exp
					}
				end
			end
		end
	end

	return self._curExp
end

function EquipStarLevelMediator:onClickSure()
	if self._curExp < self._needNum then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI72")
		}))

		return
	end

	local function callback()
		self._equipSystem:setEquipStarUpItem(self._curExp, self._consumeTemp)

		if self._callback then
			self._callback()
		end

		self:close()
	end

	callback()
end

function EquipStarLevelMediator:onClickRule()
	if not self._ruleNode:isVisible() then
		self._ruleNode:setVisible(true)
	end
end

function EquipStarLevelMediator:onClickSelect()
	local view = self:getInjector():getInstance("EquipStarItemSelectView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		useCompose = self._useCompose
	}, nil))
end

function EquipStarLevelMediator:onOkClicked()
	self._equipSystem:resetEquipStarUpItem()

	if self._callback then
		self._callback()
	end

	self:close()
end

function EquipStarLevelMediator:refreshProgrView(nowExp)
	self._loadingBar:setPercent(nowExp / self._needNum * 100)
	self._progressLabel:setString(nowExp .. "/" .. self._needNum)
	self._sureWidget:getButton():setGray(nowExp < self._needNum)
end

function EquipStarLevelMediator:onEatItemClicked(sender, eventType, isAdd)
	if eventType == ccui.TouchEventType.began then
		self._touchAddCount = 0
		self._touchNode = sender
		self._canTouch = isAdd and self:checkBeginEatCount(sender) or self:checkBeginMinusCount(sender)

		if not self._canTouch then
			return
		end

		self._isAdd = isAdd

		self:closeAllScheduler()
		self:resetTableView()
		self:touchBegin(sender)
	elseif eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:closeSleepScheduler()
		self:closeLongAddScheduler()

		if not self._canTouch then
			return
		end

		self:touchEnd(sender)
	elseif eventType == ccui.TouchEventType.canceled then
		self:closeSleepScheduler()
		self:closeLongAddScheduler()
	end
end

function EquipStarLevelMediator:getCostNumByItemCount(count, sender)
	local itemId = sender.data.itemId

	if self._useCompose then
		return 1
	end

	if not itemId then
		return 1
	end

	local data = ConfigReader:getRecordById("ExpConsume", tostring(itemId or "200004"))

	if not count then
		return data.ExpConsumeConut[1]
	end

	if count <= data.ExpConsumeRate[1] then
		return data.ExpConsumeConut[1]
	end

	if count >= data.ExpConsumeRate[#data.ExpConsumeRate] then
		return data.ExpConsumeConut[#data.ExpConsumeConut]
	end

	for i = 1, #data.ExpConsumeRate do
		local preCount = data.ExpConsumeRate[i]

		if count < preCount then
			return data.ExpConsumeConut[i]
		end
	end

	return data.ExpConsumeConut[1]
end

function EquipStarLevelMediator:getSpeedByItemCount(count, sender)
	local itemId = sender.data.itemId

	if self._useCompose then
		return 0.2
	end

	if not itemId then
		return 0.2
	end

	local data = ConfigReader:getRecordById("ExpConsume", tostring(itemId or "200004"))

	if not count then
		return data.ExpConsumeSpeed[1]
	end

	if count < data.ExpConsumeRate[1] then
		return data.ExpConsumeSpeed[1]
	end

	if count >= data.ExpConsumeRate[#data.ExpConsumeRate] then
		return data.ExpConsumeSpeed[#data.ExpConsumeSpeed]
	end

	for i = 1, #data.ExpConsumeRate do
		local preCount = data.ExpConsumeRate[i]

		if count <= preCount then
			return data.ExpConsumeSpeed[i + 1]
		end
	end

	return data.ExpConsumeSpeed[1]
end

function EquipStarLevelMediator:checkBeginEatCount(sender)
	local data = sender.data

	if data.expData then
		data = data.expData
	end

	local lastCount = data.allCount - data.eatCount

	if lastCount == 0 then
		return false
	end

	if self._curExp >= self._needNum then
		local tip = Strings:get("Hero_Star_UI_Remind1")

		self:dispatch(ShowTipEvent({
			tip = tip
		}))

		return false
	end

	return true
end

function EquipStarLevelMediator:checkBeginMinusCount(sender)
	local data = sender.data

	if data.expData then
		data = data.expData
	end

	if data.eatCount == 0 then
		return false
	end

	return true
end

function EquipStarLevelMediator:canEatItem(itemNode, hasTip)
	local data = itemNode.data

	if data.expData then
		data = data.expData
	end

	if data.allCount == 0 or data.allCount == data.eatCount then
		return false
	end

	if self._addExp >= self._needNum then
		if hasTip then
			local tip = Strings:get("Hero_Star_UI_Remind1")

			self:dispatch(ShowTipEvent({
				tip = tip
			}))
		end

		return false
	end

	return true
end

function EquipStarLevelMediator:canMinusItem(itemNode, hasTip)
	local data = itemNode.data

	if data.expData then
		data = data.expData
	end

	if data.eatCount <= 0 and (not hasTip or true) then
		return false
	end

	return true
end

function EquipStarLevelMediator:touchBegin(sender)
	if self._isAdd then
		local canAdd = self:canEatItem(sender, true)

		if not canAdd then
			self:closeLongAddScheduler()

			return false
		end
	else
		local canMinus = self:canMinusItem(sender, true)

		if not canMinus then
			return
		end
	end

	self:createProgrScheduler(sender)
	self:createSleepScheduler(sender)
end

function EquipStarLevelMediator:createLongAddSch(sender)
	self:closeSleepScheduler()

	local time = 1

	self:createSleepScheduler(time, sender)
end

function EquipStarLevelMediator:touchEnd(sender)
	local data = sender.data

	if data.expData then
		data = data.expData
	end

	if data.allCount == 0 then
		return
	end

	self:eatOneItem(self._touchNode, false)
end

function EquipStarLevelMediator:resetTableView()
	self._eatExp = 0
	self._curExp = self._equipData:getOverflowStarExp()

	if self._useCompose then
		self._curExp = 0
	end

	for i, value in pairs(self._consumeTemp.items) do
		self._curExp = self._curExp + value.eatCount * value.exp
	end

	for i, value in pairs(self._consumeTemp.equips) do
		self._curExp = self._curExp + value.eatCount * value.exp
	end

	self._finalExp = self._curExp
	self._addExp = self._curExp
	self._minusOnceExp = 1
	self._eatOnceExp = 1

	self:refreshProgrView(self._curExp)
end

function EquipStarLevelMediator:touchSleepEnd(sender)
	self:closeSleepScheduler()
	self:eatOneItem(self._touchNode, true)

	local time = self:getSpeedByItemCount(self._touchAddCount, sender)

	self:createLongAddScheduler(time, sender)
end

function EquipStarLevelMediator:longAdd(sender)
	local onceAddTime = self:getCostNumByItemCount(self._touchAddCount, sender)

	for i = 1, onceAddTime do
		local stopAdd = self:eatOneItem(self._touchNode, true)

		if not stopAdd then
			break
		end
	end
end

function EquipStarLevelMediator:eatOneItem(sender)
	local isAdd = self._isAdd

	if not (isAdd and self:canEatItem(sender, true) or self:canMinusItem(sender, true)) then
		self:closeLongAddScheduler()

		return false
	end

	self:createProgrScheduler()

	local changeNum = isAdd and 1 or -1
	local data = sender.data

	if data.expData then
		data = data.expData
	end

	data.eatCount = data.eatCount + changeNum

	if data.eatCount < 0 then
		data.eatCount = 0
	end

	self._touchAddCount = self._touchAddCount + 1 * changeNum

	local changeExp = data.exp

	self._eatExp = self._eatExp + changeExp
	self._addExp = self._addExp + data.exp * changeNum
	self._finalExp = self._finalExp + data.exp * changeNum

	self:refreshEatNode(sender)

	return true
end

function EquipStarLevelMediator:refreshEatNode(sender)
	local data = sender.data
	local numPanel = sender.numPanel
	local minusBtn = sender.minusBtn

	if numPanel and minusBtn then
		local expLabel = numPanel:getChildByFullName("exp")
		local numLabel = numPanel:getChildByFullName("num")

		if data.expData then
			local count = data.expData.eatCount

			minusBtn:setVisible(count > 0)
			numLabel:setString("")

			self._consumeTemp.equips[data.expData.id] = count > 0 and {
				eatCount = count,
				exp = data.expData.exp
			} or nil
		else
			local count = data.eatCount

			minusBtn:setVisible(count > 0)

			local numStr = count == 0 and "" or string.format("(%d)", count)

			numLabel:setString(numStr)

			self._consumeTemp.items[data.itemId] = count > 0 and {
				eatCount = count,
				exp = data.exp
			} or nil
		end

		expLabel:setPositionX(0)
		numLabel:setPositionX(expLabel:getContentSize().width)
		numPanel:setContentSize(cc.size(expLabel:getContentSize().width + numLabel:getContentSize().width, 30))
	end
end

function EquipStarLevelMediator:progrShow(sender)
	if self._isAdd then
		self:progrNormalShow(false, sender)
	else
		self:progrNormalMinusShow(false, sender)
	end
end

function EquipStarLevelMediator:checkCanEatItem(sender)
	if self._eatExp <= 0 then
		self:progrNormalShow(true, sender)

		return false
	end

	return true
end

function EquipStarLevelMediator:checkCanMinusItem(sender)
	local data = sender.data

	if data.eatCount <= 0 then
		self:closeProgrScheduler()

		return false
	end

	return true
end

function EquipStarLevelMediator:refreshEatOnceExp(nextExp)
	self._eatOnceExp = (nextExp - self._curExp) / self._seeTime

	if nextExp == self._curExp or self._finalExp == self._curExp then
		if nextExp < self._finalExp and self._finalExp ~= self._curExp then
			self._eatOnceExp = (self._finalExp - nextExp) / self._seeTime
		else
			self:closeProgrScheduler()

			return
		end
	end

	if self._eatOnceExp > self._eatExp then
		self._eatOnceExp = self._eatExp
	end

	self._eatOnceExp = self._eatOnceExp < 1 and 1 or self._eatOnceExp
	self._eatOnceExp = math.modf(self._eatOnceExp)
end

function EquipStarLevelMediator:refreshMinusOnceExp(nextExp)
	self._minusOnceExp = self._curExp / self._seeTime

	if self._minusOnceExp > self._eatExp then
		self._minusOnceExp = self._eatExp
	end

	self._minusOnceExp = self._minusOnceExp < 1 and 1 or self._minusOnceExp
	self._minusOnceExp = math.modf(self._minusOnceExp)
end

function EquipStarLevelMediator:progrNormalShow(closeCheck, sender)
	local nextExp = self._needNum

	if not closeCheck then
		local canEat = self:checkCanEatItem(sender)

		if not canEat then
			return
		end
	end

	self:refreshEatOnceExp(nextExp)

	local stopSche = false
	local expChange = false

	for i = 1, self._seeTime do
		if self._eatExp <= 0 then
			break
		end

		if self._eatOnceExp > self._eatExp then
			self._eatOnceExp = self._eatExp
		end

		if self._eatExp >= self._eatOnceExp then
			self._curExp = self._curExp + self._eatOnceExp
			self._eatExp = self._eatExp - self._eatOnceExp
		end

		expChange = true
	end

	if stopSche then
		self:closeProgrScheduler()
	end

	if expChange then
		self:refreshProgrView(self._curExp)
	end
end

function EquipStarLevelMediator:progrNormalMinusShow(closeCheck, sender)
	local nextExp = self._needNum

	if not closeCheck then
		-- block empty
	end

	self:refreshMinusOnceExp(nextExp)

	local stopSche = false
	local expChange = false

	for i = 1, self._seeTime do
		if self._minusOnceExp > self._eatExp then
			self._minusOnceExp = self._eatExp
		end

		if self._eatExp <= 0 then
			expChange = true
			stopSche = true

			break
		end

		if self._eatExp >= self._minusOnceExp then
			self._curExp = self._curExp - self._minusOnceExp
			self._eatExp = self._eatExp - self._minusOnceExp
		end

		expChange = true
	end

	if stopSche then
		self:closeProgrScheduler()
	end

	if expChange then
		self:refreshProgrView(self._curExp)
	end
end

local progrSleepTime = 0.02

function EquipStarLevelMediator:createProgrScheduler(sender)
	self:closeProgrScheduler()

	if self._progrScheduler == nil then
		self._progrScheduler = LuaScheduler:getInstance():schedule(function()
			self:progrShow(sender)
		end, progrSleepTime, false)
	end
end

function EquipStarLevelMediator:closeProgrScheduler()
	if self._progrScheduler then
		LuaScheduler:getInstance():unschedule(self._progrScheduler)

		self._progrScheduler = nil
	end
end

function EquipStarLevelMediator:createSleepScheduler(sender)
	self:closeSleepScheduler()

	if self._sleepScheduler == nil then
		self._sleepScheduler = LuaScheduler:getInstance():schedule(function()
			self:touchSleepEnd(sender)
		end, 1, false)
	end
end

function EquipStarLevelMediator:closeSleepScheduler()
	if self._sleepScheduler then
		LuaScheduler:getInstance():unschedule(self._sleepScheduler)

		self._sleepScheduler = nil
	end
end

function EquipStarLevelMediator:createLongAddScheduler(time, sender)
	self:closeLongAddScheduler()

	if self._longAddScheduler == nil then
		self._longAddScheduler = LuaScheduler:getInstance():schedule(function()
			self:longAdd(sender)
		end, time, false)
	end
end

function EquipStarLevelMediator:closeLongAddScheduler()
	if self._longAddScheduler then
		LuaScheduler:getInstance():unschedule(self._longAddScheduler)

		self._longAddScheduler = nil
	end
end

function EquipStarLevelMediator:closeAllScheduler()
	self:closeLongAddScheduler()
	self:closeSleepScheduler()
	self:closeProgrScheduler()
end

function EquipStarLevelMediator:onUnlockOrLockEquip(sender, eventType, itemData)
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

function EquipStarLevelMediator:refreshViewByLock()
	if self._itemData_change and self._itemData_change.expData and self._doTip_Unlock then
		self._consumeTemp.equips[self._itemData_change.expData.id] = nil
		self._itemData_change.expData.eatCount = 0
	end

	if self._doTip_Unlock then
		local var_68_0 = Strings:get("Equip_Lock_Tips_2")

		if not var_68_0 then
			var_68_0 = Strings:get("Equip_Lock_Tips_1")

			local tip = var_68_0

			self:dispatch(ShowTipEvent({
				tip = tip
			}))
			self._itemData_change:setUnlock(not self._doTip_Unlock)
			self:resetTableView()

			local offsetY = self._tableView:getContentOffset().y

			self._tableView:reloadData()
			self._tableView:setContentOffset(cc.p(0, offsetY))
			self:refreshView()
		end
	end
end

function EquipStarLevelMediator:onUnlockOrLockItem(sender, eventType, itemData)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		local params = {
			viewtype = 2,
			itemId = itemData.itemId
		}

		self._itemData_change = itemData

		self._bagSystem:requestItemLock(params)
	end
end

function EquipStarLevelMediator:refreshViewByItemLock()
	if self._itemData_change then
		local entry = self._bagSystem:getEntryById(self._itemData_change.itemId)

		if self._itemData_change.eatCount > 0 and entry.unlock == false then
			self._consumeTemp.items[self._itemData_change.itemId] = nil
			self._itemData_change.eatCount = 0
		end

		if entry.unlock then
			local var_70_0 = Strings:get("Equip_Ur_Lock_2")

			if not var_70_0 then
				var_70_0 = Strings:get("Equip_Ur_Lock_1")

				local tip = var_70_0

				self:dispatch(ShowTipEvent({
					tip = tip
				}))
				self:resetTableView()

				local offsetY = self._tableView:getContentOffset().y

				self._tableView:reloadData()
				self._tableView:setContentOffset(cc.p(0, offsetY))
				self:refreshView()
			end
		end
	end
end
