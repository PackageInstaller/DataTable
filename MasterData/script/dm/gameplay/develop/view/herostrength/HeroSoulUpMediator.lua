-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroSoulUpMediator.lua

HeroSoulUpMediator = class("HeroSoulUpMediator", DmAreaViewMediator, _M)

HeroSoulUpMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
HeroSoulUpMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {}
local cellTag = 1100

function HeroSoulUpMediator:initialize()
	super.initialize(self)
end

function HeroSoulUpMediator:dispose()
	self._viewClose = true

	self:closeAllScheduler()
	super.dispose(self)
end

function HeroSoulUpMediator:onRemove()
	super.onRemove(self)
end

function HeroSoulUpMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._upBtn = self:bindWidget("main.btnnode.upbtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onUpClick, self)
		}
	})
	self._dimondBtn = self:bindWidget("main.btnnode.dimondupbtn", TwoLevelMainButton, {
		ignoreAddKerning = true,
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onDiamondUpClick, self)
		}
	})
end

function HeroSoulUpMediator:refreshViewBySoulUpByItems(event)
	self:refreshView()
end

function HeroSoulUpMediator:refreshViewBySoulUpByDimond(event)
	self:refreshView()
end

function HeroSoulUpMediator:enterWithData(parentMed, data)
	self._parentMed = parentMed

	self:initNodes()
	self:refreshView(data)
end

function HeroSoulUpMediator:refreshView(data)
	self:refreshData(data)
	self:createNeedExp()
	self:refreshBasicInfo()
	self:refreshLoadingBar()
	self:refresLvlLabel()
	self:refreshCellNum()
	self:refreshTableView()
	self:refreshCost()
	self:createLevelUpIcon()
end

function HeroSoulUpMediator:initData()
	self._lineCount = 4
end

local fadeTime = 0.4

function HeroSoulUpMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._maxLabel = self._mainPanel:getChildByFullName("maxlabel")
	self._emeryBagLabel = self._mainPanel:getChildByFullName("emerybaglabel")
	self._infoNode = self._mainPanel:getChildByFullName("infonode")
	self._costNode = self._mainPanel:getChildByFullName("costnode")
	self._btnNode = self._mainPanel:getChildByFullName("btnnode")

	self._btnNode:setLocalZOrder(999)

	self._cellPanel = self._mainPanel:getChildByFullName("cellpanel")

	self._cellPanel:setVisible(false)

	self._iconClone = self._mainPanel:getChildByFullName("iconclone")

	self._iconClone:setVisible(false)

	self._expLabel = self._infoNode:getChildByFullName("explabel")

	self._expLabel:setLocalZOrder(3)

	self._progbackimg = self._infoNode:getChildByFullName("progbackimg")
	self._preLoadingBar = self._infoNode:getChildByFullName("loadingbar1")

	self._preLoadingBar:setLocalZOrder(2)

	self._curLoadingBar = self._infoNode:getChildByFullName("loadingbar2")

	self._curLoadingBar:setLocalZOrder(1)

	self._previewNode = self._infoNode:getChildByFullName("previewnode")
	self._lvlLabel = self._previewNode:getChildByFullName("levellabel1")
	self._touImg = self._previewNode:getChildByFullName("touimg")
	self._targetLvlLabel = self._previewNode:getChildByFullName("levellabel2")
	self._costNumLabel = self._costNode:getChildByFullName("numlabel")
	self._costIcon = self._costNode:getChildByFullName("iconnode")

	local goldIcon = IconFactory:createPic({
		id = CurrencyIdKind.kGold
	})

	goldIcon:addTo(self._costIcon):center(self._costIcon:getContentSize())
	self._expLabel:enableOutline(cc.c4b(9, 19, 49, 127), 2)
end

function HeroSoulUpMediator:isMaxLimitLevel()
	return self._soulData:getLevel() >= self._soulData:getLimitLevel()
end

function HeroSoulUpMediator:isMaxUpgradeLevel()
	return self._soulData:getLevel() >= self._maxUpgradeLevel
end

function HeroSoulUpMediator:refreshCost()
	local factor = self._soulData:getGoldCost().amount
	local goldCostNum = self._costNum * factor

	if CurrencySystem:checkEnoughGold(self, goldCostNum, nil, {
		tipType = "none"
	}) then
		local var_13_0 = cc.c3b(255, 255, 255)

		if not var_13_0 then
			var_13_0 = GameStyle:getColor(7)

			local color = var_13_0

			self._costNumLabel:setColor(color)
			self._costNumLabel:setString(tostring(goldCostNum))
			self._costIcon:setVisible(goldCostNum ~= 0)
			self._costNumLabel:setVisible(goldCostNum ~= 0)
			self._costIcon:setPositionX(-self._costNumLabel:getContentSize().width - 20)
		end
	end
end

function HeroSoulUpMediator:refreshLoadingBar()
	local nextExp = self._soulData:getNextLevelCost(self._curLevel)
	local precent = self._curExp / nextExp * 100

	self._progbackimg:setVisible(true)
	self._curLoadingBar:setVisible(true)

	if self:isMaxLimitLevel() then
		precent = 100

		self._progbackimg:setVisible(false)
		self._preLoadingBar:setVisible(false)
		self._curLoadingBar:setVisible(false)
	end

	self._preLoadingBar:setPercent(precent)
	self._curLoadingBar:setPercent(precent)
	self:refreshProgrView(self._curExp, nextExp)
end

function HeroSoulUpMediator:createLevelUpIcon()
	local iconPanel = self._infoNode:getChildByFullName("soulpanel")

	iconPanel:getChildByFullName("icon"):loadTexture(self._soulData:getIconId())
	iconPanel:getChildByFullName("icon"):setLocalZOrder(1)
end

function HeroSoulUpMediator:createAddAnimaiton(sender)
	local itemData = sender.data

	if not self._itemMoveTag then
		return
	end

	if self._itemMoveTag then
		self._itemMoveTag = false
	end

	local newIcon = IconFactory:createIcon({
		id = itemData.id
	}, {
		hideAmount = true
	})

	newIcon:addTo(sender, -1):center(sender:getContentSize())

	local viewPosition = newIcon:getParent():convertToWorldSpace(cc.p(newIcon:getPosition()))

	newIcon:changeParent(self:getView(), 1)
	newIcon:setPosition(viewPosition)

	local function stopAction1()
		newIcon:removeFromParent(true)
	end

	local function stopAction()
		local scale1 = cc.ScaleTo:create(0.1, 0.2)
		local callfunc1 = cc.CallFunc:create(stopAction1)
		local sequ1 = cc.Sequence:create(scale1, callfunc1)

		newIcon:runAction(sequ1)
	end

	local time = 0.2
	local moveTo = cc.MoveTo:create(time, cc.p(620, 430))
	local scale = cc.ScaleTo:create(time, 0.5)
	local callfunc = cc.CallFunc:create(stopAction)
	local sequ = cc.Sequence:create(moveTo, callfunc)

	newIcon:runAction(sequ)
	newIcon:runAction(scale)
end

function HeroSoulUpMediator:refreshBasicInfo()
	local isEnmptyBag = #self._itemList == 0
	local isMaxLimitLevel = self:isMaxLimitLevel()
	local nameLabel = self._infoNode:getChildByFullName("namelabel")

	nameLabel:setString(tostring(self._soulData:getName()))
	self._maxLabel:setVisible(isMaxLimitLevel)
	self._emeryBagLabel:setVisible(not isMaxLimitLevel and isEnmptyBag)
	self._expLabel:setVisible(not isMaxLimitLevel and not isEnmptyBag)
	self._upBtn:setVisible(not isMaxLimitLevel and not isEnmptyBag)
	self._dimondBtn:setVisible(not isMaxLimitLevel)
	self._costNode:setVisible(not isMaxLimitLevel and not isEnmptyBag)
end

function HeroSoulUpMediator:refreshData(data)
	data = data or {}
	self._curIndex = data.index or self._curIndex
	self._heroId = data.heroId or self._heroId
	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()
	self._player = self._developSystem:getPlayer()
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._heroPro = PrototypeFactory:getInstance():getHeroPrototype(self._heroId)
	self._soulList = self._heroData:getHeroSoulList():getSoulArray()
	self._soulData = self._soulList[self._curIndex]
	self._maxUpgradeLevel = self._soulData:getUpgradeLevel()
	self._soulLimitLevel = self._soulData:getLimitLevel()
	self._itemList = {}

	if not self:isMaxLimitLevel() then
		self._itemList = self._heroSystem:getSoulItemList()
	end

	self._lineCount = 6
	self._curLevel = self._soulData:getLevel()
	self._curExp = self._soulData:getExp()
	self._isAdd = true
	self._changeExp = 0
	self._addExp = 0
	self._eatOnceExp = 1
	self._previewProgrState = false
	self._previewProgrTag = 1
	self._seeTime = 10
	self._otherExp = 0
	self._costNum = 0
end

function HeroSoulUpMediator:createNeedExp()
	self._maxExpNeed = 0

	for i = self._soulData:getLevel(), self._maxUpgradeLevel - 1 do
		local exp = self._soulData:getNextLevelCost(i)

		self._maxExpNeed = self._maxExpNeed + exp
	end

	self._maxExpNeed = self._maxExpNeed - self._soulData:getExp()
end

function HeroSoulUpMediator:refreshCellNum()
	local hasItemNum = #self._itemList

	self._allCellNum = hasItemNum % self._lineCount == 0 and hasItemNum / self._lineCount or math.modf(hasItemNum / self._lineCount) + 1
end

function HeroSoulUpMediator:refreshTableView(reCreate)
	if reCreate and self._tabelView then
		self._tabelView:removeFromParent(true)

		self._tabelView = nil
	end

	if self._tabelView then
		self._tabelView:reloadData()
	else
		self:createTableView()
	end

	self._tabelView:stopScroll()
end

function HeroSoulUpMediator:createTableView()
	local size_W = self._cellPanel:getContentSize().width
	local size_H = self._cellPanel:getContentSize().height
	local tablePanel = self._mainPanel:getChildByFullName("tablePanel")

	local function cellSizeForTable(table, idx)
		return size_W, size_H
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = self._cellPanel:clone()

			sprite:setTouchEnabled(false)
			sprite:setPosition(cc.p(0, 0))
			sprite:setAnchorPoint(cc.p(0, 0))
			sprite:setVisible(true)
			cell:addChild(sprite, 11, 123)

			local cell_Old = cell:getChildByTag(123)

			self:createCell(cell_Old, idx + 1)
		else
			local cell_Old = cell:getChildByTag(123)

			self:createCell(cell_Old, idx + 1)
		end

		return cell
	end

	local function numberOfCellsInTableView(table)
		return self._allCellNum
	end

	local tableView = cc.TableView:create(tablePanel:getContentSize())

	self._tabelView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(cc.p(0, 0))
	tableView:setPosition(0, 0)
	tableView:setDelegate()
	tablePanel:addChild(tableView, 11)
	self._tabelView:setTag(1241214)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setTouchEnabled(true)
	tableView:reloadData()
end

function HeroSoulUpMediator:createCell(cell, idx)
	local begin = idx * self._lineCount - (self._lineCount - 1)

	for i = 0, self._lineCount - 1 do
		local index = begin + i

		self:createEveryCell(cell, index, i + 1)
	end
end

function HeroSoulUpMediator:createEveryCell(cellParent, indexInBag, indexInCell)
	local cell = cellParent:getChildByTag(indexInCell + cellTag)

	if not cell then
		cell = self._iconClone:clone()

		cell:setVisible(true)
		cell:addTo(cellParent, 10):posite(8 + (indexInCell - 1) * (8 + cell:getContentSize().width), cellParent:getContentSize().height / 2)
		cell:setTag(indexInCell + cellTag)
	end

	local data = self._itemList[indexInBag]

	cell:setVisible(data ~= nil)

	if not data then
		return
	end

	cell.data = data

	cell:setTouchEnabled(false)

	local addBtn = cell:getChildByFullName("addbtn")

	addBtn:addTouchEventListener(function(sender, eventType)
		self:onChangeItem(sender, eventType, true)
	end)

	cell.addBtn = addBtn
	addBtn.data = data

	addBtn:setSwallowTouches(false)
	addBtn:setTouchEnabled(true)
	addBtn:setLocalZOrder(11)

	local minusBtn = cell:getChildByFullName("minusbtn")

	minusBtn:addTouchEventListener(function(sender, eventType)
		self:onChangeItem(sender, eventType, false)
	end)
	minusBtn:setLocalZOrder(11)

	cell.minusBtn = minusBtn
	minusBtn.data = data

	minusBtn:setSwallowTouches(false)

	cell.numLabel = cell:getChildByFullName("numlabel")
	cell.addImg = cell:getChildByFullName("addimg")
	cell.expLabel = cell:getChildByFullName("explabel")

	if cell:getChildByTag(123) then
		cell:removeChildByTag(123, true)
	end

	cell.icon = IconFactory:createIcon({
		id = data.id
	})

	cell.icon:addTo(cell, -1, 123):center(cell:getContentSize())
	cell.icon:setLocalZOrder(-111)
	self:refreshItemNode(cell)
	GameStyle:setGreenCommonEffect(cell:getChildByFullName("explabel"), true)
	cell:getChildByFullName("explabel"):disableEffect(1)
	cell:getChildByFullName("explabel"):enableOutline(cc.c4b(57, 75, 10, 127), 2)
end

function HeroSoulUpMediator:refreshItemNode(parent)
	local data = parent.data

	parent.minusBtn:setVisible(data.eatCount > 0)

	local renderer = parent.numLabel:getVirtualRenderer()

	renderer:setAlignment(2, 1)
	renderer:setDimensions(0, 0)
	parent.numLabel:setString(tostring(data.eatCount) .. "/" .. tostring(data.allCount))

	local width = parent.numLabel:getContentSize().width
	local changeWidth = 93

	if changeWidth < width then
		renderer:setDimensions(changeWidth, 0)
		renderer:setAlignment(2, 1)
		parent.numLabel:setString(tostring(data.eatCount) .. "\n" .. "/" .. tostring(data.allCount))
	end

	parent.expLabel:setString(Strings:get("HeroSoul_UI9", {
		num = data.exp
	}))
end

function HeroSoulUpMediator:getTableViewoffSetY()
	local oldOffset = self._tabelView:getContentOffset()

	return oldOffset.y
end

local progrSleepTime = 0.02

function HeroSoulUpMediator:createProgrScheduler()
	if self._progrScheduler == nil then
		self._progrScheduler = LuaScheduler:getInstance():schedule(function()
			self:progrShow()
		end, progrSleepTime, false)
	end
end

function HeroSoulUpMediator:closeProgrScheduler()
	if self._progrScheduler then
		LuaScheduler:getInstance():unschedule(self._progrScheduler)

		self._progrScheduler = nil
	end
end

local touchSleepTime = 1

function HeroSoulUpMediator:createSleepScheduler()
	self:closeSleepScheduler()

	if self._sleepScheduler == nil then
		self._sleepScheduler = LuaScheduler:getInstance():schedule(function()
			self:touchSleepEnd()
		end, touchSleepTime, false)
	end
end

function HeroSoulUpMediator:closeSleepScheduler()
	if self._sleepScheduler then
		LuaScheduler:getInstance():unschedule(self._sleepScheduler)

		self._sleepScheduler = nil
	end
end

function HeroSoulUpMediator:createLongAddScheduler(time)
	self:closeLongAddScheduler()

	if self._longAddScheduler == nil then
		self._longAddScheduler = LuaScheduler:getInstance():schedule(function()
			self:longAdd()
		end, time, false)
	end
end

function HeroSoulUpMediator:closeLongAddScheduler()
	if self._longAddScheduler then
		LuaScheduler:getInstance():unschedule(self._longAddScheduler)

		self._longAddScheduler = nil
	end
end

function HeroSoulUpMediator:closeAllScheduler()
	self:closeLongAddScheduler()
	self:closeSleepScheduler()
	self:closeProgrScheduler()
end

function HeroSoulUpMediator:touchEnd(sender)
	local data = sender.data

	if data.allCount == 0 then
		return
	end

	self:changeOneItem(self._touchNode)
end

function HeroSoulUpMediator:refresLvlLabel(level)
	level = level or self._curLevel

	local curLevel = self._soulData:getLevel()
	local strId = "Strenghten_Text78"

	self._lvlLabel:setString(Strings:get(strId, {
		level = curLevel
	}))
	self:refreshPreviewView()
end

function HeroSoulUpMediator:refreshPreviewView()
	local isMaxLimit = self._soulData:getLevel() == self._soulLimitLevel
	local factor1 = self._curLevel > self._soulData:getLevel()
	local factor2 = self._curLevel == self._soulData:getLevel() and self._curExp >= self._soulData:getNextLevelCost(self._curLevel)
	local hasLevelUp = factor1 or factor2
	local isShow = not isMaxLimit and hasLevelUp

	self._touImg:setVisible(isShow)
	self._touImg:runAction(cc.RepeatForever:create(FadeAction:create(fadeTime)))
	self._targetLvlLabel:setVisible(isShow)
	self._targetLvlLabel:runAction(cc.RepeatForever:create(FadeAction:create(fadeTime)))
	self._preLoadingBar:setVisible(not isShow)

	if self._targetLvlLabel:isVisible() then
		local strId = "Strenghten_Text78"

		self._targetLvlLabel:setString(Strings:get(strId, {
			level = self._curLevel
		}))
	end

	local descLabel = self._infoNode:getChildByFullName("desclabel")
	local desc1 = self._infoNode:getChildByFullName("desc1")
	local desc2 = self._infoNode:getChildByFullName("desc2")
	local touimg = self._infoNode:getChildByFullName("touimg")
	local typeDesc, value1, value2 = self._soulData:getDescType(self._soulData:getLevel(), self._curLevel)

	descLabel:setString(typeDesc)
	descLabel:setLineSpacing(-5)
	desc1:setPositionX(descLabel:getPositionX() + descLabel:getContentSize().width + 10)
	desc1:setString(value1)
	desc2:setString(value2)
	desc2:setVisible(isShow)
	touimg:setVisible(isShow)
	desc2:runAction(cc.RepeatForever:create(FadeAction:create(fadeTime)))
	touimg:runAction(cc.RepeatForever:create(FadeAction:create(fadeTime)))
end

function HeroSoulUpMediator:refreshProgrView(nowExp, endExp)
	if self._curLoadingBar:getTag() ~= nowExp or self._expLabel:getTag() ~= endExp then
		if endExp == 0 then
			endExp = self._soulData:getNextLevelCost(self._maxUpgradeLevel - 1)
		end

		self._curLoadingBar:setPercent(nowExp / endExp * 100)
		self._curLoadingBar:setTag(nowExp)
		self._expLabel:setString(tostring(nowExp) .. "/" .. tostring(endExp))
		self._expLabel:setTag(endExp)
	end
end

function HeroSoulUpMediator:touchBegin(sender)
	self:createProgrScheduler()
	self:createSleepScheduler()
end

function HeroSoulUpMediator:touchSleepEnd()
	self:closeSleepScheduler()
	self:changeOneItem(self._touchNode)

	local time = self:getSpeedByItemCount(self._touchAddCount)

	self:createLongAddScheduler(time)
end

function HeroSoulUpMediator:changeOneItem(sender)
	local isAdd = self._isAdd

	if not (isAdd == true and self:canEatItem(sender, true) or self:canMinusItem(sender, true)) then
		self:closeLongAddScheduler()

		return false
	end

	self:createProgrScheduler()

	local changeNum = isAdd == true and 1 or -1
	local data = sender.data
	local eatExp = data.exp

	if changeNum == -1 and self._otherExp > 0 then
		eatExp = eatExp - self._otherExp
		self._otherExp = 0
	end

	local factor1 = self._curLevel == self._maxUpgradeLevel - 1
	local factor2 = changeNum == 1
	local upLevelNeedExp = self._soulData:getNextLevelCost(self._curLevel) - self._curExp

	self._costNum = factor2 and factor1 and upLevelNeedExp < eatExp and self._costNum + changeNum * upLevelNeedExp or self._costNum + changeNum * eatExp
	data.eatCount = data.eatCount + changeNum
	self._changeExp = self._changeExp + eatExp
	self._addExp = self._addExp + data.exp * changeNum

	self:refreshItemNode(sender:getParent())
	self:refreshCost()

	if isAdd then
		self:createAddAnimaiton(sender)
	end

	self._touchAddCount = self._touchAddCount + 1

	return true
end

function HeroSoulUpMediator:checkSoulLvlMax(curLvl, curExp)
	local maxLvl = self._maxUpgradeLevel

	if maxLvl == 0 or curLvl == maxLvl then
		return true
	end

	local maxExp = self._soulData:getNextLevelCost(maxLvl - 1)

	if curLvl == maxLvl - 1 and curExp == maxExp then
		return true
	end

	return false
end

function HeroSoulUpMediator:canEatItem(itemNode, hasTip)
	local data = itemNode.data

	if data.allCount <= data.eatCount and (not hasTip or true) then
		return false
	end

	local isMaxLvl = self:checkSoulLvlMax(self._curLevel, self._curExp)

	if isMaxLvl then
		if hasTip then
			self:popLevelLimitTip()
		end

		return false
	end

	if self._addExp >= self._maxExpNeed and (not hasTip or true) then
		return false
	end

	return true
end

function HeroSoulUpMediator:popLevelLimitTip()
	self:dispatch(ShowTipEvent({
		tip = Strings:get("Club_Text158")
	}))
end

function HeroSoulUpMediator:canMinusItem(itemNode, hasTip)
	local data = itemNode.data

	if data.eatCount == 0 and (not hasTip or true) then
		return false
	end

	return true
end

function HeroSoulUpMediator:progrShow()
	if self._previewProgrState then
		if self._isAdd then
			self:progrPreviewAddShow()
		else
			self:progrPreviewMinusShow()
		end
	elseif self._isAdd then
		self:progrNormalAddShow()
	else
		self:progrNormalMinusShow()
	end
end

function HeroSoulUpMediator:longAdd()
	local onceAddTime = self:getCostNumByItemCount(self._touchAddCount)

	for i = 1, onceAddTime do
		local stopAdd = self:changeOneItem(self._touchNode)

		if not stopAdd then
			break
		end
	end
end

function HeroSoulUpMediator:progrPreviewAddShow()
	if self._previewProgrTag == 1 then
		local nextExp = self._soulData:getNextLevelCost(self._curLevel - 1)

		self:refreshProgrView(nextExp, nextExp)
		self:refresLvlLabel(self._curLevel - 1)
	elseif self._previewProgrTag == 2 then
		local nextExp = self._soulData:getNextLevelCost(self._curLevel)

		self:refreshProgrView(0, nextExp)
		self:refresLvlLabel(self._curLevel)
	elseif self._previewProgrTag == 3 then
		local nextExp = self._soulData:getNextLevelCost(self._curLevel)

		self:refreshProgrView(self._curExp, nextExp)
		self:refresLvlLabel(self._curLevel)

		self._previewProgrTag = 1
		self._previewProgrState = false
	end

	self._previewProgrTag = self._previewProgrTag + 1
end

function HeroSoulUpMediator:progrPreviewMinusShow()
	if self._previewProgrTag == 1 then
		local nextExp = self._soulData:getNextLevelCost(self._curLevel + 1)

		self:refreshProgrView(0, nextExp)
		self:refresLvlLabel(self._curLevel + 1)
	elseif self._previewProgrTag == 2 then
		local nextExp = self._soulData:getNextLevelCost(self._curLevel)

		self:refreshProgrView(nextExp, nextExp)
		self:refresLvlLabel(self._curLevel)
	elseif self._previewProgrTag == 3 then
		local nextExp = self._soulData:getNextLevelCost(self._curLevel)

		self:refreshProgrView(self._curExp, nextExp)
		self:refresLvlLabel(self._curLevel)

		self._previewProgrTag = 1
		self._previewProgrState = false
	end

	self._previewProgrTag = self._previewProgrTag + 1
end

function HeroSoulUpMediator:setMinusBtnsEnable(isEnable)
	local allCells = self._tabelView:getContainer():getChildren()

	for _, cell in pairs(allCells) do
		for i = 1, self._lineCount do
			local itemCell = cell:getChildByTag(123):getChildByTag(i + cellTag):getChildByFullName("minusbtn")

			if itemCell and itemCell:isVisible() then
				itemCell:setTouchEnabled(isEnable)
			end
		end
	end
end

function HeroSoulUpMediator:setAddBtnsEnable(isEnable)
	local allCells = self._tabelView:getContainer():getChildren()

	for _, cell in pairs(allCells) do
		for i = 1, self._lineCount do
			local itemCell = cell:getChildByTag(123):getChildByTag(i + cellTag):getChildByFullName("addbtn")

			if itemCell and itemCell:isVisible() then
				itemCell:setTouchEnabled(isEnable)
			end
		end
	end
end

function HeroSoulUpMediator:checkCanEatItem(nextExp)
	if self._changeExp <= 0 then
		-- block empty
	end

	if not nextExp then
		self:closeProgrScheduler()

		return false
	end

	local isMaxLvl = self:checkSoulLvlMax(self._curLevel, self._curExp)

	if isMaxLvl then
		self:closeProgrScheduler()

		return false
	end

	return true
end

function HeroSoulUpMediator:checkCanMinusItem(nextExp)
	if self._changeExp <= 0 then
		-- block empty
	end

	if not nextExp then
		self:closeProgrScheduler()

		return false
	end

	local realLvl = self._soulData:getLevel()
	local realExp = self._soulData:getExp()

	if self._curLevel == realLvl and self._curExp == realExp then
		self:closeProgrScheduler()

		return false
	end

	return true
end

function HeroSoulUpMediator:refreshEatOnceExp(nextExp)
	self._eatOnceExp = (nextExp - self._curExp) / self._seeTime

	if self._eatOnceExp > self._changeExp then
		self._eatOnceExp = self._changeExp
	end

	self._eatOnceExp = self._eatOnceExp < 1 and 1 or self._eatOnceExp
	self._eatOnceExp = math.modf(self._eatOnceExp)
end

function HeroSoulUpMediator:refreshMinusOnceExp(nextExp)
	self._minusOnceExp = self._curExp / self._seeTime

	if self._minusOnceExp > self._changeExp then
		self._minusOnceExp = self._changeExp
	end

	self._minusOnceExp = self._minusOnceExp < 1 and 1 or self._minusOnceExp
	self._minusOnceExp = math.modf(self._minusOnceExp)
end

function HeroSoulUpMediator:progrNormalMinusShow()
	local levelUp = false
	local nextExp = self._soulData:getNextLevelCost(self._curLevel)
	local canEat = self:checkCanMinusItem(nextExp)

	if not canEat then
		self:setAddBtnsEnable(true)

		return
	end

	self:refreshMinusOnceExp(nextExp)

	local stopSche = false
	local expChange = false

	for i = 1, self._seeTime do
		local nextExp = self._soulData:getNextLevelCost(self._curLevel)

		if not nextExp then
			stopSche = true

			break
		end

		if self._changeExp >= 0 then
			self:setAddBtnsEnable(false)
		end

		if self._curExp == 0 and self._curLevel > self._soulData:getLevel() and self._changeExp > 0 then
			local isMaxLvl = self:checkSoulLvlMax(self._curLevel, self._curExp)

			if isMaxLvl then
				self._curLevel = self._maxUpgradeLevel - 1
				stopSche = true

				break
			end

			expChange = true
			self._curLevel = self._curLevel - 1

			local nextExp = self._soulData:getNextLevelCost(self._curLevel)

			self._curExp = nextExp
			self._minusOnceExp = math.modf(nextExp / self._seeTime)
			self._minusOnceExp = self._minusOnceExp < 1 and 1 or self._minusOnceExp
			levelUp = true
			self._previewProgrState = true

			return
		end

		if self._minusOnceExp > self._changeExp then
			self._minusOnceExp = self._changeExp
		end

		if self._changeExp <= 0 then
			stopSche = true
			expChange = true

			break
		end

		if self._changeExp >= self._minusOnceExp then
			self._curExp = self._curExp - self._minusOnceExp
			self._changeExp = self._changeExp - self._minusOnceExp

			local isMaxLvl = self:checkSoulLvlMax(self._curLevel, self._curExp)

			if isMaxLvl then
				self._curLevel = self._maxUpgradeLevel - 1
				levelUp = true
			end
		end

		expChange = true
	end

	if stopSche then
		self:closeProgrScheduler()
		self:setAddBtnsEnable(true)
	end

	if expChange then
		local nextExp = self._soulData:getNextLevelCost(self._curLevel)

		self:refreshProgrView(self._curExp, nextExp)
	end

	if levelUp then
		self:refresLvlLabel()
	end
end

function HeroSoulUpMediator:progrNormalAddShow()
	local nextExp = self._soulData:getNextLevelCost(self._curLevel)
	local canEat = self:checkCanEatItem(nextExp)

	if not canEat then
		self:setMinusBtnsEnable(true)

		return
	end

	self:refreshEatOnceExp(nextExp)

	local levelUp = false
	local stopSche = false
	local expChange = false

	for i = 1, self._seeTime do
		local nextExp = self._soulData:getNextLevelCost(self._curLevel)

		if not nextExp then
			stopSche = true

			break
		end

		if self._changeExp >= 0 then
			self:setMinusBtnsEnable(false)
		end

		if nextExp <= self._curExp then
			expChange = true

			local isMaxLvl = self:checkSoulLvlMax(self._curLevel, self._curExp)

			if isMaxLvl then
				stopSche = true
				self._curLevel = self._maxUpgradeLevel

				break
			end

			self._curLevel = self._curLevel + 1
			self._curExp = 0

			local nextExp = self._soulData:getNextLevelCost(self._curLevel)

			self._eatOnceExp = math.modf(nextExp / self._seeTime)
			self._eatOnceExp = self._eatOnceExp < 1 and 1 or self._eatOnceExp
			levelUp = true
			self._previewProgrState = true

			return
		end

		if self._changeExp <= 0 then
			stopSche = true
			expChange = true

			break
		end

		if self._eatOnceExp > self._changeExp then
			self._eatOnceExp = self._changeExp
		end

		if self._changeExp >= self._eatOnceExp then
			self._curExp = self._curExp + self._eatOnceExp
			self._changeExp = self._changeExp - self._eatOnceExp
		end

		local isMaxLvl = self:checkSoulLvlMax(self._curLevel, self._curExp)

		if isMaxLvl and self._otherExp == 0 then
			self._otherExp = self._changeExp
		end

		expChange = true
	end

	if stopSche then
		self:closeProgrScheduler()
		self:setMinusBtnsEnable(true)
	end

	if expChange then
		local nextExp = self._soulData:getNextLevelCost(self._curLevel)

		self:refreshProgrView(self._curExp, nextExp)
	end

	if (self._curLevel == self._maxUpgradeLevel and self._curExp == nextExp or nil) and true then
		self:refresLvlLabel()
	end
end

function HeroSoulUpMediator:getSpeedByItemCount(count)
	local data = ConfigReader:getRecordById("ExpConsume", "Soul_Consume")

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

function HeroSoulUpMediator:getCostNumByItemCount(count)
	local data = ConfigReader:getRecordById("ExpConsume", "Soul_Consume")

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

function HeroSoulUpMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end

function HeroSoulUpMediator:onDiamondUpClick(sender, eventType)
	if self._soulData:getLevel() >= self._maxUpgradeLevel then
		self:popLevelLimitTip()

		return
	end

	local view = self:getInjector():getInstance("HeroSoulDimondUpTipView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		heroId = self._heroId,
		index = self._curIndex
	}))
end

function HeroSoulUpMediator:onUpClick(sender, eventType)
	if self._soulData:getLevel() >= self._maxUpgradeLevel then
		self:popLevelLimitTip()

		return
	end

	if self._costNum <= 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("HeroSoul_Tip5")
		}))

		return
	end

	if not self._bagSystem:checkCostEnough(CurrencyIdKind.kGold, self._costNum, {
		type = "tip"
	}) then
		return
	end

	local items = {}

	for i = 1, #self._itemList do
		local itemData = self._itemList[i]

		if itemData.eatCount > 0 then
			items[#items + 1] = {
				itemId = itemData.id,
				amount = itemData.eatCount
			}
		end
	end

	self._heroSystem:requestSoulUpByItem(self._heroId, self._soulData:getId(), items)
end

function HeroSoulUpMediator:onChangeItem(sender, eventType, isAdd)
	if eventType == ccui.TouchEventType.began then
		self._itemMoveTag = true
		self._offSetY = self:getTableViewoffSetY()
		self._touchAddCount = 0
		self._canTouch = true

		local changeExp = self._changeExp

		if not isAdd and self._otherExp > 0 then
			changeExp = changeExp - self._otherExp
			self._changeExp = 0
		end

		if changeExp ~= 0 and self._isAdd ~= isAdd then
			self._canTouch = false

			return
		end

		self._isAdd = isAdd
		self._touchNode = sender

		self:closeSleepScheduler()
		self:closeLongAddScheduler()
		self:touchBegin(sender)
	elseif eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		if not self._canTouch then
			return
		end

		self:closeSleepScheduler()
		self:closeLongAddScheduler()

		if math.abs(self._offSetY - self:getTableViewoffSetY()) > 1 then
			return
		end

		self:touchEnd(sender)
	elseif eventType == ccui.TouchEventType.canceled then
		if not self._canTouch then
			return
		end

		self:closeSleepScheduler()
		self:closeLongAddScheduler()
	elseif eventType == ccui.TouchEventType.moved then
		if not self._canTouch then
			return
		end

		if math.abs(self._offSetY - self:getTableViewoffSetY()) > 2 then
			self:closeSleepScheduler()
			self:closeLongAddScheduler()
		end
	end
end
