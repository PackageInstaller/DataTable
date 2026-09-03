-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tsoul/view/TSoulCompoundMediator.lua

TSoulCompoundMediator = class("TSoulCompoundMediator", DmAreaViewMediator, _M)

local skillAttrName = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_SkillAttrName", "content")
local kBtnHandlers = {
	btn_rule = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	}
}

function TSoulCompoundMediator:initialize()
	super.initialize(self)
end

function TSoulCompoundMediator:onRegister()
	super.onRegister(self)

	self._gameServerAgent = self:getInjector():getInstance("GameServerAgent")

	local developSystem = self:getInjector():getInstance("DevelopSystem")

	self._player = developSystem:getPlayer()
	self._bagSystem = developSystem:getBagSystem()
	self._heroSystem = developSystem:getHeroSystem()
	self._developSystem = developSystem
	self._tSoulSystem = self._developSystem:getTSoulSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self:createMapEvent()
end

function TSoulCompoundMediator:dispose()
	self._closeView = true

	super.dispose(self)
end

function TSoulCompoundMediator:enterWithData(data)
	local mc = cc.MovieClip:create("huaban_zhuxianchangjing")

	mc:addTo(self:getView())
	mc:setPosition(cc.p(600, 390))
	self:setupTopInfoWidget()

	self._heroId = data.heroId
	self._selectBagStones = {}
	self._sellectPointIndex = 1

	self:createData()
	self:initNodes()
	self:processBagView()
	self:refreshView(true)
end

function TSoulCompoundMediator:createData()
	local heroId = self._heroId

	self._heroData = self._heroSystem:getHeroById(heroId)
	self._allTsouls = self._tSoulSystem:getTSoulSortList()
	self._showBagData = self._tSoulSystem:getSortExtendIds(self._allTsouls)

	self._tSoulSystem:initExtendParam()
	self._tSoulSystem:setSortExtand(0)
end

function TSoulCompoundMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPower,
			CurrencyIdKind.kCrystal,
			CurrencyIdKind.kGold
		},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Tsoul_Compose_UI1")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function TSoulCompoundMediator:onClickBack(sender, eventType)
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end

function TSoulCompoundMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._middleNode = self._mainPanel:getChildByFullName("Node_middle")
	self._rightNode = self:getView():getChildByFullName("Node_right")

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 252, 228, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 222, 88, 255)
		}
	}
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = GameStyle:stringToColor("#feffd9")
		},
		{
			ratio = 0.7,
			color = GameStyle:stringToColor("#ffc600")
		}
	}

	self._gailvTip = self._middleNode:getChildByFullName("_gailvTip")
	self._Panel_icon = self._middleNode:getChildByFullName("Node_1.Panel_icon")
	self._hechengTip1 = self._middleNode:getChildByFullName("_hechengTip1")
	self._hechengTip2 = self._middleNode:getChildByFullName("_hechengTip2")
	self._hechengTip3 = self._middleNode:getChildByFullName("_hechengTip3")
	self._hechengTip4 = self._middleNode:getChildByFullName("_hechengTip4")
	self._hechengTip5 = self._middleNode:getChildByFullName("_hechengTip5")
	self._hechengTip6 = self._middleNode:getChildByFullName("_hechengTip6")
	self._hechengTip7 = self._middleNode:getChildByFullName("_hechengTip7")
	self._hechengBtn = self._middleNode:getChildByFullName("_hechengBtn")
	self._selectWidget = self:bindWidget("Node_right.SelectBtnNode", TwoLevelViceButton, {
		handler = bind1(self.onClickSelect, self)
	})

	self._selectWidget._nameText:setScale(1.3)

	self._oneKeySelectWidget = self:bindWidget("Node_right.ButtonBag", TwoLevelViceButton, {
		handler = bind1(self.onClickOneKey, self)
	})

	self._oneKeySelectWidget._nameText:setScale(1.3)

	self._hechongBtnWiget = self:bindWidget("main.Node_middle._hechengBtn", OneLevelMainButton, {
		handler = bind1(self.onClickHecheng, self)
	})

	self._hechongBtnWiget._nameText:setScale(1.2)

	self._pointPanels = {}

	for i = 1, 5 do
		if i == 1 then
			self._pointPanels[i] = self._Panel_icon
		else
			local node = self._middleNode:getChildByFullName("Node_" .. i)

			self._pointPanels[i] = self._pointPanels[1]:clone()

			self._pointPanels[i]:addTo(node):posite(0, 0)
		end

		local Image_select = self._pointPanels[i]:getChildByFullName("Image_select")
		local Image_icon = self._pointPanels[i]:getChildByFullName("Image_icon")
		local Image_add = self._pointPanels[i]:getChildByFullName("Image_add")

		self._pointPanels[i]:getChildByFullName("Image_kong"):setScale(i == 1 and 1 or 0.82)
		self._pointPanels[i]:getChildByFullName("Image_icon"):setScale(i == 1 and 1 or 0.82)
		self._pointPanels[i]:getChildByFullName("Image_select"):setScale(i == 1 and 1 or 0.82)
		Image_select:setVisible(i == 1)
		Image_add:setVisible(i == 1)
		Image_add:setLocalZOrder(1000)
		Image_icon:setVisible(false)

		if i == 1 then
			Image_add:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(1, 1.5), cc.ScaleTo:create(1, 0.9))))
		end

		self._pointPanels[i]:addTouchEventListener(handler(self, self.onClickPoint))
		self._pointPanels[i]:setTag(i)
		self._pointPanels[i]:setTouchEnabled(true)
	end

	local unlockLevel = self._tSoulSystem:getCompoundUnlockLevel()
	local TypeOrder = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_TypeOrder", "content")
	local name = Strings:get(TypeOrder[tonumber(unlockLevel)])

	self._hechengTip3:setString(Strings:get("Tsoul_Compose_UI6", {
		Level = self._player:getLevel(),
		Rareity = name
	}))
	self._hechengTip4:setVisible(false)
	self._hechengTip5:setVisible(false)
	self._hechengTip7:setVisible(false)
	self._hechengTip6:setVisible(false)
	self._hechengTip1:setVisible(false)
	self._hechengTip2:setVisible(false)
	self._gailvTip:setString(Strings:get("Tsoul_Compose_UI4", {
		sheet1 = 0
	}))
	self._hechengBtn:setGray(true)

	self._touchPanel = self:getView():getChildByFullName("_touchPanel")

	self._touchPanel:addTouchEventListener(handler(self, self.onClickTouchPanle))
	self._touchPanel:setSwallowTouches(false)
	self._touchPanel:setVisible(false)
	GameStyle:setBtnClickEffect(self._touchPanel:getChildByFullName("_curSelectPointPanel._getOffBtn"), handler(self, self.onClickGetOff))
	self._middleNode:setLocalZOrder(11)

	self._Image_1 = self._mainPanel:getChildByFullName("Image_1"):setLocalZOrder(10)
	self._touchPanel = self:getView():getChildByFullName("_touchPanel"):setLocalZOrder(1000000)
	self._bagPanel = self._rightNode:getChildByFullName("Panel_mask._bagPanel")
	self._bagCell = self._bagPanel:getChildByFullName("_bagCell")
	self._bagAttrCell = self._bagPanel:getChildByFullName("_bagAttrCell")
	self._bagListView = self._bagPanel:getChildByFullName("_bagListView")
	self._emptTips = self._bagPanel:getChildByFullName("_emptTips")
	self._costPanel = self._middleNode:getChildByFullName("_costPanel")

	local bg = self._middleNode:getChildByFullName("Image_36_1"):setVisible(false)
end

function TSoulCompoundMediator:processBagView()
	if not self._tableView then
		self._bagCell:setVisible(false)
		self._bagAttrCell:setVisible(false)

		local viewSize = self._bagListView:getContentSize()
		local luaTableViewOj = LuaTableView:new({
			size = viewSize
		}, {
			cellNumFunc = function(view)
				return #self._showBagData
			end,
			cellSizeFunc = function(table, idx)
				return self._bagCell:getContentSize().width, self._bagCell:getContentSize().height
			end,
			cellTouch = function(table, cell)
				return
			end,
			cellAtIndexFunc = function(table, cell, idx, check)
				local index = idx + 1

				if not cell.panel then
					cell.panel = self._bagCell:clone()

					cell.panel:setVisible(true)
					cell.panel:setTouchEnabled(false)
					cell.panel:addTo(cell):posit(0, 0)
				end

				cell.index = index

				self:updateTableCell(cell.panel, index)
			end
		}, {
			direction = cc.SCROLLVIEW_DIRECTION_VERTICAL,
			verticalFillOrder = cc.TABLEVIEW_FILL_TOPDOWN,
			viewStyle = TableViewShowStyle.kReboundXCell
		})

		self._tableView = luaTableViewOj

		luaTableViewOj:getView():addTo(self._bagListView:getParent()):posite(self._bagListView:getPosition())
		self._tableView:setIsFirstEnter(true)
	end

	self._bagPanel:setVisible(true)
	self._tableView:reloadData()
	self._bagPanel:setPositionY(9.66)
	self._emptTips:setVisible(#self._showBagData == 0)
end

function TSoulCompoundMediator:updateTableCell(item, index)
	local stone = self._showBagData[index]
	local imgIcon = item:getChildByFullName("Image_icon")
	local bagtitle = item:getChildByFullName("bagtitle")
	local ListView_bagattr = item:getChildByFullName("ListView_bagattr")
	local userName = item:getChildByFullName("heroIcon")

	imgIcon:removeAllChildren()

	local icon = IconFactory:createTSoulIcon({
		id = stone:getConfigId()
	})

	icon:setScale(0.7)
	icon:addTo(imgIcon):center(imgIcon:getContentSize())
	GameStyle:setQualityText(bagtitle, stone:getRarity())
	bagtitle:setString(stone:getName())

	if stone:getHeroId() and stone:getHeroId() ~= "" then
		userName:setVisible(true)

		local heroInfo = {
			id = IconFactory:getRoleModelByKey("HeroBase", stone:getHeroId())
		}
		local headImgName = IconFactory:createRoleIconSpriteNew(heroInfo)

		headImgName:setScale(0.2)

		headImgName = IconFactory:addStencilForIcon(headImgName, 2, cc.size(31, 31))

		headImgName:addTo(userName):center(userName:getContentSize()):offset(-1, 0)
	else
		userName:setVisible(false)
	end

	item:setTouchEnabled(true)
	item:setSwallowTouches(false)

	item.stone = stone
	item.index = index

	item:addTouchEventListener(handler(self, self.onClickBagItem))
	ListView_bagattr:removeAllChildren()
	ListView_bagattr:setScrollBarEnabled(false)
	ListView_bagattr:setContentSize(140, 55)
	ListView_bagattr:setClippingEnabled(true)
	ListView_bagattr:setDirection(ccui.ScrollViewDir.vertical)
	ListView_bagattr:setTouchEnabled(true)

	local attrInfo = stone:getBaseAttr()

	for attrType, value in pairs(attrInfo) do
		local _cell = self._bagAttrCell:clone()

		_cell:setVisible(true)

		local name = Strings:get(skillAttrName[attrType])

		if AttributeCategory:getAttNameAttend(attrType) ~= "" then
			value = value * 100 .. "%"
		end

		_cell:getChildByFullName("attrName"):setString(name)
		_cell:getChildByFullName("attrNum"):setString("+" .. value)
		_cell:getChildByFullName("attrNum"):setPositionX(_cell:getChildByFullName("attrName"):getPositionX() + _cell:getChildByFullName("attrName"):getContentSize().width + 2)
		ListView_bagattr:pushBackCustomItem(_cell)
	end

	local attrInfo = stone:getAddAttr()

	for attrType, value in pairs(attrInfo) do
		local _cell = self._bagAttrCell:clone()

		_cell:setVisible(true)

		local name = Strings:get(skillAttrName[attrType])

		if AttributeCategory:getAttNameAttend(attrType) ~= "" then
			value = value * 100 .. "%"
		end

		_cell:getChildByFullName("attrName"):setString(name)
		_cell:getChildByFullName("attrNum"):setString("+" .. value)
		_cell:getChildByFullName("attrNum"):setPositionX(_cell:getChildByFullName("attrName"):getPositionX() + _cell:getChildByFullName("attrName"):getContentSize().width + 2)
		ListView_bagattr:pushBackCustomItem(_cell)
	end
end

function TSoulCompoundMediator:createMapEvent()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESH_TSOULS, self, self.refreshViewBySort)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FORTSOULCOMPOUND_SUCC, self, self.refreshViewByRequest)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshViewBySort)
end

function TSoulCompoundMediator:refreshViewBySort()
	self:refreshView()
end

function TSoulCompoundMediator:refreshViewByRequest(event)
	self._tSoulSystem:resetSortExtand()

	local data = event:getData()
	local result = data.data.result

	if result == 1 then
		local var_17_0 = Strings:get("Tsoul_Compose_UI12")

		if not var_17_0 then
			var_17_0 = Strings:get("Tsoul_Compose_UI13")

			local title = var_17_0

			if result == 1 then
				local var_17_1 = Strings:get("Tsoul_Compose_UI12_En")

				if not var_17_1 then
					var_17_1 = Strings:get("Tsoul_Compose_UI13_En")

					local title1 = var_17_1
					local rewards = data.data.reward
					local tSoulData, stoneId
					local mainOption = self._selectBagStones[1]:getId()

					if result == 1 then
						for k, v in ipairs(rewards) do
							if v.type == 34 then
								tSoulData = v
							end
						end

						local stoneData = data.d.player.tSouls
						local firstKey = next(stoneData)
						local targetData

						stoneId = ((firstKey or nil) and stoneData[firstKey]).id
					else
						stoneId = mainOption
					end

					local view = self:getInjector():getInstance("TSoulCompoundResultView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						maskOpacity = 0
					}, {
						stoneId = stoneId,
						reward = tSoulData,
						success = result,
						title = title,
						title1 = title1,
						oldStoneAttr = self._selectBagStones[1]:getAddAttr()
					}))

					for i = 1, #self._selectBagStones do
						self._selectBagStones[i] = nil

						self:refreshView((self._selectBagStones[1] == nil or nil) and true, true)
					end

					self:createData()
					self:processBagView()

					self._sellectPointIndex = 1
				end
			end
		end
	end
end

function TSoulCompoundMediator:refreshView(isInit, notChangeSelect)
	self._hechengTip1:setVisible(false)
	self._hechengTip2:setVisible(false)
	self._hechengBtn:setGray(isInit)
	self._touchPanel:setVisible(false)
	self._costPanel:removeAllChildren()

	if isInit then
		self._selectBagStones = {}

		local bg = self._middleNode:getChildByFullName("Image_36_1"):setVisible(false)
	elseif #self._selectBagStones > 0 then
		self._hechengTip1:setVisible(true)
		self._hechengTip2:setVisible(true)
		self._hechengTip1:removeAllChildren()

		local tip1 = self._hechengTip1:clone()

		tip1:addTo(self._hechengTip1):posite(self._hechengTip1:getContentSize().width, self._hechengTip1:getContentSize().height / 2)

		local str

		if self._selectBagStones[1]:getRarity() == 1 then
			tip1:setString(Strings:get("Tsoul_Compose_UI23"))
			tip1:setColor(GameStyle:getColor(self._selectBagStones[1]:getRarity() + 1))
		else
			local var_18_0 = {}

			var_18_0.sheet1 = self._tSoulSystem:getStoneNameByIdAndType(self._selectBagStones[1]:getConfigId(), true)

			tip1:setString(Strings:get("Tsoul_Compose_UI7", var_18_0))
			tip1:setColor(GameStyle:getColor(self._selectBagStones[1]:getRarity() + 1))
		end

		self._hechengTip2:removeAllChildren()

		local tip2 = self._hechengTip2:clone()

		tip2:addTo(self._hechengTip2):posite(self._hechengTip2:getContentSize().width, self._hechengTip2:getContentSize().height / 2)

		local str = self._tSoulSystem:getStoneNameByIdAndType(self._selectBagStones[1]:getConfigId(), false)

		tip2:setString(Strings:get("Tsoul_Compose_UI8", {
			sheet2 = str
		}))
		tip2:setColor(GameStyle:getColor(self._selectBagStones[1]:getRarity()))

		local costData = self._tSoulSystem:getCompoundCostCfgByLevel(self._selectBagStones[1]:getRarity())
		local allWidth = 0

		for i = 1, #costData do
			local icon1 = IconFactory:createPic({
				id = costData[i].id
			})

			icon1:setScale(0.8)
			icon1:setAnchorPoint(cc.p(0, 0.5))
			icon1:addTo(self._costPanel):center(self._costPanel:getContentSize())

			local amountText = cc.Label:createWithTTF(costData[i].amount, TTF_FONT_FZYH_R, 20)

			amountText:setAnchorPoint(cc.p(0, 0.5))
			amountText:addTo(self._costPanel):center(self._costPanel:getContentSize())

			allWidth = allWidth + icon1:getContentSize().width * icon1:getScale() + amountText:getContentSize().width

			local hasCount = self._bagSystem:getItemCount(costData[i].id)

			amountText:setColor(hasCount < costData[i].amount and GameStyle:getColor(ColorType.kRed) or cc.c3b(255, 255, 255))
		end

		local posX = (self._costPanel:getContentSize().width - allWidth) / 2 - 10
		local children = self._costPanel:getChildren()
		local lastNode

		for _, child in ipairs(children) do
			child:setPositionX(lastNode and lastNode:getPositionX() + lastNode:getContentSize().width * lastNode:getScale() - 10 or posX)

			lastNode = child
		end

		local bg = self._middleNode:getChildByFullName("Image_36_1"):setVisible(true)

		bg:setContentSize(allWidth, self._costPanel:getContentSize().height)
	end

	self._showBagData = self._tSoulSystem:getSortExtendIds(self._allTsouls)

	local newBagData = {}

	for i = 1, #self._showBagData do
		local isSame = false

		for _, stone in pairs(self._selectBagStones) do
			if stone == self._showBagData[i] then
				isSame = true

				break
			end
		end

		if isSame == false then
			table.insert(newBagData, self._showBagData[i])
		end
	end

	self._showBagData = newBagData

	self._tableView:reloadData()

	local index = self:getNextAvailableIndex()

	self._sellectPointIndex = not notChangeSelect and (isInit and 1 or index) or self._selectIndex

	for i = 1, #self._pointPanels do
		local pointPanel = self._pointPanels[i]

		if pointPanel then
			local Image_select = pointPanel:getChildByFullName("Image_select")
			local Image_icon = pointPanel:getChildByFullName("Image_icon")
			local Image_add = pointPanel:getChildByFullName("Image_add")

			Image_select:setVisible(i == self._sellectPointIndex)
			Image_add:setVisible(self._selectBagStones[i] == nil)
			Image_icon:setVisible(self._selectBagStones[i] ~= nil)

			if self._selectBagStones[i] then
				local icon = IconFactory:createTSoulIcon({
					id = self._selectBagStones[i]:getConfigId()
				})

				icon:setScale(0.7)
				icon:addTo(Image_icon):center(Image_icon:getContentSize())
			end

			Image_add:stopAllActions()

			if self._selectBagStones[i] == nil then
				Image_add:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(1, 1.5), cc.ScaleTo:create(1, 0.9))))
			end
		end
	end

	local rate = #self._selectBagStones > 0 and self._selectBagStones[1]:getRarity() == 1 and self._tSoulSystem:getCompoundRate(table.nums(self._selectBagStones) - 1) or self._tSoulSystem:getCompoundRateBYStoneCount(table.nums(self._selectBagStones) - 1)

	self._gailvTip:setString(Strings:get("Tsoul_Compose_UI4", {
		sheet1 = 100 * rate
	}))
end

function TSoulCompoundMediator:getNextAvailableIndex()
	for i = 1, 5 do
		if not self._selectBagStones[i] then
			return i
		end
	end

	return 6
end

function TSoulCompoundMediator:processSelectPointView(stone)
	if not stone then
		return
	end

	local _curSelectPointPanel = self._touchPanel:getChildByFullName("_curSelectPointPanel")
	local icon = _curSelectPointPanel:getChildByFullName("Image_icon")
	local bagtitle = _curSelectPointPanel:getChildByFullName("bagtitle")
	local ListView_bagattr = _curSelectPointPanel:getChildByFullName("ListView_bagattr")
	local iconImage = IconFactory:createTSoulIcon({
		id = stone:getConfigId()
	})

	iconImage:setScale(0.7)
	iconImage:addTo(icon):center(icon:getContentSize())
	bagtitle:setColor(GameStyle:getColor(stone:getLevel()))
	bagtitle:setString(stone:getName())
	ListView_bagattr:removeAllChildren()
	ListView_bagattr:setScrollBarEnabled(false)
	ListView_bagattr:setContentSize(150, 63)
	ListView_bagattr:setClippingEnabled(true)
	ListView_bagattr:setDirection(ccui.ScrollViewDir.vertical)
	ListView_bagattr:setTouchEnabled(true)

	local attrInfo = stone:getBaseAttr()

	for attrType, value in pairs(attrInfo) do
		local _cell = self._bagAttrCell:clone()

		_cell:setVisible(true)

		local name = Strings:get(skillAttrName[attrType])

		if AttributeCategory:getAttNameAttend(attrType) ~= "" then
			value = value * 100 .. "%"
		end

		_cell:getChildByFullName("attrName"):setString(name)
		_cell:getChildByFullName("attrNum"):setString("+" .. value)
		_cell:getChildByFullName("attrNum"):setPositionX(_cell:getChildByFullName("attrName"):getPositionX() + _cell:getChildByFullName("attrName"):getContentSize().width + 2)
		ListView_bagattr:pushBackCustomItem(_cell)
	end

	local attrInfo = stone:getAddAttr()

	for attrType, value in pairs(attrInfo) do
		local _cell = self._bagAttrCell:clone()

		_cell:setVisible(true)

		local name = Strings:get(skillAttrName[attrType])

		if AttributeCategory:getAttNameAttend(attrType) ~= "" then
			value = value * 100 .. "%"
		end

		_cell:getChildByFullName("attrName"):setString(name)
		_cell:getChildByFullName("attrNum"):setString("+" .. value)
		_cell:getChildByFullName("attrNum"):setPositionX(_cell:getChildByFullName("attrName"):getPositionX() + _cell:getChildByFullName("attrName"):getContentSize().width + 2)
		ListView_bagattr:pushBackCustomItem(_cell)
	end
end

function TSoulCompoundMediator:showCostViewTip(id, needNum)
	local param = {
		hasWipeTip = true,
		itemId = id,
		needNum = needNum
	}
	local delegate = __associated_delegate__(self)({
		willClose = function(self, parentMedi, data)
			return
		end
	})
	local view = self:getInjector():getInstance("sourceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param, delegate))
end

function TSoulCompoundMediator:onClickBagItem(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._isInAnim then
			return
		end

		local beganPos = sender:getTouchBeganPosition()
		local endPos = sender:getTouchEndPosition()
		local posX = math.abs(endPos.y - beganPos.y)

		if posX > 6 then
			return
		end

		if table.nums(self._selectBagStones) >= 5 then
			return
		end

		if #self._selectBagStones > 0 and sender.stone:getRarity() ~= self._selectBagStones[1]:getRarity() then
			return self:dispatch(ShowTipEvent({
				tip = Strings:get("FortuneWheel_Compose_Tips4")
			}))
		end

		if sender.stone and sender.stone:getHeroId() and sender.stone:getHeroId() ~= "" then
			local delegate = __associated_delegate__(self)({
				willClose = function(self, popupMediator, data)
					if data.response == AlertResponse.kOK then
						self._selectBagStones[self._sellectPointIndex] = sender.stone

						if self._sellectPointIndex == 1 then
							self._tSoulSystem:setSortExtand(2, sender.stone:getRarity())
						end

						self:refreshView()
					end
				end
			})
			local heroId = sender.stone:getHeroId()
			local heroName = Strings:get(ConfigReader:getDataByNameIdAndKey("HeroBase", heroId, "Name"))
			local data = {
				content = Strings:get("FortuneWheel_Compose_Tips3", {
					fontName = DEFAULT_TTF_FONT,
					heroname1 = heroName
				}),
				sureBtn = {},
				cancelBtn = {}
			}
			local view = self:getInjector():getInstance("AlertView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data, delegate))

			return
		end

		self._selectBagStones[self._sellectPointIndex] = sender.stone

		if self._sellectPointIndex == 1 then
			self._tSoulSystem:setSortExtand(2, sender.stone:getRarity())
		end

		self:refreshView()
	end
end

function TSoulCompoundMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._isInAnim then
			return
		end

		self:dismiss()
	end
end

function TSoulCompoundMediator:onClickHecheng(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._isInAnim then
			return
		end

		if #self._selectBagStones == 0 then
			return
		end

		if table.nums(self._selectBagStones) - 1 < self._tSoulSystem:getCompoundMinimum() then
			return self:dispatch(ShowTipEvent({
				tip = Strings:get("FortuneWheel_Compose_Tips2")
			}))
		end

		local costData = self._tSoulSystem:getCompoundCostCfgByLevel(self._selectBagStones[1]:getRarity())

		for i = 1, #costData do
			local hasCount = self._bagSystem:getItemCount(costData[i].id)

			if hasCount < costData[i].amount then
				return self:showCostViewTip(costData[i].id, costData[i].amount)
			end
		end

		local mainOption = self._selectBagStones[1]:getId()
		local deputyStones = {}

		for i = 2, 5 do
			if self._selectBagStones[i] then
				deputyStones[#deputyStones + 1] = self._selectBagStones[i]:getId()
			end
		end

		self._tSoulSystem:stoneCompound(mainOption, deputyStones)
	end
end

function TSoulCompoundMediator:onClickPoint(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._isInAnim then
			return
		end

		if #self._selectBagStones == 0 and sender:getTag() ~= 1 then
			return self:dispatch(ShowTipEvent({
				tip = Strings:get("FortuneWheel_Compose_Tips1")
			}))
		end

		self._sellectPointIndex = sender:getTag()

		for i = 1, #self._pointPanels do
			local Image_select = self._pointPanels[i]:getChildByFullName("Image_select")

			Image_select:setVisible(i == self._sellectPointIndex)
		end

		self._touchPanel:setVisible(self._selectBagStones[sender:getTag()] ~= nil)
		self:processSelectPointView(self._selectBagStones[sender:getTag()])

		self._selectIndex = sender:getTag()
	end
end

function TSoulCompoundMediator:onClickOneKey(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._isInAnim then
			return
		end

		if #self._showBagData then
			local dataCnt = 0

			if #self._selectBagStones == 0 then
				for i = 1, #self._showBagData do
					if self._showBagData[i]:getHeroId() == "" then
						self._selectBagStones[1] = self._showBagData[i]

						break
					end
				end

				self:refreshView()

				dataCnt = dataCnt + 1
			end

			for j = 2, 5 do
				if self._selectBagStones[j] == nil then
					for i = 1, #self._showBagData do
						if self._showBagData[i] and self._showBagData[i]:getHeroId() == "" and self._selectBagStones[1]:getRarity() == self._showBagData[i]:getRarity() then
							local isSame = false

							for key, value in pairs(self._selectBagStones) do
								if value == self._showBagData[i] then
									isSame = true
								end
							end

							if not isSame then
								self._selectBagStones[j] = self._showBagData[i]
								dataCnt = dataCnt + 1

								break
							end
						end
					end
				end
			end

			self:refreshView()
		end
	end
end

function TSoulCompoundMediator:onClickTouchPanle(sender, eventType, skillId)
	if eventType == ccui.TouchEventType.ended then
		self._touchPanel:setVisible(false)
	end
end

function TSoulCompoundMediator:onClickGetOff(sender, eventType, skillId)
	if eventType == ccui.TouchEventType.ended then
		self._selectBagStones[self._selectIndex] = nil

		self:refreshView((self._selectBagStones[1] == nil or nil) and true, true)
	end
end

function TSoulCompoundMediator:createSortView()
	if self._mainPanel:getChildByFullName("SortPanel") then
		return
	end

	local function callBack(data)
		self._subSortType = data.subSortType
	end

	self._sortComponent = SortTsoulListComponent:new({
		isHide = false,
		sortType = sortType,
		mediator = self,
		callBack = callBack
	})

	self._sortComponent:getRootNode():setVisible(false)
	self._sortComponent:getRootNode():addTo(self._mainPanel):offset(170, -300)
	self._sortComponent:getRootNode():setName("SortPanel")
	self._mainPanel:getChildByFullName("SortPanel"):setLocalZOrder(99999)
end

function TSoulCompoundMediator:onClickSelect()
	self._tSoulSystem:setSortExtand(0)
	self:createSortView()
	self:dispatch(Event:new(EVT_REFRESH_TSOULS, {}))
	self._sortComponent:getRootNode():setVisible(true)
	self._sortComponent:refreshView()
end

function TSoulCompoundMediator:onClickScreen()
	self._tSoulSystem:setSortExtand(0)
	self._sortComponent:getRootNode():setVisible(false)
	self._sortComponent:showExtand()
	self._teamView:stopScroll()
	self:refreshListView(true)
end

function TSoulCompoundMediator:onClickRule()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_RuleText", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule
	}))
end
