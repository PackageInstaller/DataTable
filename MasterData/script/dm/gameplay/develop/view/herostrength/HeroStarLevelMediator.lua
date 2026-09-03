-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroStarLevelMediator.lua

HeroStarLevelMediator = class("HeroStarLevelMediator", DmPopupViewMediator, _M)

HeroStarLevelMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kNum = 6
local kHeroStiveId = "IR_HeroStive"
local HeroStar_StiveChange = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroStar_StiveChange", "content")
local HeroStar_StiveChangeSelf = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroStar_StiveChangeSelf", "content")
local kExpConsumeKey = {
	[12] = "HeroStar_R",
	[15] = "HeroStar_SP",
	[13] = "HeroStar_SR",
	[14] = "HeroStar_SSR"
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

function HeroStarLevelMediator:initialize()
	super.initialize(self)
end

function HeroStarLevelMediator:dispose()
	self:closeAllScheduler()
	super.dispose(self)
end

function HeroStarLevelMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()
	self._bgWidget = bindWidget(self, "main.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onOkClicked, self)
		},
		title = Strings:get("Hero_Star_UI_Preview_SC"),
		title1 = Strings:get("Hero_Star_UI_Preview_EN"),
		bgSize = {
			width = 837,
			height = 574
		}
	})
	self._sureWidget = self:bindWidget("main.okBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onClickSure, self)
		}
	})
	self._quickWidget = self:bindWidget("main.quickBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onClickQuick, self)
		}
	})
end

function HeroStarLevelMediator:enterWithData(data)
	self:initData(data)
	self:initView()
	self:initTableView()
	self:refreshView()
end

function HeroStarLevelMediator:initData(data)
	self._callback = data.callback
	self._heroId = data.heroId
	self._needNum = data.needNum
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._ownHeroList = self._heroSystem:getOwnHeroIds(true)
	self._occupation = self._heroData:getType()
	self._cellsHeight = {}
	self._curExp = 0
	self._eatExp = 0
	self._addExp = 0
	self._isAdd = true
	self._seeTime = 10
	self._itemMap = {}

	local num = self._bagSystem:getItemCount(kHeroStiveId)

	if num > 0 then
		self._stiveItem = {
			exp = 1,
			eatCount = 0,
			itemId = kHeroStiveId,
			allCount = num
		}
	end

	local rarityArr = {
		"12",
		"13",
		"14",
		"15"
	}

	self._rarityItem = {
		["12"] = {},
		["13"] = {},
		["14"] = {},
		["15"] = {}
	}
	self._selfItem = nil

	for i = 1, #self._ownHeroList do
		local value = self._ownHeroList[i]
		local id = value.id
		local itemId = value.fragId
		local rarity = tostring(value.rareity)
		local num = self._bagSystem:getItemCount(itemId)
		local awakeHeroFragId, debrisCostCount = self._heroSystem:getAwakeHeroFragIdAndDebrisCostCount()

		if itemId == awakeHeroFragId then
			num = num - debrisCostCount

			if num < 0 then
				num = 0
			end
		end

		if num > 0 then
			local exp = HeroStar_StiveChange[rarity]

			if self._heroId == id then
				exp = math.floor(exp * HeroStar_StiveChangeSelf)
				self._selfItem = {
					eatCount = 0,
					itemId = itemId,
					exp = exp,
					rarity = tonumber(rarity),
					allCount = num
				}
			end

			local itemData = {
				eatCount = 0,
				heroId = id,
				itemId = itemId,
				exp = exp,
				rarity = tonumber(rarity),
				allCount = num
			}

			table.insert(self._rarityItem[rarity], itemData)
		end
	end

	local Hero_WivesTeam = ConfigReader:getRecordById("ConfigValue", "Hero_WivesTeam").content

	local function sortFunc(v)
		table.sort(v, function(a, b)
			if table.indexof(Hero_WivesTeam, a.heroId) then
				return false
			elseif table.indexof(Hero_WivesTeam, b.heroId) then
				return true
			end
		end)
	end

	for k, v in pairs(self._rarityItem) do
		if tonumber(k) == 12 or tonumber(k) == 13 then
			sortFunc(v)
		end
	end

	self._rarityItems = {}

	for i = 1, #rarityArr do
		local rarity = rarityArr[i]
		local items = self._rarityItem[rarity]

		if items and #items > 0 then
			table.insert(self._rarityItems, {
				rarity = tonumber(rarity),
				items = items
			})
		end
	end

	self._consumeTemp = {}
end

function HeroStarLevelMediator:initView()
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

	self._numClone = self._main:getChildByFullName("numClone")

	self._numClone:setVisible(false)

	local node = self._infoNode:getChildByFullName("node")
	local icon = ccui.ImageView:create("occupation_all.png", 1)

	icon:addTo(node):setScale(0.75)

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

	text:setString(Strings:get("Hero_Star_UI_Remind6"))

	local backimg = self._ruleNode:getChildByFullName("backimg")

	backimg:setContentSize(cc.size(text:getContentSize().width + 45, text:getContentSize().height + 50))

	local text = self._infoNode:getChildByFullName("text1")

	text:setString("")
	text:removeAllChildren()

	local str = Strings:get("Hero_Star_UI_Energy_Tip", {
		fontName = TTF_FONT_FZYH_R
	})
	local richText = ccui.RichText:createWithXML(str, {})

	richText:setAnchorPoint(cc.p(0, 0.5))
	richText:setPosition(cc.p(0, 0))
	richText:addTo(text)
end

function HeroStarLevelMediator:initTableView()
	self._cellWidth = self._cloneCell:getContentSize().width
	self._cellHeight = self._cloneCell:getContentSize().height
	self._itemPanelHeight = self._cloneCell:getChildByFullName("itemPanel"):getContentSize().height

	local function scrollViewDidScroll(view)
		self:closeSleepScheduler()
		self:closeLongAddScheduler()
	end

	local function cellSizeForTable(table, idx)
		return self._cellWidth, self._cellsHeight[idx + 1]
	end

	local function numberOfCellsInTableView(table)
		return self:getCellNum()
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

function HeroStarLevelMediator:createTeamCell(cell, index)
	cell:removeAllChildren()

	local height = self._cellsHeight[index]
	local node = self._cloneCell:clone()

	node:setVisible(true)
	node:addTo(cell)
	node:setContentSize(cc.size(self._cellWidth, height))

	local titleNode = node:getChildByFullName("titleNode")
	local titleBg = titleNode:getChildByFullName("titleBg")
	local rarityImg = titleNode:getChildByFullName("rarity")
	local text = titleNode:getChildByFullName("text")
	local addExp = titleNode:getChildByFullName("addExp")
	local itemPanel = node:getChildByFullName("itemPanel")

	itemPanel:removeAllChildren()

	if self._stiveItem and index == 1 then
		node:setPosition(0, 0)
		text:setVisible(true)
		rarityImg:setVisible(false)
		addExp:setString(Strings:get("Hero_Star_UI_Energy", {
			num = self._stiveItem.exp
		}))
		addExp:setPositionX(text:getPositionX() + text:getContentSize().width + 8)
		titleBg:setContentSize(cc.size(text:getContentSize().width + addExp:getContentSize().width + 20, 35))

		local item = IconFactory:createResourceIcon({
			id = kHeroStiveId
		})

		item:addTo(itemPanel):posite(self._cellWidth / 12, itemPanel:getContentSize().height - itemPanel:getContentSize().height / 2 + 7)
		item:setScale(0.88)

		local numPanel = self._numClone:clone()

		numPanel:setVisible(true)
		numPanel:addTo(itemPanel):posite(item:getPositionX(), item:getPositionY())

		local curNum = self._stiveItem.eatCount

		numPanel:setSwallowTouches(false)
		numPanel:getChildByFullName("num"):setString(curNum .. "/" .. self._stiveItem.allCount)
		numPanel:addTouchEventListener(function(sender, eventType)
			self:onEatItemClicked(sender, eventType, true)
		end)

		numPanel.data = self._stiveItem
		numPanel.minusPanel = numPanel

		local minusBtn = numPanel:getChildByFullName("minusbtn")

		minusBtn:setVisible(curNum > 0)
		minusBtn:addTouchEventListener(function(sender, eventType)
			self:onEatItemClicked(sender, eventType, false)
		end)

		minusBtn.data = self._stiveItem
		minusBtn.minusPanel = numPanel
	else
		index = self._stiveItem and index - 1 or index

		local data = self._rarityItems[index]

		if data then
			local rarity = data.rarity
			local items = data.items

			node:setPosition(0, 0)
			text:setVisible(false)
			rarityImg:setVisible(true)

			local addExpShow = HeroStar_StiveChange[tostring(rarity)]

			rarityImg:loadTexture(GameStyle:getHeroRarityImage(rarity), 1)
			rarityImg:ignoreContentAdaptWithSize(true)
			addExp:setString(Strings:get("Hero_Star_UI_Energy", {
				num = addExpShow
			}))
			addExp:setPositionX(rarityImg:getPositionX() + 50)
			titleBg:setContentSize(cc.size(70 + addExp:getContentSize().width, 35))

			local num = #items
			local itemPanelWidth = itemPanel:getContentSize().width

			if num > kNum then
				itemPanel:setContentSize(cc.size(itemPanelWidth, self._itemPanelHeight * math.ceil(num / kNum)))
			end

			local cellNum = math.ceil(num / kNum)

			for i = 1, cellNum do
				for j = 1, kNum do
					local indexTemp = kNum * (i - 1) + j
					local itemData = items[indexTemp]

					if itemData then
						if self._selfItem and self._consumeTemp[self._selfItem.itemId] and itemData.itemId == self._selfItem.itemId then
							itemData.eatCount = self._consumeTemp[self._selfItem.itemId].eatCount
						end

						local posX = self._cellWidth / 12 + (self._cellWidth / 7 + 15) * (j - 1)
						local posY = itemPanel:getContentSize().height - self._itemPanelHeight / 2 + 7 - self._itemPanelHeight * (i - 1)
						local item = IconFactory:createItemIcon({
							id = itemData.itemId
						})

						item:addTo(itemPanel):posite(posX, posY)
						item:setScale(0.88)

						local numPanel = self._numClone:clone()

						numPanel:setVisible(true)
						numPanel:addTo(itemPanel):posite(item:getPositionX(), item:getPositionY())

						if self._selfItem and itemData.itemId == self._selfItem.itemId then
							local image = ccui.ImageView:create("asset/common/common_bg_xb_5.png")

							image:setScale(0.86)
							image:addTo(item):posite(22, 93)

							local str = cc.Label:createWithTTF(Strings:get("HEROS_UI69"), TTF_FONT_FZYH_R, 16)

							GameStyle:setCommonOutlineEffect(str)
							str:addTo(item):posite(27, 100)
						end

						local curNum = itemData.eatCount
						local allCount = itemData.allCount

						numPanel:setSwallowTouches(false)
						numPanel:getChildByFullName("num"):setString(curNum .. "/" .. allCount)
						numPanel:addTouchEventListener(function(sender, eventType)
							self:onEatItemClicked(sender, eventType, true)
						end)

						numPanel.data = itemData
						numPanel.minusPanel = numPanel

						local minusBtn = numPanel:getChildByFullName("minusbtn")

						minusBtn:setVisible(curNum > 0)
						minusBtn:addTouchEventListener(function(sender, eventType)
							self:onEatItemClicked(sender, eventType, false)
						end)

						minusBtn.data = itemData
						minusBtn.minusPanel = numPanel
					end
				end
			end
		end
	end

	titleNode:setPositionY(node:getContentSize().height)
end

function HeroStarLevelMediator:getCellNum()
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

function HeroStarLevelMediator:refreshView()
	self._progressLabel:setString(self._curExp .. "/" .. self._needNum)
	self._loadingBar:setPercent(self._curExp / self._needNum * 100)
	self._emptyTip:setVisible(not self._stiveItem and #self._rarityItems == 0)
	self._sureWidget:getButton():setGray(self._curExp < self._needNum)
end

function HeroStarLevelMediator:onClickQuick()
	self:resetExp()

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

function HeroStarLevelMediator:getQuickItems()
	local selectData = self._heroSystem:getSelectData()

	if selectData.canUseStive == "1" and self._stiveItem then
		local exp = self._stiveItem.exp
		local itemId = self._stiveItem.itemId
		local allCount = self._stiveItem.allCount
		local eatCount = self._stiveItem.eatCount

		for jj = eatCount + 1, allCount do
			if self._curExp >= self._needNum then
				return
			end

			self._stiveItem.eatCount = self._stiveItem.eatCount + 1
			self._curExp = self._curExp + exp

			if not self._consumeTemp[itemId] then
				self._consumeTemp[itemId] = {
					eatCount = self._stiveItem.eatCount,
					exp = exp
				}
			else
				self._consumeTemp[itemId].eatCount = self._stiveItem.eatCount
			end
		end

		if self._curExp >= self._needNum then
			return
		end
	end

	if selectData.canUseOwn == "1" and self._selfItem then
		local itemId = self._selfItem.itemId

		if self._consumeTemp[itemId] then
			if not self._consumeTemp[itemId].eatCount then
				local eatCount = 0
				local exp = self._selfItem.exp
				local allCount = self._selfItem.allCount

				self._selfItem.eatCount = eatCount

				for jj = eatCount + 1, allCount do
					if self._curExp >= self._needNum then
						return
					end

					self._selfItem.eatCount = self._selfItem.eatCount + 1
					self._curExp = self._curExp + exp

					if not self._consumeTemp[itemId] then
						self._consumeTemp[itemId] = {
							eatCount = self._selfItem.eatCount,
							exp = exp,
							rarity = self._selfItem.rarity
						}
					else
						self._consumeTemp[itemId].eatCount = self._selfItem.eatCount
					end
				end

				if self._curExp >= self._needNum then
					return
				end
			end
		end
	end

	local Hero_WivesTeam = ConfigReader:getRecordById("ConfigValue", "Hero_WivesTeam").content

	for i = 1, #self._rarityItems do
		if self._curExp >= self._needNum then
			return
		end

		local rarity = self._rarityItems[i].rarity

		if selectData[tostring(rarity)] == "1" then
			local items = self._rarityItems[i].items
			local itemNum = #items

			for index = 1, itemNum do
				if self._curExp >= self._needNum then
					return
				end

				local rarity = items[index].rarity
				local ret = (rarity == 12 or rarity == 13) and table.indexof(Hero_WivesTeam, items[index].heroId)
				local itemId = items[index].itemId

				if not self._selfItem or self._selfItem.itemId ~= itemId then
					if not ret then
						local exp = items[index].exp
						local allCount = items[index].allCount
						local eatCount = items[index].eatCount

						for jj = eatCount + 1, allCount do
							if self._curExp >= self._needNum then
								return
							end

							self._rarityItems[i].items[index].eatCount = self._rarityItems[i].items[index].eatCount + 1
							self._curExp = self._curExp + exp

							if not self._consumeTemp[itemId] then
								self._consumeTemp[itemId] = {
									eatCount = self._rarityItems[i].items[index].eatCount,
									exp = exp,
									rarity = self._rarityItems[i].items[index].rarity
								}
							else
								self._consumeTemp[itemId].eatCount = self._rarityItems[i].items[index].eatCount
							end
						end
					end
				elseif self._selfItem.itemId == itemId then
					if not self._consumeTemp[itemId] then
						self._consumeTemp[itemId] = {
							eatCount = self._selfItem.eatCount,
							exp = self._selfItem.exp,
							rarity = self._selfItem.rarity
						}
					else
						self._rarityItems[i].items[index].eatCount = self._consumeTemp[itemId].eatCount
					end
				end
			end
		end
	end
end

function HeroStarLevelMediator:onClickSure()
	if self._curExp < self._needNum then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Hero_Star_UI_Remind2")
		}))

		return
	end

	local hasSSR = false
	local itemsTemp = {}

	for id, v in pairs(self._consumeTemp) do
		local count = v.eatCount

		if count > 0 then
			local rarity = v.rarity

			itemsTemp[id] = count

			if rarity and rarity == 14 then
				hasSSR = true
			end
		end
	end

	local function callback()
		self._heroSystem:setHeroStarUpItem(self._curExp, itemsTemp)

		if self._callback then
			self._callback()
		end

		self:close()
	end

	if hasSSR then
		local delegate = {}

		function delegate:willClose(popupMediator, data)
			if data.response == AlertResponse.kOK then
				callback()
			end
		end

		local data = {
			title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
			content = Strings:get("Hero_Star_UI_Remind4"),
			sureBtn = {},
			cancelBtn = {}
		}
		local view = self:getInjector():getInstance("AlertView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	else
		callback()
	end
end

function HeroStarLevelMediator:onClickRule()
	if not self._ruleNode:isVisible() then
		self._ruleNode:setVisible(true)
	end
end

function HeroStarLevelMediator:onOkClicked()
	self._heroSystem:resetHeroStarUpItem()

	if self._callback then
		self._callback()
	end

	self:close()
end

function HeroStarLevelMediator:onClickSelect()
	local view = self:getInjector():getInstance("HeroStarItemSelectView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, nil, nil))
end

function HeroStarLevelMediator:refreshProgrView(nowExp)
	self._loadingBar:setPercent(nowExp / self._needNum * 100)
	self._progressLabel:setString(nowExp .. "/" .. self._needNum)
	self._sureWidget:getButton():setGray(nowExp < self._needNum)
end

function HeroStarLevelMediator:onEatItemClicked(sender, eventType, isAdd)
	if eventType == ccui.TouchEventType.began then
		self._selectItemId = sender.data.itemId
		self._touchAddCount = 0
		self._touchNode = sender
		self._canTouch = isAdd and self:checkBeginEatCount(sender) or self:checkBeginMinusCount(sender)

		if not self._canTouch then
			return
		end

		self._isAdd = isAdd

		self:closeAllScheduler()
		self:resetExp()
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

function HeroStarLevelMediator:getCostNumByItemCount(count, sender)
	local itemId = sender.data.itemId
	local rarity = sender.data.rarity
	local data = ConfigReader:getRecordById("ExpConsume", tostring(itemId or "200004"))

	if rarity then
		local key = kExpConsumeKey[rarity]

		data = ConfigReader:getRecordById("ExpConsume", key)
	end

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

function HeroStarLevelMediator:getSpeedByItemCount(count, sender)
	local itemId = sender.data.itemId
	local rarity = sender.data.rarity
	local data = ConfigReader:getRecordById("ExpConsume", tostring(itemId or "200004"))

	if rarity then
		local key = kExpConsumeKey[rarity]

		data = ConfigReader:getRecordById("ExpConsume", key)
	end

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

function HeroStarLevelMediator:checkBeginEatCount(sender)
	local data = sender.data
	local allCount = data.allCount
	local lastCount = allCount - data.eatCount

	if lastCount <= 0 then
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

function HeroStarLevelMediator:checkBeginMinusCount(sender)
	local data = sender.data

	if data.eatCount == 0 then
		return false
	end

	return true
end

function HeroStarLevelMediator:canEatItem(itemNode, hasTip)
	local data = itemNode.data

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

function HeroStarLevelMediator:canMinusItem(itemNode, hasTip)
	local data = itemNode.data

	if data.eatCount <= 0 and (not hasTip or true) then
		return false
	end

	return true
end

function HeroStarLevelMediator:touchBegin(sender)
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

function HeroStarLevelMediator:createLongAddSch(sender)
	self:closeSleepScheduler()

	local time = 1

	self:createSleepScheduler(time, sender)
end

function HeroStarLevelMediator:touchEnd(sender)
	local data = sender.data

	if data.allCount == 0 then
		return
	end

	self:eatOneItem(self._touchNode, false)
end

function HeroStarLevelMediator:resetExp()
	self._eatExp = 0
	self._curExp = 0

	for i, value in pairs(self._consumeTemp) do
		self._curExp = self._curExp + value.eatCount * value.exp
	end

	self._addExp = self._curExp
	self._minusOnceExp = 1
	self._eatOnceExp = 1

	self:refreshProgrView(self._curExp)
end

function HeroStarLevelMediator:touchSleepEnd(sender)
	self:closeSleepScheduler()
	self:eatOneItem(self._touchNode, true)

	local time = self:getSpeedByItemCount(self._touchAddCount, sender)

	self:createLongAddScheduler(time, sender)
end

function HeroStarLevelMediator:longAdd(sender)
	local onceAddTime = self:getCostNumByItemCount(self._touchAddCount, sender)

	for i = 1, onceAddTime do
		local stopAdd = self:eatOneItem(self._touchNode, true)

		if not stopAdd then
			break
		end
	end
end

function HeroStarLevelMediator:eatOneItem(sender)
	local isAdd = self._isAdd

	if not (isAdd and self:canEatItem(sender, true) or self:canMinusItem(sender, true)) then
		self:closeLongAddScheduler()

		return false
	end

	self:createProgrScheduler()

	local changeNum = isAdd and 1 or -1
	local data = sender.data

	data.eatCount = data.eatCount + changeNum

	if data.eatCount < 0 then
		data.eatCount = 0
	end

	self._touchAddCount = self._touchAddCount + 1 * changeNum

	local changeExp = data.exp

	self._eatExp = self._eatExp + changeExp
	self._addExp = self._addExp + data.exp * changeNum

	self:refreshEatNode(sender)

	return true
end

function HeroStarLevelMediator:refreshEatNode(sender)
	local data = sender.data
	local minusPanel = sender.minusPanel

	if minusPanel then
		local count = data.eatCount

		minusPanel:getChildByFullName("minusbtn"):setVisible(count > 0)

		local label = minusPanel:getChildByName("num")

		label:setString(count .. "/" .. data.allCount)

		local dataTemp = {
			rarity = data.rarity,
			eatCount = count,
			exp = data.exp
		}

		self._consumeTemp[data.itemId] = count > 0 and dataTemp or nil
	end
end

function HeroStarLevelMediator:progrShow(sender)
	if self._isAdd then
		self:progrNormalShow(false, sender)
	else
		self:progrNormalMinusShow(false, sender)
	end
end

function HeroStarLevelMediator:checkCanEatItem(sender)
	if self._eatExp <= 0 then
		self:progrNormalShow(true, sender)

		return false
	end

	return true
end

function HeroStarLevelMediator:checkCanMinusItem(sender)
	local data = sender.data

	if data.eatCount <= 0 then
		self:closeProgrScheduler()

		return false
	end

	return true
end

function HeroStarLevelMediator:refreshEatOnceExp(nextExp)
	self._eatOnceExp = (nextExp - self._curExp) / self._seeTime

	if self._eatOnceExp > self._eatExp then
		self._eatOnceExp = self._eatExp
	end

	self._eatOnceExp = self._eatOnceExp < 1 and 1 or self._eatOnceExp
	self._eatOnceExp = math.modf(self._eatOnceExp)
end

function HeroStarLevelMediator:refreshMinusOnceExp(nextExp)
	self._minusOnceExp = self._curExp / self._seeTime

	if self._minusOnceExp > self._eatExp then
		self._minusOnceExp = self._eatExp
	end

	self._minusOnceExp = self._minusOnceExp < 1 and 1 or self._minusOnceExp
	self._minusOnceExp = math.modf(self._minusOnceExp)
end

function HeroStarLevelMediator:progrNormalShow(closeCheck, sender)
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

function HeroStarLevelMediator:progrNormalMinusShow(closeCheck, sender)
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

function HeroStarLevelMediator:createProgrScheduler(sender)
	self:closeProgrScheduler()

	if self._progrScheduler == nil then
		self._progrScheduler = LuaScheduler:getInstance():schedule(function()
			self:progrShow(sender)
		end, progrSleepTime, false)
	end
end

function HeroStarLevelMediator:closeProgrScheduler()
	if self._progrScheduler then
		LuaScheduler:getInstance():unschedule(self._progrScheduler)

		self._progrScheduler = nil
	end
end

function HeroStarLevelMediator:createSleepScheduler(sender)
	self:closeSleepScheduler()

	if self._sleepScheduler == nil then
		self._sleepScheduler = LuaScheduler:getInstance():schedule(function()
			self:touchSleepEnd(sender)
		end, 1, false)
	end
end

function HeroStarLevelMediator:closeSleepScheduler()
	if self._sleepScheduler then
		LuaScheduler:getInstance():unschedule(self._sleepScheduler)

		self._sleepScheduler = nil
	end
end

function HeroStarLevelMediator:createLongAddScheduler(time, sender)
	self:closeLongAddScheduler()

	if self._longAddScheduler == nil then
		self._longAddScheduler = LuaScheduler:getInstance():schedule(function()
			self:longAdd(sender)
		end, time, false)
	end
end

function HeroStarLevelMediator:closeLongAddScheduler()
	if self._longAddScheduler then
		LuaScheduler:getInstance():unschedule(self._longAddScheduler)

		self._longAddScheduler = nil
	end
end

function HeroStarLevelMediator:closeAllScheduler()
	self:closeLongAddScheduler()
	self:closeSleepScheduler()
	self:closeProgrScheduler()
end
