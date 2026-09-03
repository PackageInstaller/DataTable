-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tsoul/view/TSoulIntensifyMediator.lua

TSoulIntensifyMediator = class("TSoulIntensifyMediator", DmPopupViewMediator)

TSoulIntensifyMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local Tsoul_EXPGold = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_EXPGold", "content")
local kBtnHandlers = {}
local KAnimNames = {
	{
		"sg_g_s_yingxiangtaozhuangshengji",
		"sg_g_x_yingxiangtaozhuangshengji"
	},
	{
		"sg_g_s_yingxiangtaozhuangshengji",
		"sg_g_x_yingxiangtaozhuangshengji"
	},
	{
		"sg_b_s_yingxiangtaozhuangshengji",
		"sg_b_x_yingxiangtaozhuangshengji"
	},
	{
		"sg_p_s_yingxiangtaozhuangshengji",
		"sg_p_x_yingxiangtaozhuangshengji"
	},
	{
		"sg_o_s_yingxiangtaozhuangshengji",
		"sg_o_x_yingxiangtaozhuangshengji"
	},
	{
		"sg_o_s_yingxiangtaozhuangshengji",
		"sg_o_x_yingxiangtaozhuangshengji"
	}
}
local kNum = 4
local kCellType = {
	kTSoul = "tsoul",
	kTitle = "title",
	kItem = "item"
}

function TSoulIntensifyMediator:initialize()
	super.initialize(self)
end

function TSoulIntensifyMediator:dispose()
	self._selectPanel:release()
	self:closeAllScheduler()
	super.dispose(self)
end

function TSoulIntensifyMediator:userInject()
	self._tSoulSystem = self._developSystem:getTSoulSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()
end

function TSoulIntensifyMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TSOUL_LOCK_SUCC, self, self.onLockSucc)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")

	local bgNode = self:getView():getChildByFullName("main.bg")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("TimeSoul_Intensify_Title"),
		bgSize = {
			width = 1105,
			height = 640
		}
	})
	self:bindWidget("main.Node_right.btn_reset", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickReset, self)
		}
	})
	self:bindWidget("main.Node_right.btn_intensify", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickIntensify, self)
		}
	})

	self._btnIntensify = self._main:getChildByFullName("Node_right.btn_intensify")
	self._btnReset = self._main:getChildByFullName("Node_right.btn_reset")

	local btnSelect = self._main:getChildByFullName("Node_right.Node_select.Panel_6")

	btnSelect:addClickEventListener(function(sender)
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:onQuickBtnSelect(sender)
	end)
end

function TSoulIntensifyMediator:enterWithData(data)
	self._chooseId = data.chooseId
	self._tSoulData = self._tSoulSystem:getTSoulById(self._chooseId)
	self._maxLevel = self._tSoulData:getMaxLevel()

	self:initData()
	self:initWidget()
	self:initTableView()

	local nextExp = self._tSoulSystem:getNextTsoulExp(self._chooseId, self._curLevel)

	self:refreshProgrView(self._curExp, nextExp)
	self:refreshLvlLabel()
	self:tabClickByIndex(self._selectPanel:getChildByName("btn1"), true)
	self:refreshQuickSelect()
	self:refreshAttr()
end

function TSoulIntensifyMediator:initData()
	self._cellsHeight = {}
	self._cellNum = 0
	self._items = self._tSoulSystem:getCostItems()

	local itemsNum = #self._items

	if itemsNum > 0 then
		self._cellNum = self._cellNum + 1
		self._cellsHeight[self._cellNum] = {
			type = kCellType.kTitle,
			str = Strings:get("TimeSoul_Main_SuitUI_06")
		}

		local num = math.ceil(itemsNum / kNum)

		for i = 1, num do
			self._cellNum = self._cellNum + 1
			self._cellsHeight[self._cellNum] = {
				type = kCellType.kItem,
				index = i
			}
		end
	end

	self._tsoulItems = self._tSoulSystem:getTsouItemsForIntensify(self._chooseId)

	local tsoulsNum = #self._tsoulItems

	if tsoulsNum > 0 then
		self._cellNum = self._cellNum + 1
		self._cellsHeight[self._cellNum] = {
			type = kCellType.kTitle,
			str = Strings:get("TimeSoul_Main_SuitUI_07")
		}

		local num = math.ceil(tsoulsNum / kNum)

		for i = 1, num do
			self._cellNum = self._cellNum + 1
			self._cellsHeight[self._cellNum] = {
				type = kCellType.kTSoul,
				index = i
			}
		end
	end

	self._tsoulExp = self._tSoulData:getExp()
	self._tsoulLevel = self._tSoulData:getLevel()
	self._previewProgrState = false
	self._previewProgrTag = 1
	self._curExp = self._tsoulExp
	self._curLevel = self._tsoulLevel
	self._eatExp = 0
	self._addExp = 0
	self._eatOnceExp = 1
	self._seeTime = 10

	self:createNeedExp()
end

function TSoulIntensifyMediator:createNeedExp()
	self._maxExpNeed = self._tSoulSystem:getMaxLevelCost(self._chooseId)
end

function TSoulIntensifyMediator:initWidget()
	self._viewPanel = self._main:getChildByFullName("list_view")
	self._nodeRight = self._main:getChildByFullName("Node_right")
	self._itemClone = self._main:getChildByFullName("itemClone")
	self._tsoulClone = self._main:getChildByFullName("Panel_clone")
	self._titleClone = self._main:getChildByFullName("cloneCell")
	self._progressLabel = self._nodeRight:getChildByFullName("progressLabel")
	self._loadingBar = self._nodeRight:getChildByFullName("LoadingBar_1")

	self._loadingBar:setScale9Enabled(true)
	self._loadingBar:setCapInsets(cc.rect(8, 8, 2, 3))

	self._selectPanel = self._main:getChildByFullName("selectPanel")

	self._selectPanel:retain()

	local buttons = {}

	for i = 1, 2 do
		local button = self._selectPanel:getChildByName("btn" .. i)

		buttons[#buttons + 1] = button

		if i == 1 then
			button.subType = TSoulShowSort.SortByRaretyUp or TSoulShowSort.SortByLevelUp
		end

		button.index = i

		button:addClickEventListener(function(sender)
			self:tabClickByIndex(sender)
		end)
	end

	local imgIcon = self._nodeRight:getChildByFullName("Image_icon")

	imgIcon:ignoreContentAdaptWithSize(true)
	imgIcon:loadTexture(self._tSoulData:getIcon())
	imgIcon:setScale(0.45)

	local nameText = self._nodeRight:getChildByFullName("text_name")

	nameText:setString(self._tSoulData:getName())

	self._curLvText = self._nodeRight:getChildByFullName("textlv")

	self._curLvText:setString(Strings:get("TimeSoul_Change_Sort_3") .. self._tSoulData:getLevel())

	self._animNode = self._nodeRight:getChildByFullName("Node_anim")

	local animName = KAnimNames[self._tSoulData:getRarity()][1]
	local anim = cc.MovieClip:create(animName)

	anim:setName("anim")
	anim:gotoAndStop(1)
	anim:addTo(self._animNode):posite(0, 16)

	local animName = KAnimNames[self._tSoulData:getRarity()][2]
	local anim = cc.MovieClip:create(animName)

	anim:setName("anim1")
	anim:gotoAndStop(1)
	anim:addTo(self._animNode):posite(0, 16)
end

function TSoulIntensifyMediator:initTableView()
	self._cellWidth = self._titleClone:getContentSize().width
	self._cellHeight = self._titleClone:getContentSize().height
	self._itemHeight = self._itemClone:getContentSize().height
	self._tsoulHeight = self._tsoulClone:getContentSize().height + 10

	local function scrollViewDidScroll(view)
		self:closeSleepScheduler()
		self:closeLongAddScheduler()
	end

	local function cellSizeForTable(table, idx)
		local param = self._cellsHeight[idx + 1]

		if param.type == kCellType.kTitle then
			return self._cellWidth, self._cellHeight
		elseif param.type == kCellType.kItem then
			return self._cellWidth, self._itemHeight
		end

		return self._cellWidth, self._tsoulHeight
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

function TSoulIntensifyMediator:createTeamCell(cell, index)
	cell:removeAllChildren()

	local param = self._cellsHeight[index]

	if param.type == kCellType.kTitle then
		local node = self._titleClone:clone()

		node:setVisible(true)
		node:addTo(cell):posite(0, 0)
		node:getChildByFullName("text"):setString(param.str)
		node:getChildByFullName("line"):setVisible(index ~= 1)

		if index ~= 1 then
			self._selectPanel:removeFromParent(false)
			self._selectPanel:addTo(node):posite(310, 0)
		end
	elseif param.type == kCellType.kItem then
		local indexTemp = param.index

		for j = 1, kNum do
			local itemData = self._items[kNum * (indexTemp - 1) + j]

			if itemData then
				local node = self._itemClone:clone()

				node:setVisible(true)
				node:addTo(cell):posite(66 + (j - 1) * 115, 0)

				local itemPanel = node:getChildByFullName("itemNode")
				local item = IconFactory:createItemIcon({
					id = itemData.itemId,
					amount = itemData.allCount
				}, {
					showAmount = false,
					isWidget = true
				})

				item:addTo(itemPanel):center(itemPanel:getContentSize())
				item:setScale(0.83)
				node:setGray(itemData.allCount <= 0)

				local curNum = itemData.eatCount
				local expLabel = node:getChildByFullName("text_add")

				expLabel:setString(Strings:get("HERO_STRENGTH_EXP") .. "+" .. itemData.exp)

				local numLabel = node:getChildByFullName("num")
				local numStr = curNum == 0 and "" or string.format("(%d)", curNum) .. "/"

				numLabel:setString(numStr .. itemData.allCount)

				local amountBg = node:getChildByFullName("amountBg")
				local width = amountBg:getContentSize().width
				local scaleX = (numLabel:getContentSize().width + 16) / width

				amountBg:setScaleX(scaleX)

				local nameLabel = node:getChildByFullName("text_name")
				local name = ConfigReader:getDataByNameIdAndKey("ItemConfig", itemData.itemId, "Name")

				nameLabel:setString(Strings:get(name))
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
				itemPanel.numPanel = numLabel
				itemPanel.minusBtn = minusBtn
				itemPanel.amountBg = amountBg
				minusBtn.data = itemData
				minusBtn.numPanel = numLabel
				minusBtn.minusBtn = minusBtn
				minusBtn.amountBg = amountBg
			end
		end
	elseif param.type == kCellType.kTSoul then
		local indexTemp = index - 3

		for j = 1, kNum do
			local itemData = self._tsoulItems[kNum * (indexTemp - 1) + j]

			if itemData then
				local tsoulInfo = self._tSoulSystem:getTSoulById(itemData.id)
				local node = self._tsoulClone:clone()

				node:setVisible(true)
				node:addTo(cell):posite(16 + (j - 1) * 146, 0)

				local name = node:getChildByFullName("namelabel")
				local lv = node:getChildByFullName("lvlabel")
				local itemPanel = node:getChildByFullName("Image_icon")
				local imgRareity = node:getChildByFullName("Image_13")
				local attrText = node:getChildByFullName("text")
				local attrImage = node:getChildByFullName("image")

				itemPanel:ignoreContentAdaptWithSize(true)
				itemPanel:loadTexture(tsoulInfo:getIcon())
				itemPanel:setScale(0.6)
				name:setString(tsoulInfo:getName())
				lv:setString(Strings:get("TimeSoul_Change_Sort_3") .. tsoulInfo:getLevel())
				imgRareity:loadTexture(KTSoulRareityName[tsoulInfo:getRarity()], 1)

				local bastAttr = tsoulInfo:getBaseAttr()

				attrImage:loadTexture(AttrTypeImage[next(bastAttr)], 1)
				attrText:setString(bastAttr[next(bastAttr)])

				local expLabel = node:getChildByFullName("text_add")

				expLabel:setString(Strings:get("HERO_STRENGTH_EXP") .. "+" .. itemData.exp)

				local numLabel = node:getChildByFullName("num")

				numLabel:setString("")

				local curNum = itemData.eatCount

				itemPanel:setSwallowTouches(false)
				itemPanel:addTouchEventListener(function(sender, eventType)
					if tsoulInfo:getLock() then
						return
					end

					self:onEatItemClicked(sender, eventType, true)
				end)

				local panelLock = node:getChildByFullName("Panel_lock")
				local imgUnLock = node:getChildByFullName("Image_unlock")

				panelLock:setVisible(false)
				imgUnLock:setVisible(false)
				imgRareity:setColor(cc.c3b(255, 255, 255))
				itemPanel:setColor(cc.c3b(255, 255, 255))

				if tsoulInfo:getLock() then
					panelLock:setVisible(true)
					imgRareity:setColor(cc.c3b(131, 131, 131))
					itemPanel:setColor(cc.c3b(131, 131, 131))
				else
					imgUnLock:setVisible(true)
				end

				panelLock:getChildByFullName("Image_33"):addClickEventListener(function()
					self:onClickLock(itemData)
				end)
				imgUnLock:addClickEventListener(function()
					self:onClickLock(itemData)
				end)

				local minusBtn = node:getChildByFullName("minusbtn")

				minusBtn:setVisible(curNum > 0)
				minusBtn:addTouchEventListener(function(sender, eventType)
					if tsoulInfo:getLock() then
						return
					end

					self:onEatItemClicked(sender, eventType, false)
				end)

				itemPanel.data = itemData
				itemPanel.numPanel = numLabel
				itemPanel.minusBtn = minusBtn
				minusBtn.data = itemData
				minusBtn.numPanel = numLabel
				minusBtn.minusBtn = minusBtn
			end
		end
	end
end

function TSoulIntensifyMediator:refreshView()
	self:initData()
	self:closeAllScheduler()
	self:refreshLvlLabel()

	local nextExp = self._tSoulSystem:getNextTsoulExp(self._chooseId, self._curLevel)

	self:refreshProgrView(self._curExp, nextExp)
	self._curLvText:setString(Strings:get("TimeSoul_Change_Sort_3") .. self._tSoulData:getLevel())
	self._tSoulSystem:sortTSoulIntensifyList(self._tsoulItems, self._sortIndex)
	self._tableView:reloadData()
	self:refreshAttr()
end

function TSoulIntensifyMediator:refreshAttr()
	local totalNum = self._tSoulData:getMaxAttrNum() + 1
	local attrs = getTSoulAttNumber(self._tSoulData:getAllAttr())
	local listViewAttr = self._nodeRight:getChildByFullName("listView_attr")

	listViewAttr:setScrollBarEnabled(false)
	listViewAttr:removeAllChildren()

	local attrClone = self:getView():getChildByFullName("cloneCell")
	local cellSize = attrClone:getContentSize()
	local totalElements = #attrs
	local rowCount = math.ceil(totalElements / 2)

	for row = 1, rowCount do
		local rowNode = ccui.Widget:create()

		rowNode:setContentSize(cc.size(listViewAttr:getContentSize().width, cellSize.height))

		for col = 1, 2 do
			local index = (row - 1) * 2 + col

			if totalElements < index then
				break
			end

			local node = attrClone:clone()
			local posX = col == 1 and 10 or 210

			node:setPosition(cc.p(posX, 0))
			rowNode:addChild(node)

			local img = node:getChildByName("image")
			local text = node:getChildByName("text_name")
			local text2 = node:getChildByName("text_value")
			local imgDi = node:getChildByName("Image_70")
			local imgLock = node:getChildByName("Image_lock")

			img:setVisible(false)
			text:setVisible(false)
			text2:setVisible(false)
			imgLock:setVisible(false)

			if attrs[index] then
				if row == 1 and col == 1 then
					if not KTSoulAttrBgState.KNormal then
						local bgState = KTSoulAttrBgState.KKong

						imgDi:loadTexture(KTSoulAttrBgName[bgState], ccui.TextureResType.plistType)
						img:setVisible(true)
						text:setVisible(true)
						text2:setVisible(true)
						img:loadTexture(attrs[index].icon, ccui.TextureResType.plistType)
						text:setString(attrs[index].attrName .. " :   " .. attrs[index].num)
						text2:setString("")
					end
				end
			elseif index <= totalNum then
				imgDi:loadTexture(KTSoulAttrBgName[KTSoulAttrBgState.KKong], ccui.TextureResType.plistType)
			else
				imgLock:setVisible(true)
				imgDi:loadTexture(KTSoulAttrBgName[KTSoulAttrBgState.KLock], ccui.TextureResType.plistType)
			end
		end

		listViewAttr:pushBackCustomItem(rowNode)
	end
end

function TSoulIntensifyMediator:refreshQuickSelect()
	self._quickSelect = self._nodeRight:getChildByFullName("Node_select")

	local data = self._tSoulSystem:getTSoulQuickSelect()

	for i = 1, 5 do
		local node = self._quickSelect:getChildByFullName("Panel_" .. i)
		local imgDi = node:getChildByFullName("Image_109")

		imgDi:loadTexture(tonumber(data[i]) == 1 and "timesoul_btn_fenlei_3.png" or "timesoul_btn_fenlei_1.png", 1)

		node.state = tonumber(data[i])

		node:addClickEventListener(function(sender)
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:onQuickSelect(sender, i)
		end)
	end
end

function TSoulIntensifyMediator:onQuickSelect(sender, i)
	local data = self._tSoulSystem:getTSoulQuickSelect()

	data[i] = sender.state == 1 and 0 or 1

	self._tSoulSystem:setTSoulQuickSelect(data)
	self:refreshQuickSelect()
end

function TSoulIntensifyMediator:onQuickBtnSelect()
	local data = self._tSoulSystem:getTSoulQuickSelect()
	local ret = false

	for k, v in pairs(data) do
		if tonumber(v) == 1 then
			ret = true
		end
	end

	if not ret then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("TimeSoul_Intensify_Tips_1")
		}))

		return
	end

	if self._tSoulData:getLevel() >= self._tSoulData:getMaxLevel() then
		return
	end

	local items, tsoulItems, totalExp = self._tSoulSystem:getQuickItems(self._chooseId, self._tSoulData:getLevel(), self._items, self._tsoulItems)

	self._items = items
	self._tsoulItems = tsoulItems
	self._eatExp = 0
	self._addExp = totalExp

	local ret = self._tSoulSystem:getPreviewLevelAndExp(self._chooseId, self._items, self._tsoulItems)

	self._curLevel = ret.curlv
	self._curExp = ret.curExp

	self:closeAllScheduler()
	self:refreshLvlLabel()

	local nextExp = self._tSoulSystem:getNextTsoulExp(self._chooseId, self._curLevel)

	self:refreshProgrView(self._curExp, nextExp)
	self._curLvText:setString(Strings:get("TimeSoul_Change_Sort_3") .. self._tSoulData:getLevel())
	self._tSoulSystem:sortTSoulIntensifyList(self._tsoulItems, self._sortIndex)
	self._tableView:reloadData()
	self:dispatch(ShowTipEvent({
		tip = Strings:get("TimeSoul_Main_SuitUI_13")
	}))
end

function TSoulIntensifyMediator:onClickClose(sender, eventType)
	self:close()
end

function TSoulIntensifyMediator:refreshRightView()
	local textCost = self._nodeRight:getChildByFullName("text_cost")

	print("====== text_cost   self._addExp self._maxExpNeed " .. self._addExp .. "  " .. self._maxExpNeed)

	local need = math.min(self._addExp, self._maxExpNeed) * Tsoul_EXPGold
	local isenough = need <= self._bagSystem:getItemCount(CurrencyIdKind.kGold)

	textCost:setString(need)
	textCost:setTextColor(isenough and cc.c3b(255, 255, 255) or cc.c3b(255, 0, 0))

	local items, tsoulItems = self:getCostItems()

	self._btnIntensify:setGray(not next(items) and not next(tsoulItems))
	self._btnReset:setGray(not next(items) and not next(tsoulItems))

	local isMax = self._tSoulData:getLevel() == self._tSoulData:getMaxLevel()

	self._btnIntensify:setVisible(not isMax)
	self._btnReset:setVisible(not isMax)

	local textCost = self._nodeRight:getChildByFullName("text_cost")
	local imgCost = self._nodeRight:getChildByFullName("Image_105")

	textCost:setVisible(not isMax)
	imgCost:setVisible(not isMax)
end

function TSoulIntensifyMediator:getCostItems()
	local items = {}

	for i, v in ipairs(self._items) do
		if v.eatCount > 0 then
			items[v.itemId] = v.eatCount
		end
	end

	local printTotalExp = 0
	local printItems = {}
	local tsousItems = {}

	for i, v in ipairs(self._tsoulItems) do
		if v.eatCount > 0 then
			tsousItems[#tsousItems + 1] = v.id
		end
	end

	return items, tsousItems, printItems, printTotalExp
end

function TSoulIntensifyMediator:tabClickByIndex(button, isFirst)
	AudioEngine:getInstance():playEffect("Se_Click_Tab_2", false)

	if isFirst then
		self._sortType = 1
		self._subType = true
	else
		self._subType = self._sortType == button.index and not self._subType or true
	end

	self._sortType = button.index

	for i = 1, 2 do
		local iamge = self._selectPanel:getChildByFullName("btn" .. i .. ".image")
		local text = self._selectPanel:getChildByFullName("btn" .. i .. ".Text_48")
		local arrow = self._selectPanel:getChildByFullName("btn" .. i .. ".Image_8")
		local pic = self._sortType == i and "gg_btn_s_xz.png" or "gg_btn_s_wxz.png"

		text:setTextColor(self._sortType == i and cc.c3b(88, 88, 88) or cc.c3b(255, 246, 255))
		iamge:loadTexture(pic, ccui.TextureResType.plistType)

		if self._sortType == i then
			arrow:setRotation(self._subType and 0 or 180)
		else
			arrow:setRotation(0)
		end
	end

	local sortIndex

	self._sortIndex = self._sortType == 1 and self._subType and TSoulShowSort.SortByRaretyUp or self._sortType == 1 and not self._subType and TSoulShowSort.SortByRaretyDown or self._sortType == 2 and self._subType and TSoulShowSort.SortByLevelUp or TSoulShowSort.SortByLevelDown

	self._tSoulSystem:sortTSoulIntensifyList(self._tsoulItems, self._sortIndex)
	self._tableView:reloadData()
end

function TSoulIntensifyMediator:showResouceView(itemId)
	local param = {
		needNum = 1,
		isNeed = true,
		hasNum = 0,
		hasWipeTip = true,
		itemId = itemId
	}
	local view = self:getInjector():getInstance("sourceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param))
end

function TSoulIntensifyMediator:onLockSucc()
	local tsoulData = self._tSoulSystem:getTSoulById(self._lockData.id)

	if not tsoulData then
		return
	end

	if tsoulData:getLock() then
		self._lockData.eatCount = 0
	end

	if tsoulData:getLock() then
		local var_34_0 = Strings:get("TimeSoul_Success_Lock")

		if not var_34_0 then
			var_34_0 = Strings:get("TimeSoul_Success_Unlock")

			local tip = var_34_0

			self:dispatch(ShowTipEvent({
				tip = tip
			}))
			self:closeAllScheduler()

			local ret = self._tSoulSystem:getPreviewLevelAndExp(self._chooseId, self._items, self._tsoulItems)

			self._curLevel = ret.curlv
			self._curExp = ret.curExp
			self._addExp = ret.addExp

			print("========onLockSucc  self._curLevel =  " .. self._curLevel .. " self._curExp = " .. self._curExp .. " self._addExp " .. self._addExp)
			self:refreshLvlLabel()

			local nextExp = self._tSoulSystem:getNextTsoulExp(self._chooseId, self._curLevel)

			self:refreshProgrView(self._curExp, nextExp)
			self._curLvText:setString(Strings:get("TimeSoul_Change_Sort_3") .. self._tSoulData:getLevel())

			local offy = self._tableView:getContentOffset().y

			self._tableView:reloadData()
			self._tableView:setContentOffset(cc.p(0, offy))
		end
	end
end

function TSoulIntensifyMediator:onClickLock(itemData)
	self._lockData = itemData

	local params = {
		tsoulId = itemData.id
	}

	self._tSoulSystem:requestTSoulLock(params)
end

function TSoulIntensifyMediator:onClickReset(sender, eventType)
	local items, tsoulItems = self:getCostItems()

	if not next(items) and not next(tsoulItems) then
		return
	end

	self:refreshView()
end

function TSoulIntensifyMediator:onClickIntensify(sender, eventType)
	local items, tsoulItems, printItems, printTotalExp = self:getCostItems()

	if not next(items) and not next(tsoulItems) then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("TimeSoul_Main_SuitUI_11")
		}))

		return
	end

	local need = math.min(self._addExp, self._maxExpNeed) * Tsoul_EXPGold
	local isenough = need <= self._bagSystem:getItemCount(CurrencyIdKind.kGold)

	if not isenough then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("TimeSoul_Main_SuitUI_12")
		}))

		return
	end

	local param = {
		tsoulIntensifyId = self._chooseId,
		tsoulIds = tsoulItems,
		items = items
	}

	self._tSoulSystem:requestTSoulIntensify(param, true, function()
		if checkDependInstance(self) then
			local anim = self._animNode:getChildByFullName("anim")

			anim:clearCallbacks()
			anim:gotoAndPlay(1)
			anim:addEndCallback(function(cid, mc)
				anim:gotoAndStop(1)
			end)
			anim:addCallbackAtFrame(15, function()
				self:onIntensifySuc(param)
			end)

			local anim = self._animNode:getChildByFullName("anim1")

			anim:gotoAndPlay(1)
			anim:addEndCallback(function(cid, mc)
				anim:gotoAndStop(1)
			end)
			self:refreshView()
		end
	end)
end

function TSoulIntensifyMediator:onIntensifySuc(params)
	local tSoulId = params.tsoulIntensifyId
	local tSoulData = self._tSoulSystem:getTSoulById(tSoulId)

	if not tSoulData then
		return
	end

	self:dispatch(ShowTipEvent({
		tip = Strings:get("TimeSoul_Main_SuitUI_14")
	}))

	if tSoulData:getLevel() == self._tSoulSystem:getBeforeIntensifyInfo().lv then
		return
	end

	local view = self:getInjector():getInstance("TSoulIntensifySuccView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		tSoulId = tSoulId
	}, nil))
end

function TSoulIntensifyMediator:refreshProgrView(nowExp, endExp)
	print("===== refreshProgrView nowExp =  " .. nowExp .. "  endExp = " .. endExp .. " self._addExp = " .. self._addExp .. " self._curLevel = " .. self._curLevel)

	if self._loadingBar:getTag() ~= nowExp or self._progressLabel:getTag() ~= endExp then
		self._loadingBar:setPercent(nowExp / endExp * 100)
		self._loadingBar:setTag(nowExp)
		self._progressLabel:setString(tostring(nowExp) .. "/" .. tostring(endExp))
		self._progressLabel:setTag(endExp)

		if self._curLevel == self._maxLevel or self._curLevel == self._maxLevel - 1 and self._curExp == endExp then
			self._loadingBar:setPercent(100)
			self._progressLabel:setString(Strings:get("TimeSoul_Main_Suit_4"))
		end
	end

	self:refreshRightView()
end

function TSoulIntensifyMediator:refreshLvlLabel(lv)
	lv = lv or self._curLevel
	lv = math.min(self._maxLevel, lv)
	self._nextlvText = self._nodeRight:getChildByFullName("text_nextlv")

	local arrow = self._nodeRight:getChildByFullName("Image_107")

	arrow:setVisible(false)
	self._nextlvText:setString("")

	if lv > self._tSoulData:getLevel() then
		arrow:setVisible(true)

		local str = lv == self._maxLevel and Strings:get("TimeSoul_Main_Suit_4") or ""

		self._nextlvText:setString(Strings:get("TimeSoul_Change_Sort_3") .. lv .. " " .. str)
	end
end

function TSoulIntensifyMediator:onEatItemClicked(sender, eventType, isAdd)
	if eventType == ccui.TouchEventType.began then
		if sender.data.allCount <= 0 then
			return
		end

		self._touchNode = sender
		self._canTouch = isAdd and self:checkBeginEatCount(sender) or self:checkBeginMinusCount(sender)

		if not self._canTouch then
			return
		end

		self._isAdd = isAdd

		self:closeAllScheduler()
		self:touchBegin(sender)
	elseif eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		if sender.data.allCount <= 0 then
			self:showResouceView(sender.data.itemId)

			return
		end

		self:closeSleepScheduler()
		self:closeLongAddScheduler()

		if not self._canTouch then
			return
		end

		self:touchEnd(sender)
		self:resetTableView()
	elseif eventType == ccui.TouchEventType.canceled then
		self:closeSleepScheduler()
		self:closeLongAddScheduler()
	end
end

function TSoulIntensifyMediator:checkBeginEatCount(sender)
	local data = sender.data
	local lastCount = data.allCount - data.eatCount

	if lastCount == 0 then
		return false
	end

	if self._addExp >= self._maxExpNeed then
		local tip = Strings:get("Hero_Star_UI_Remind1")

		self:dispatch(ShowTipEvent({
			tip = tip
		}))

		return false
	end

	local nextExp = self._tSoulSystem:getNextTsoulExp(self._chooseId, self._curLevel)

	if nextExp <= 0 then
		local tip = Strings:get("Hero_Star_UI_Remind1")

		self:dispatch(ShowTipEvent({
			tip = tip
		}))

		return false
	end

	return true
end

function TSoulIntensifyMediator:checkBeginMinusCount(sender)
	local data = sender.data

	if data.eatCount == 0 then
		return false
	end

	return true
end

function TSoulIntensifyMediator:canEatItem(itemNode, hasTip)
	local data = itemNode.data

	if data.allCount == 0 or data.allCount == data.eatCount then
		return false
	end

	if self._addExp >= self._maxExpNeed then
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

function TSoulIntensifyMediator:canMinusItem(itemNode, hasTip)
	local data = itemNode.data

	if data.eatCount <= 0 and (not hasTip or true) then
		return false
	end

	return true
end

function TSoulIntensifyMediator:touchBegin(sender)
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
	self:createLongAddSch(sender)
end

function TSoulIntensifyMediator:createLongAddSch(sender)
	self:closeSleepScheduler()

	local time = 1

	self:createSleepScheduler(time, sender)
end

function TSoulIntensifyMediator:touchEnd(sender)
	local data = sender.data

	if data.allCount == 0 then
		return
	end

	self:eatOneItem(self._touchNode, false)
end

function TSoulIntensifyMediator:resetTableView()
	return
end

function TSoulIntensifyMediator:touchSleepEnd(sender)
	self:closeSleepScheduler()
	self:createProgrScheduler(sender)
	self:eatOneItem(self._touchNode, true)

	local time = 0.1

	self:createLongAddScheduler(time, sender)
end

function TSoulIntensifyMediator:longAdd(sender)
	local onceAddTime = 1

	for i = 1, onceAddTime do
		local stopAdd = self:eatOneItem(self._touchNode, true)

		if not stopAdd then
			break
		end
	end
end

function TSoulIntensifyMediator:eatOneItem(sender)
	local isAdd = self._isAdd

	if not (isAdd and self:canEatItem(sender, true) or self:canMinusItem(sender, true)) then
		self:closeLongAddScheduler()

		return false
	end

	self:createProgrScheduler(sender)

	local changeNum = isAdd and 1 or -1
	local data = sender.data

	data.eatCount = data.eatCount + changeNum

	if data.eatCount < 0 then
		data.eatCount = 0
	end

	dump(data, "==== data")

	local d = self._tSoulSystem:getTSoulById(data.id)

	if d then
		print("~~~~~~~~~~~~~~~~~~~~~~~ exp level " .. d:getExp() .. "  " .. d:getLevel())
	end

	local changeExp = data.exp

	self._eatExp = self._eatExp + changeExp

	print("=========  self._eatExp =  " .. self._eatExp)

	self._addExp = self._addExp + data.exp * changeNum

	self:refreshEatNode(sender)

	if data.eatCount <= 0 and not isAdd then
		self:progrNormalMinusShow(true, sender)
	end

	return true
end

function TSoulIntensifyMediator:refreshEatNode(sender)
	local data = sender.data
	local numPanel = sender.numPanel
	local minusBtn = sender.minusBtn

	if numPanel and minusBtn then
		local numLabel = numPanel

		if data.noShowNum then
			local count = data.eatCount

			minusBtn:setVisible(count > 0)
			numLabel:setString("")
		else
			local count = data.eatCount

			minusBtn:setVisible(count > 0)

			local numStr = count == 0 and "" or string.format("(%d)", count) .. "/"

			numLabel:setString(numStr .. data.allCount)
		end

		if sender.amountBg then
			local width = sender.amountBg:getContentSize().width
			local scaleX = (numLabel:getContentSize().width + 16) / width

			sender.amountBg:setScaleX(scaleX)
		end
	end
end

function TSoulIntensifyMediator:progrShow(sender)
	if self._previewProgrState then
		if self._isAdd then
			self:progrPreviewShow(sender)
		end
	elseif self._isAdd then
		self:progrNormalShow(false, sender)
	else
		self:progrNormalMinusShow(false, sender)
	end
end

function TSoulIntensifyMediator:checkCanEatItem(sender)
	if self._eatExp <= 0 then
		self:progrNormalShow(true, sender)

		return false
	end

	return true
end

function TSoulIntensifyMediator:checkCanMinusItem(sender)
	local data = sender.data

	if data.eatCount <= 0 then
		self:closeProgrScheduler()

		return false
	end

	local realLvl = self._tSoulData:getLevel()
	local realExp = self._tSoulData:getExp()

	if self._curLevel == realLvl and self._curExp == realExp then
		self:closeProgrScheduler()

		return false
	end

	return true
end

function TSoulIntensifyMediator:refreshEatOnceExp(nextExp)
	self._eatOnceExp = (nextExp - self._curExp) / self._seeTime

	if self._eatOnceExp > self._eatExp then
		self._eatOnceExp = self._eatExp
	end

	self._eatOnceExp = self._eatOnceExp < 1 and 1 or self._eatOnceExp
	self._eatOnceExp = math.modf(self._eatOnceExp)
end

function TSoulIntensifyMediator:refreshMinusOnceExp(nextExp)
	self._minusOnceExp = self._curExp / self._seeTime

	if self._minusOnceExp > self._eatExp then
		self._minusOnceExp = self._eatExp
	end

	self._minusOnceExp = self._minusOnceExp < 1 and 1 or self._minusOnceExp
	self._minusOnceExp = math.modf(self._minusOnceExp)
end

function TSoulIntensifyMediator:progrNormalShow(closeCheck, sender)
	local nextExp = self._tSoulSystem:getNextTsoulExp(self._chooseId, self._curLevel)

	if not closeCheck then
		local canEat = self:checkCanEatItem(sender)

		if not canEat then
			return
		end
	end

	self:refreshEatOnceExp(nextExp)

	local levelUp = false
	local stopSche = false
	local expChange = false

	for i = 1, self._seeTime do
		if self._eatExp <= 0 then
			stopSche = true

			break
		end

		nextExp = self._tSoulSystem:getNextTsoulExp(self._chooseId, self._curLevel)

		if nextExp <= 0 then
			stopSche = true

			break
		end

		if self._addExp >= self._maxExpNeed and self._curLevel >= self._maxLevel then
			stopSche = true

			break
		end

		if nextExp <= self._curExp then
			expChange = true
			self._curLevel = self._curLevel + 1
			self._curExp = 0
			nextExp = self._tSoulSystem:getNextTsoulExp(self._chooseId, self._curLevel)
			self._eatOnceExp = math.modf(nextExp / self._seeTime)
			self._eatOnceExp = self._eatOnceExp < 1 and 1 or self._eatOnceExp
			levelUp = true
			self._previewProgrState = true

			return
		end

		if self._eatOnceExp > self._eatExp then
			self._eatOnceExp = self._eatExp
		end

		self._curExp = self._curExp + self._eatOnceExp
		self._eatExp = self._eatExp - self._eatOnceExp
		expChange = true
	end

	if stopSche then
		self:closeProgrScheduler()
	end

	if levelUp then
		self:refreshLvlLabel()
	end

	if expChange then
		nextExp = self._tSoulSystem:getNextTsoulExp(self._chooseId, self._curLevel)

		self:refreshProgrView(self._curExp, nextExp)
	end

	self:refreshLvlLabel()
end

function TSoulIntensifyMediator:progrNormalMinusShow(closeCheck, sender)
	if not closeCheck then
		local canEat = self:checkCanMinusItem(sender)

		if not canEat then
			return
		end
	end

	local ret = self._tSoulSystem:getPreviewLevelAndExp(self._chooseId, self._items, self._tsoulItems)

	self._curLevel = ret.curlv
	self._curExp = ret.curExp

	local nextExp = self._tSoulSystem:getNextTsoulExp(self._chooseId, self._curLevel)

	self:refreshProgrView(self._curExp, nextExp)
	self:refreshLvlLabel()
	self:closeProgrScheduler()

	self._eatExp = 0
end

function TSoulIntensifyMediator:progrPreviewShow()
	if self._previewProgrTag == 1 then
		local nextExp = self._tSoulSystem:getNextTsoulExp(self._chooseId, self._curLevel - 1)

		self:refreshProgrView(nextExp, nextExp)
		self:refreshLvlLabel(self._curLevel - 1)
	elseif self._previewProgrTag == 2 then
		local nextExp = self._tSoulSystem:getNextTsoulExp(self._chooseId, self._curLevel)

		self:refreshProgrView(0, nextExp)
		self:refreshLvlLabel(self._curLevel)
	elseif self._previewProgrTag == 3 then
		local nextExp = self._tSoulSystem:getNextTsoulExp(self._chooseId, self._curLevel)

		if self._curLevel >= self._maxLevel then
			self._curLevel = self._maxLevel
			nextExp = self._tSoulSystem:getNextTsoulExp(self._chooseId, self._maxLevel)
		end

		self:refreshProgrView(self._curExp, nextExp)
		self:refreshLvlLabel()

		self._previewProgrTag = 1
		self._previewProgrState = false
	end

	self._previewProgrTag = self._previewProgrTag + 1
end

local progrSleepTime = 0.02

function TSoulIntensifyMediator:createProgrScheduler(sender)
	self:closeProgrScheduler()

	if self._progrScheduler == nil then
		self._progrScheduler = LuaScheduler:getInstance():schedule(function()
			self:progrShow(sender)
		end, progrSleepTime, false)
	end
end

function TSoulIntensifyMediator:closeProgrScheduler()
	if self._progrScheduler then
		LuaScheduler:getInstance():unschedule(self._progrScheduler)

		self._progrScheduler = nil
	end
end

function TSoulIntensifyMediator:createSleepScheduler(sender)
	self:closeSleepScheduler()

	if self._sleepScheduler == nil then
		self._sleepScheduler = LuaScheduler:getInstance():schedule(function()
			self:touchSleepEnd(sender)
		end, 1, false)
	end
end

function TSoulIntensifyMediator:closeSleepScheduler()
	if self._sleepScheduler then
		LuaScheduler:getInstance():unschedule(self._sleepScheduler)

		self._sleepScheduler = nil
	end
end

function TSoulIntensifyMediator:createLongAddScheduler(time, sender)
	self:closeLongAddScheduler()

	if self._longAddScheduler == nil then
		self._longAddScheduler = LuaScheduler:getInstance():schedule(function()
			self:longAdd(sender)
		end, time, false)
	end
end

function TSoulIntensifyMediator:closeLongAddScheduler()
	if self._longAddScheduler then
		LuaScheduler:getInstance():unschedule(self._longAddScheduler)

		self._longAddScheduler = nil
	end
end

function TSoulIntensifyMediator:closeAllScheduler()
	self:closeLongAddScheduler()
	self:closeSleepScheduler()
	self:closeProgrScheduler()
end
