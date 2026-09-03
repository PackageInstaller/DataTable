-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroEatItemView.lua

HeroEatItemView = class("HeroEatItemView", DisposableObject, _M)

HeroEatItemView:has("_view", {
	is = "r"
})
HeroEatItemView:has("_info", {
	is = "r"
})
HeroEatItemView:has("_mediator", {
	is = "r"
})

local componentPath = "asset/ui/StrengthenEatItem.csb"
local itemCount = 4

function HeroEatItemView:initialize(info)
	self._info = info
	self._mediator = info.mediator
	self._developSystem = self._mediator:getInjector():getInstance("DevelopSystem")
	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._firstIn = true

	self:refreshData(info.heroId)
	self:createView(info)
	self:createItemData()
	self:createItemPanel()
	self:refreshGoldCost()
	super.initialize(self)
end

function HeroEatItemView:refreshData(heroId)
	self._heroId = heroId
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._showAnim = false
	self._showLevel = self._showLevel or self._heroData:getLevel()

	if self._showLevel == self._heroData:getLevel() then
		self._attrArr = {
			a = self._heroData:getAttack(),
			b = self._heroData:getDefense(),
			c = self._heroData:getHp(),
			combat = self._heroData:getSceneCombatByType(SceneCombatsType.kAll)
		}
	end

	self._addAnimNum = {}
	self._soundId = nil
	self._soundId1 = nil
	self._soundEffectTime = 0
	self._isAdd = true
	self._otherExp = 0
	self._itemMap = {}
	self._maxLevel = self._heroData:getCurMaxLevel()
end

function HeroEatItemView:dispose()
	self._closeView = true

	self:closeAllScheduler()
	super.dispose(self)
end

function HeroEatItemView:refreshItemView()
	self:createItemData()
	self:refreshItemPanel()
end

function HeroEatItemView:refreshView(heroId, ignoreCleanCache)
	self:refreshData(heroId)
	self:closeAllScheduler()
	self:refreshLvlLabel()
	self:createItemData()
	self:refreshGoldCost(false, ignoreCleanCache)
	self:refreshItemPanel()

	local nextExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._curLevel)

	self:refreshProgrView(self._curExp, nextExp)

	if self._heroSystem:isHeroExpMax(self._heroId) then
		-- block empty
	end
end

function HeroEatItemView:createView(info)
	self._view = info.mainNode or cc.CSLoader:createNode(componentPath)
	self._touchLayer = self._view:getChildByName("touchLayer")
	self._showPanel = self._view:getChildByFullName("showpanel")

	self._touchLayer:setVisible(false)

	self._text = self._showPanel:getChildByFullName("text")
	self._mainPanel = self._showPanel:getChildByFullName("eatpanel")

	self._mainPanel:setSwallowTouches(false)

	self._clonePanel = self._mainPanel:getChildByFullName("itempanel")

	self._clonePanel:setVisible(false)

	self._gotoBtn = self._showPanel:getChildByFullName("gotoBtn")

	self._gotoBtn:addClickEventListener(function()
		self._mediator:onClickedGoto()
	end)
	self._showPanel:getChildByFullName("gotoBtn.name1"):setString("")
	self._showPanel:getChildByFullName("upBtn.panel.name1"):setString("")

	self._upBtn = self._showPanel:getChildByFullName("upBtn")

	self._upBtn:addClickEventListener(function()
		self:onClickLevelUp()
	end)
	self:showCustomAnim()

	self._infoPanel = self._showPanel:getChildByFullName("infoPanel")

	local gold = self._upBtn:getChildByFullName("panel.goldimg")

	gold:removeAllChildren()

	local icon = IconFactory:createResourcePic({
		scaleRatio = 1.2,
		id = CurrencyIdKind.kGold
	})

	icon:addTo(gold):center(gold:getContentSize())

	self._expBg = self._infoPanel:getChildByFullName("expBg")
	self._progrLabel = self._infoPanel:getChildByFullName("loadinglabel")

	GameStyle:setCommonOutlineEffect(self._progrLabel)

	local nameString = self._heroData:getName()
	local nameLabel = self._infoPanel:getChildByFullName("nameLabel")

	nameLabel:setString(nameString)
	GameStyle:setCommonOutlineEffect(nameLabel, 219.29999999999998, 2)

	local lvLabel = self._infoPanel:getChildByFullName("lvLabel")

	GameStyle:setCommonOutlineEffect(lvLabel)

	local level1 = self._infoPanel:getChildByFullName("level_1")

	GameStyle:setCommonOutlineEffect(level1)

	for i = 1, 4 do
		local node = self._infoPanel:getChildByName("des_" .. i)
		local text = node:getChildByFullName("text")

		GameStyle:setCommonOutlineEffect(text)
	end

	local heroNode = self._showPanel:getChildByFullName("heroNode")

	heroNode:getChildByFullName("bg1"):setLocalZOrder(2)
	heroNode:getChildByFullName("bg2"):setLocalZOrder(3)

	local node = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe8",
		id = self._heroData:getModel()
	})

	node:addTo(heroNode):center(heroNode:getContentSize())
	node:setLocalZOrder(1)

	local barImage = cc.Sprite:createWithSpriteFrameName("yinghun_lg.png")

	self._progrLoading = cc.ProgressTimer:create(barImage)

	self._progrLoading:setType(0)
	self._progrLoading:setReverseDirection(false)
	self._progrLoading:setAnchorPoint(cc.p(0.5, 0.5))
	self._progrLoading:setMidpoint(cc.p(0.5, 0.5))
	self._progrLoading:addTo(heroNode)
	self._progrLoading:setPosition(cc.p(89, 85))
	self._progrLoading:setLocalZOrder(4)
end

function HeroEatItemView:createItemData()
	local sortItemArr = self._heroSystem:getCostItemMap()
	local pos = 1

	for i = 1, #sortItemArr do
		local itemId = sortItemArr[i]
		local entry = self._bagSystem:getEntryById(itemId)
		local data = {}

		data.itemId = itemId

		local prototype = ItemPrototype:new(itemId)
		local item = Item:new(prototype)

		data.exp = item:getReward()[1].amount
		data.index = i
		data.eatCount = 0
		data.allCount = (entry and entry.count > 0 or nil) and entry.count
		self._itemMap[pos] = data
		pos = pos + 1
	end

	self._previewProgrState = false
	self._previewProgrTag = 1
	self._curExp = self._heroData:getExp()
	self._curLevel = self._heroData:getLevel()
	self._eatExp = 0
	self._addExp = 0
	self._eatOnceExp = 1
	self._seeTime = 10

	self:createNeedExp()
end

function HeroEatItemView:onClickedGotoForEnengy()
	self._developSystem:requstNotEnoughItem("HERO_LV", CurrencyIdKind.kGold)

	local view = self._mediator:getInjector():getInstance("NewCurrencyBuyPopView")

	self._mediator:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		_currencyType = CurrencyType.kExp
	}))
end

function HeroEatItemView:createNeedExp()
	self._maxExpNeed = 0

	for i = self._heroData:getLevel(), self._maxLevel do
		local addExp = self._heroSystem:getNextLvlAddExp(self._heroId, i)

		self._maxExpNeed = self._maxExpNeed + addExp
	end

	self._maxExpNeed = self._maxExpNeed - self._heroData:getExp()
end

function HeroEatItemView:refreshItemPanel()
	for i = 1, #self._itemNodes do
		local panel = self._itemNodes[i]

		if panel then
			self:refreshItemNode(panel, i)
		end
	end
end

function HeroEatItemView:createItemPanel()
	self._itemNodes = {}

	for i = 1, itemCount do
		if self._itemMap[i] then
			local node = self._clonePanel:clone()
			local minusPanel = node:getChildByFullName("minusPanel")
			local minusBtn = minusPanel:getChildByFullName("minusbtn")

			minusPanel:setLocalZOrder(11)
			minusBtn:setSwallowTouches(true)
			minusPanel:setVisible(false)

			node.minusBtn = minusBtn
			node.minusBtn.minusPanel = minusPanel
			node.minusPanel = minusPanel

			node:setTouchEnabled(true)

			node.index = i

			self:refreshItemNode(node, i)
			node:setTag(i)
			minusBtn:addTouchEventListener(function(sender, eventType)
				self:onEatItemClicked(sender, eventType, false)
			end)
			node:addTouchEventListener(function(sender, eventType)
				self:onEatItemClicked(sender, eventType, true)
			end)

			self._itemNodes[#self._itemNodes + 1] = node
		end
	end

	local nextExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._curLevel)

	self:refreshProgrView(self._heroData:getExp(), nextExp)

	if self._heroSystem:isHeroExpMax(self._heroId) then
		-- block empty
	end

	self:refreshLvlLabel()
end

function HeroEatItemView:refreshExpBg()
	local width = self._progrLabel:getContentSize().width + 25

	self._expBg:setContentSize(cc.size(width, 29))
end

local expConfig = ConfigReader:getRecordById("ConfigValue", "Hero_BuyExp_LevelRequest").content

function HeroEatItemView:createItemAddTipIcon(node, needAdd)
	local addImgTag = 23424

	node:removeChildByTag(addImgTag, true)

	local isLevelEngouh = self._developSystem:getLevel() >= expConfig[tostring(node.itemId)]

	if needAdd and isLevelEngouh then
		local addImg = cc.Sprite:createWithSpriteFrameName(IconFactory.itemAddTipPath)

		node:addChild(addImg, 2)
		addImg:setPosition(cc.p(45, 45))
		addImg:setTag(addImgTag)
	end
end

function HeroEatItemView:refreshItemNode(node, pos)
	local data = self._itemMap[pos]

	node.data = data
	node.minusBtn.data = data

	if not node.icon then
		local info = {
			scaleRatio = 0.7,
			id = data.itemId,
			amount = data.allCount
		}

		node.itemId = data.itemId
		node.icon = IconFactory:createEatItemIcon(info, {
			hasTip = true
		})
		node.minusBtn.icon = node.icon
		node.itemAnim = cc.MovieClip:create("daoju_yinghunshengji")

		node.itemAnim:addCallbackAtFrame(30, function()
			node.itemAnim:stop()
		end)

		local itemNode = node.itemAnim:getChildByName("itemNode")

		itemNode:removeAllChildren()
		itemNode:addChild(node.icon)
		node.itemAnim:gotoAndStop(30)
		node:addChild(node.itemAnim)
		node.icon:setPosition(0, 5)
		node.itemAnim:setPosition(45, 43)

		local posNode = self._mainPanel:getChildByFullName("node" .. pos)

		node:setAnchorPoint(cc.p(0.5, 0.5))
		node:setPosition(cc.p(0, 0))
		node:setVisible(true)
		posNode:addChild(node)
	end

	node.icon:setAmount(data.allCount)

	node.icon.itemId = data.itemId
	node.minusBtn.icon.itemId = data.itemId

	node.minusBtn.minusPanel:setVisible(false)
	node.icon:setLocalZOrder(1)

	local textBg = node:getChildByFullName("text_bg")

	textBg:setLocalZOrder(2)

	local bg = textBg:getChildByFullName("textBg")
	local expLabel = textBg:getChildByFullName("deslabel")
	local expText = textBg:getChildByFullName("exp")

	if not expLabel.hasInit then
		expLabel:setString("+" .. data.exp)

		expLabel.hasInit = true
	end

	expLabel:setPositionX(expText:getContentSize().width)

	local width = expLabel:getContentSize().width + expText:getContentSize().width

	textBg:setContentSize(cc.size(width, 30))
	textBg:setPositionX(node:getContentSize().width / 2)
	bg:setContentSize(cc.size(width + 28, 44))
	bg:setPositionX(textBg:getContentSize().width / 2 - 8)

	local count = data.eatCount

	if count > 0 then
		node.icon:setAmount(data.allCount - count)
		node.minusBtn.minusPanel:setVisible(count > 0)

		local label = node.minusBtn.minusPanel:getChildByName("num")

		label:setString(count)
		node.minusBtn.minusPanel:getChildByName("image"):setContentSize(cc.size(label:getContentSize().width + 40, 35))
	end
end

function HeroEatItemView:refreshProgrView(nowExp, endExp)
	if self._progrLoading:getTag() ~= nowExp or self._progrLabel:getTag() ~= endExp then
		self._progrLoading:setPercentage(nowExp / endExp * 100)
		self._progrLoading:setTag(nowExp)
		self._progrLabel:setString(nowExp .. "/" .. endExp)
		self._progrLabel:setTag(endExp)
		self._progrLabel:setTextColor(cc.c3b(255, 255, 255))
		self:refreshExpBg()
	end

	if endExp <= nowExp and self._addExp > self._maxExpNeed then
		self._progrLabel:setString(self._addExp - self._maxExpNeed + nowExp .. "/" .. endExp)
		self._progrLabel:setTextColor(cc.c3b(0, 255, 0))
		self:refreshExpBg()
	end
end

function HeroEatItemView:refreshEatData()
	self._eatSpeedMap = {}

	local list = ConfigReader:getRecordById("ExpConsume", tostring(self._selectItemId)).ExpConsumeRate

	for i = 1, #list do
		self._eatSpeedMap[list[i]] = true
	end
end

function HeroEatItemView:checkBeginEatCount(sender, isAdd)
	if self._heroSystem:isHeroExpMax(self._heroId) then
		if isAdd then
			local tip = Strings:get("Heros_Tips_ExpFull")

			self._mediator:dispatch(ShowTipEvent({
				tip = (self._heroData:getNextQualityId() == "" or nil) and Strings:get("Heros_Tips_LevelFull")
			}))
		end

		return
	end

	local data = sender.data
	local itemId = tostring(data.itemId)
	local lastCount = data.allCount - data.eatCount

	if lastCount == 0 then
		if isAdd and not self._upBtn:isVisible() then
			local buyEatItemTipView = self._mediator:getInjector():getInstance("BuyEatItemTipView")

			self._mediator:dispatch(ViewEvent:new(EVT_SHOW_POPUP, buyEatItemTipView, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				itemId = itemId
			}, nil))
		end

		if self._developSystem:getLevel() < expConfig[itemId] then
			return false
		end

		return false
	end

	return true
end

function HeroEatItemView:checkBeginMinusCount(sender)
	local data = sender.data

	if data.eatCount == 0 then
		return false
	end

	return true
end

function HeroEatItemView:canEatItem(itemNode, hasTip)
	local data = itemNode.data

	if data.allCount == 0 or data.allCount == data.eatCount then
		if hasTip then
			self._mediator:dispatch(ShowTipEvent({
				tip = Strings:get("Tips_3010003")
			}))
		end

		return false
	end

	if self._addExp >= self._maxExpNeed then
		if hasTip and self._curLevel >= self._maxLevel then
			local tip = Strings:get("Heros_Tips_ExpFull")

			self._mediator:dispatch(ShowTipEvent({
				tip = (self._heroData:getNextQualityId() == "" or nil) and Strings:get("Heros_Tips_LevelFull")
			}))
		end

		return false
	end

	return true
end

function HeroEatItemView:canMinusItem(itemNode, hasTip)
	local data = itemNode.data

	if data.eatCount <= 0 then
		return false
	end

	return true
end

function HeroEatItemView:touchBegin(sender)
	if self._isAdd then
		local canAdd = self:canEatItem(sender, true)

		if not canAdd then
			self:closeLongAddScheduler()

			return false
		end

		sender.itemAnim:gotoAndPlay(0)
	else
		local canMinus = self:canMinusItem(sender, true)

		if not canMinus then
			return
		end
	end

	self:createProgrScheduler(sender)
	self:createLongAddSch(sender)
end

function HeroEatItemView:createLongAddSch(sender)
	self:closeSleepScheduler()

	local time = 1

	self:createSleepScheduler(time, sender)
end

function HeroEatItemView:touchEnd(sender)
	self:eatOneItem(self._touchNode, false)
	self:refreshGoldCost()
end

function HeroEatItemView:touchSleepEnd(sender)
	self:closeSleepScheduler()
	self:createProgrScheduler(sender)
	self:eatOneItem(self._touchNode, true)

	local time = self._heroSystem:getSpeedByItemCount(self._selectItemId, self._touchAddCount)

	self:createLongAddScheduler(time)
end

function HeroEatItemView:longAdd()
	local onceAddTime = self._heroSystem:getCostNumByItemCount(self._selectItemId, self._touchAddCount)

	for i = 1, onceAddTime do
		local stopAdd = self:eatOneItem(self._touchNode, true)

		if not stopAdd then
			break
		elseif self._eatSpeedMap[self._touchAddCount] then
			self:createLongAddScheduler()

			break
		end
	end
end

function HeroEatItemView:eatOneItem(sender, hasTip)
	local isAdd = self._isAdd

	if not (isAdd and self:canEatItem(sender, true) or self:canMinusItem(sender, true)) then
		self:closeLongAddScheduler()

		return false
	end

	local changeNum = isAdd and 1 or -1
	local data = sender.data

	data.eatCount = data.eatCount + changeNum

	if data.eatCount < 0 then
		data.eatCount = 0
	end

	self._touchAddCount = self._touchAddCount + 1

	local changeExp = data.exp

	if changeNum == -1 and self._otherExp > 0 then
		changeExp = changeExp - self._otherExp
		self._otherExp = 0
	end

	if self._addExp + data.exp >= self._maxExpNeed then
		changeExp = self._maxExpNeed - self._addExp
	end

	self._eatExp = self._eatExp + changeExp
	self._addExp = self._addExp + data.exp * changeNum

	self:refreshEatNode(sender)

	return true
end

function HeroEatItemView:refreshEatNode(sender)
	local data = sender.data
	local itemIcon = sender.icon
	local minusPanel = sender.minusPanel

	itemIcon:setAmount(data.allCount - data.eatCount)

	if minusPanel then
		local count = data.eatCount

		minusPanel:setVisible(count > 0)

		local label = minusPanel:getChildByName("num")

		label:setString(count)
		minusPanel:getChildByName("image"):setContentSize(cc.size(label:getContentSize().width + 40, 35))
	end
end

function HeroEatItemView:progrShow(sender)
	if self._previewProgrState then
		if self._isAdd then
			self:progrPreviewShow(sender)
		else
			self:progrPreviewMinusShow(sender)
		end
	elseif self._isAdd then
		self:progrNormalShow(false, sender)
	else
		self:progrNormalMinusShow(false, sender)
	end
end

function HeroEatItemView:checkCanEatItem(nextExp, sender)
	if self._eatExp <= 0 then
		self:progrNormalShow(true, sender)

		return false
	end

	if not nextExp then
		self:closeProgrScheduler()

		return false
	end

	return true
end

function HeroEatItemView:checkCanMinusItem(nextExp, sender)
	if self._eatExp <= 0 then
		-- block empty
	end

	local data = sender.data

	if data.eatCount <= 0 then
		self:closeProgrScheduler()

		return false
	end

	if not nextExp then
		self:closeProgrScheduler()

		return false
	end

	local realLvl = self._heroData:getLevel()
	local realExp = self._heroData:getExp()

	if self._curLevel == realLvl and self._curExp == realExp then
		self:closeProgrScheduler()

		return false
	end

	return true
end

function HeroEatItemView:refreshEatOnceExp(nextExp)
	self._eatOnceExp = (nextExp - self._curExp) / self._seeTime

	if self._eatOnceExp > self._eatExp then
		self._eatOnceExp = self._eatExp
	end

	self._eatOnceExp = self._eatOnceExp < 1 and 1 or self._eatOnceExp
	self._eatOnceExp = math.modf(self._eatOnceExp)
end

function HeroEatItemView:refreshMinusOnceExp(nextExp)
	self._minusOnceExp = self._curExp / self._seeTime

	if self._minusOnceExp > self._eatExp then
		self._minusOnceExp = self._eatExp
	end

	self._minusOnceExp = self._minusOnceExp < 1 and 1 or self._minusOnceExp
	self._minusOnceExp = math.modf(self._minusOnceExp)
end

function HeroEatItemView:progrNormalShow(closeCheck, sender)
	local nextExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._curLevel)

	if not closeCheck then
		local canEat = self:checkCanEatItem(nextExp, sender)

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
			break
		end

		local nextExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._curLevel)

		if not nextExp then
			stopSche = true

			break
		end

		if nextExp <= self._curExp then
			expChange = true
			self._curLevel = self._curLevel + 1
			self._curExp = 0

			local nextExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._curLevel)

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

		if self._curLevel >= self._maxLevel then
			self._curLevel = self._maxLevel
			expChange = true
			levelUp = true

			if self._otherExp == 0 then
				self._otherExp = self._eatExp
			end

			if nextExp <= self._curExp then
				stopSche = true
			end
		end

		expChange = true
	end

	if levelUp then
		self:refreshLvlLabel()
	end

	if stopSche then
		self:closeProgrScheduler()
	end

	if expChange then
		local nextExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._curLevel)

		self:refreshProgrView(self._curExp, nextExp)
		self:refreshLevelAndProgress(nextExp)
	else
		local data = sender.data
		local itemId = tostring(data.itemId)

		if self._developSystem:getLevel() <= expConfig[itemId] then
			return
		end

		self:refreshLevelAndProgress(nextExp)
	end
end

function HeroEatItemView:refreshLevelAndProgress(nextExp)
	if self._curLevel > self._maxLevel then
		self._curLevel = self._maxLevel
		self._curExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._maxLevel)
	elseif self._curLevel == self._maxLevel and nextExp <= self._curExp then
		self._curLevel = self._maxLevel
		self._curExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._maxLevel)
	elseif self._curExp == nextExp then
		self._curExp = 0
		self._curLevel = self._curLevel + 1
	end

	self:refreshProgrView(self._curExp, nextExp)
	self:refreshLvlLabel(self._curLevel)

	if self._heroSystem:isHeroExpMax(self._heroId, self._curLevel, self._curExp) then
		-- block empty
	end
end

function HeroEatItemView:progrNormalMinusShow(closeCheck, sender)
	local levelUp = false
	local nextExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._curLevel)

	if not closeCheck then
		local canEat = self:checkCanMinusItem(nextExp, sender)

		if not canEat then
			return
		end
	end

	self:refreshMinusOnceExp(nextExp)

	local stopSche = false
	local expChange = false

	for i = 1, self._seeTime do
		local nextExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._curLevel)

		if not nextExp then
			stopSche = true

			break
		end

		if self._eatExp >= 0 then
			-- block empty
		end

		if self._curExp == 0 and self._curLevel > self._heroData:getLevel() and self._eatExp > 0 then
			expChange = true
			self._curLevel = self._curLevel - 1

			local nextExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._curLevel)

			self._curExp = nextExp
			self._minusOnceExp = math.modf(nextExp / self._seeTime)
			self._minusOnceExp = self._minusOnceExp < 1 and 1 or self._minusOnceExp
			levelUp = true
			self._previewProgrState = true

			return
		end

		if self._minusOnceExp > self._eatExp then
			self._minusOnceExp = self._eatExp
		end

		if self._eatExp <= 0 then
			stopSche = true
			expChange = true

			break
		end

		if self._eatExp >= self._minusOnceExp then
			self._curExp = self._curExp - self._minusOnceExp
			self._eatExp = self._eatExp - self._minusOnceExp
		end

		expChange = true
	end

	if stopSche then
		-- block empty
	end

	if levelUp then
		self:refreshLvlLabel()
	end

	if expChange then
		local nextExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._curLevel)

		if self._curExp == nextExp and self._curLevel < self._maxLevel then
			self:refreshProgrView(0, nextExp)
		else
			self:refreshProgrView(self._curExp, nextExp)
		end
	else
		local data = sender.data
		local itemId = tostring(data.itemId)

		if self._developSystem:getLevel() <= expConfig[itemId] then
			return
		end

		if self._curLevel >= self._maxLevel then
			nextExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._maxLevel)
		end

		if self._curLevel > self._maxLevel then
			self._curLevel = self._maxLevel
			self._curExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._maxLevel)
		elseif self._curLevel == self._maxLevel and nextExp <= self._curExp then
			self._curLevel = self._maxLevel
			self._curExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._maxLevel)
		elseif self._curExp == nextExp then
			self._curExp = 0
			self._curLevel = self._curLevel + 1
		end

		self:refreshProgrView(self._curExp, nextExp)
		self:refreshLvlLabel(self._curLevel)

		if self._heroSystem:isHeroExpMax(self._heroId, self._curLevel, self._curExp) then
			-- block empty
		end
	end
end

function HeroEatItemView:refreshLvlLabel(level)
	level = level or self._curLevel

	local levelStr = self._showPanel:getChildByFullName("levelPanel.level")
	local levelBg = self._showPanel:getChildByFullName("levelPanel.levelBg")

	levelStr:setString(level)
	levelBg:setPositionX(levelStr:getPositionX() - levelStr:getContentSize().width + 15)

	if not self._isAdd then
		return
	end
end

function HeroEatItemView:progrPreviewShow()
	if self._previewProgrTag == 1 then
		local nextExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._curLevel - 1)

		self:refreshProgrView(nextExp, nextExp)
		self:refreshLvlLabel(self._curLevel - 1)
	elseif self._previewProgrTag == 2 then
		local nextExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._curLevel)

		self:refreshProgrView(0, nextExp)
		self:refreshLvlLabel(self._curLevel)
	elseif self._previewProgrTag == 3 then
		local nextExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._curLevel)

		if self._curLevel >= self._maxLevel then
			nextExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._maxLevel)
		end

		if self._curLevel > self._maxLevel then
			self._curLevel = self._maxLevel
			self._curExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._maxLevel)
		elseif self._curLevel == self._maxLevel and nextExp <= self._curExp then
			self._curLevel = self._maxLevel
			self._curExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._maxLevel)
		elseif self._curExp == nextExp then
			self._curExp = 0
			self._curLevel = self._curLevel + 1
		end

		self:refreshProgrView(self._curExp, nextExp)
		self:refreshLvlLabel(self._curLevel)

		if self._heroSystem:isHeroExpMax(self._heroId, self._curLevel, self._curExp) then
			-- block empty
		end

		self._previewProgrTag = 1
		self._previewProgrState = false
	end

	self._previewProgrTag = self._previewProgrTag + 1
end

function HeroEatItemView:progrPreviewMinusShow()
	local addExp = 0
	local items = {}

	for id, data in pairs(self._itemMap) do
		if data.eatCount > 0 then
			items[#items + 1] = {
				itemId = data.itemId,
				amount = data.eatCount
			}
			addExp = addExp + data.eatCount * data.exp
		end
	end

	local trueExp = math.min(addExp, self._maxExpNeed)
	local curShowLevel, curShowExp, gold = self._heroSystem:getHeroLevelGoldCost(self._heroId, trueExp)
	local endExp = self._heroSystem:getNextLvlAddExp(self._heroId, curShowLevel)

	if curShowLevel >= self._maxLevel then
		endExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._maxLevel)
	end

	if curShowLevel > self._maxLevel then
		curShowLevel = self._maxLevel
		curShowExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._maxLevel)
	elseif curShowLevel == self._maxLevel and endExp <= curShowExp then
		curShowLevel = self._maxLevel
		curShowExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._maxLevel)
	elseif curShowExp == endExp then
		curShowExp = 0
		curShowLevel = curShowLevel + 1
	end

	self:refreshLvlLabel(curShowLevel)
	self:refreshProgrView(curShowExp, endExp)
end

local progrSleepTime = 0.02

function HeroEatItemView:createProgrScheduler(sender)
	self:closeProgrScheduler()

	if self._progrScheduler == nil then
		self._progrScheduler = LuaScheduler:getInstance():schedule(function()
			self:progrShow(sender)
		end, progrSleepTime, false)
	end
end

function HeroEatItemView:closeProgrScheduler()
	if self._progrScheduler then
		LuaScheduler:getInstance():unschedule(self._progrScheduler)

		self._progrScheduler = nil
	end
end

function HeroEatItemView:createSleepScheduler(time, sender)
	self:closeSleepScheduler()

	if self._sleepScheduler == nil then
		self._sleepScheduler = LuaScheduler:getInstance():schedule(function()
			self:touchSleepEnd(sender)
		end, time, false)
	end
end

function HeroEatItemView:closeSleepScheduler()
	if self._sleepScheduler then
		LuaScheduler:getInstance():unschedule(self._sleepScheduler)

		self._sleepScheduler = nil
	end
end

function HeroEatItemView:createLongAddScheduler(time)
	self:closeLongAddScheduler()

	if self._longAddScheduler == nil then
		self._longAddScheduler = LuaScheduler:getInstance():schedule(function()
			self:longAdd()
		end, time, false)
	end
end

function HeroEatItemView:closeLongAddScheduler()
	if self._longAddScheduler then
		LuaScheduler:getInstance():unschedule(self._longAddScheduler)

		self._longAddScheduler = nil
	end
end

function HeroEatItemView:closeAllScheduler()
	self:closeLongAddScheduler()
	self:closeSleepScheduler()
	self:closeProgrScheduler()
end

function HeroEatItemView:showCustomAnim()
	local bgAnim = self._showPanel:getChildByFullName("bgAnim")

	bgAnim:removeAllChildren()

	self._customAnim1 = cc.MovieClip:create("zongdhbbbb_yinghunshengji")

	self._customAnim1:addTo(bgAnim):center(bgAnim:getContentSize())
	self._customAnim1:gotoAndStop(0)
	self._customAnim1:offset(0, -60)
	self._customAnim1:setScale(1.2)
	self._customAnim1:setGray(true)

	local anim3 = self._showPanel:getChildByFullName("anim3")

	self._customAnim2 = cc.MovieClip:create("reny_yinghunshengji")

	self._customAnim2:addTo(anim3)
	self._customAnim2:setPosition(cc.p(86, 60))
	self._customAnim2:gotoAndStop(0)
	self._customAnim1:addEndCallback(function()
		self._customAnim1:gotoAndStop(0)
	end)
	self._customAnim2:addEndCallback(function()
		self._customAnim2:stop()
	end)
end

function HeroEatItemView:playEffect()
	local remoteTimestamp = self._mediator:getInjector():getInstance("GameServerAgent"):remoteTimestamp()

	if self._soundEffectTime == 0 then
		self._soundId1 = AudioEngine:getInstance():playRoleEffect("Se_Alert_Character_Levelup", false)
		self._soundEffectTime = remoteTimestamp
	end

	local diff = remoteTimestamp - self._soundEffectTime

	if diff > 1 then
		self._soundId1 = AudioEngine:getInstance():playRoleEffect("Se_Alert_Character_Levelup", false)
		self._soundEffectTime = remoteTimestamp
	end
end

function HeroEatItemView:runStartAnim()
	self._touchLayer:setVisible(true)
	self._showPanel:stopAllActions()

	local action = cc.CSLoader:createTimeline(componentPath)

	self._showPanel:runAction(action)
	action:gotoFrameAndPlay(0, 27, false)
	action:setTimeSpeed(1.2)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "EndAnim1" then
			self._touchLayer:setVisible(false)
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function HeroEatItemView:stopEffect()
	if self._soundId then
		AudioEngine:getInstance():stopEffect(self._soundId)

		self._soundId = nil
	end

	if self._soundId1 then
		AudioEngine:getInstance():stopEffect(self._soundId1)

		self._soundId1 = nil
	end
end

function HeroEatItemView:getAddExpAndLevel(ignoreCleanCache)
	local itemCache = self._heroSystem:getEatItemCache()

	if self._firstIn and #itemCache ~= 0 then
		self._itemMap = {}

		table.deepcopy(itemCache, self._itemMap)

		for i = 1, #self._itemMap do
			local itemId = self._itemMap[i].itemId
			local entry = self._bagSystem:getEntryById(itemId)

			if entry and entry.count > 0 then
				self._itemMap[i].allCount = entry.count
			end
		end

		self._firstIn = false

		self:refreshItemPanel()

		self._cacheInit = true
	elseif #self._itemMap ~= 0 and not ignoreCleanCache then
		self._heroSystem:setEatItemCache({})
		table.deepcopy(self._itemMap, itemCache)
		self._heroSystem:setEatItemCache(itemCache)
	elseif #self._itemMap ~= 0 and ignoreCleanCache then
		for i = 1, #itemCache do
			if self._itemMap[i].allCount > 0 then
				self._itemMap[i].eatCount = itemCache[i].eatCount
			end
		end

		table.deepcopy(self._itemMap, itemCache)
		self._heroSystem:setEatItemCache(itemCache)
	end

	self._addTotalExp = 0
	self._curShowLevel = self._heroData:getLevel()
	self._curShowExp = self._heroData:getExp()
	self._goldCostNum = 0
	self._itemCost = {}

	local addExp = 0
	local items = {}

	for id, data in pairs(self._itemMap) do
		if data.eatCount > 0 then
			items[#items + 1] = {
				itemId = data.itemId,
				amount = data.eatCount
			}
			addExp = addExp + data.eatCount * data.exp
		end
	end

	if #items <= 0 then
		return
	end

	local trueExp = math.min(addExp, self._maxExpNeed)
	local curShowLevel, curShowExp, gold = self._heroSystem:getHeroLevelGoldCost(self._heroId, trueExp)

	print(" self._maxExpNeed______ " .. self._maxExpNeed)
	print(" getAddExpAndLevel______ addExp = " .. addExp .. "  gold = " .. gold .. "  curShowLevel = " .. curShowLevel .. "  curShowExp = " .. curShowExp)

	self._addTotalExp = addExp
	self._curShowLevel = curShowLevel
	self._curShowExp = curShowExp
	self._goldCostNum = gold
	self._itemCost = items
end

function HeroEatItemView:refreshGoldCost(cancelAnim, ignoreCleanCache)
	self:getAddExpAndLevel(ignoreCleanCache)

	local level = self._curShowLevel

	if not self._goldCostNum then
		local gold = 0

		self._upBtn:setVisible(gold > 0)

		local panel = self._upBtn:getChildByFullName("panel")
		local cost = panel:getChildByName("costnumlabel")

		cost:setString(gold)

		local name1 = panel:getChildByFullName("name1")
		local goldimg = panel:getChildByFullName("goldimg")
		local titlelabel = panel:getChildByFullName("titlelabel")
		local costNumLabel = panel:getChildByFullName("costnumlabel")
		local colorNum = gold <= self._developSystem:getGolds() and 1 or 6

		costNumLabel:setString(gold)
		costNumLabel:setTextColor(GameStyle:getColor(colorNum))

		local panelWidth = 45 + costNumLabel:getContentSize().width + titlelabel:getContentSize().width

		panel:setContentSize(cc.size(panelWidth, 120))
		goldimg:setPositionX(20)
		costNumLabel:setPositionX(40)
		titlelabel:setPositionX(costNumLabel:getPositionX() + costNumLabel:getContentSize().width)
		name1:setPositionX(panelWidth / 2)

		local width = panelWidth + 80

		self._upBtn:setContentSize(cc.size(width, 120))
		panel:setPositionX(width / 2)
		self._infoPanel:getChildByFullName("des_1.text"):setString(self._heroData:getAttack())
		self._infoPanel:getChildByFullName("des_2.text"):setString(self._heroData:getHp())
		self._infoPanel:getChildByFullName("des_3.text"):setString(self._heroData:getDefense())
		self._infoPanel:getChildByFullName("des_4.text"):setString(self._heroData:getSpeed())

		local heroLevel = self._heroData:getLevel()
		local show = level - heroLevel > 0
		local showLevel = heroLevel

		if not show then
			showLevel = showLevel .. "/" .. self._maxLevel
		end

		local level_1 = self._infoPanel:getChildByName("level_1")
		local preLevelImg = self._infoPanel:getChildByName("preLevelImg")

		level_1:setString(showLevel)

		local level_2 = self._infoPanel:getChildByName("level_2")

		preLevelImg:setVisible(show)
		level_2:setVisible(show)
		level_2:setString(level)

		if preLevelImg then
			preLevelImg:setPositionX(level_1:getPositionX() + level_1:getContentSize().width + 5)
			level_2:setPositionX(preLevelImg:getPositionX() + preLevelImg:getContentSize().width + 5)
		end

		local a, b, c, d, e = self._heroData:getNextStarEffect({
			level = level
		})

		self._infoPanel:getChildByFullName("des_1.extandText"):setString("+" .. a - self._heroData:getAttack())
		self._infoPanel:getChildByFullName("des_2.extandText"):setString("+" .. c - self._heroData:getHp())
		self._infoPanel:getChildByFullName("des_3.extandText"):setString("+" .. b - self._heroData:getDefense())
		self._infoPanel:getChildByFullName("des_4.extandText"):setString("+" .. d - self._heroData:getSpeed())

		if show then
			::label_62_0::

			local atkShow = true
			local atkShow

			if a - self._heroData:getAttack() <= 0 then
				atkShow = false
			end

			if show then
				::label_62_1::

				local hpShow = true
				local hpShow

				if c - self._heroData:getHp() <= 0 then
					hpShow = false
				end

				if show then
					::label_62_2::

					local defShow = true
					local defShow

					if b - self._heroData:getDefense() <= 0 then
						defShow = false
					end

					if show then
						::label_62_3::

						local speedShow = true
						local speedShow

						if d - self._heroData:getSpeed() <= 0 then
							speedShow = false
						end

						self._infoPanel:getChildByFullName("des_1.extandText"):setVisible(atkShow)
						self._infoPanel:getChildByFullName("des_2.extandText"):setVisible(hpShow)
						self._infoPanel:getChildByFullName("des_3.extandText"):setVisible(defShow)
						self._infoPanel:getChildByFullName("des_4.extandText"):setVisible(speedShow)

						if not self._isAdd or cancelAnim or self._cacheInit then
							self:closeAllScheduler()

							local endExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._curShowLevel)

							if self._curShowLevel >= self._maxLevel then
								endExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._maxLevel)
							end

							if self._curShowLevel > self._maxLevel then
								self._curShowLevel = self._maxLevel
								self._curShowExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._maxLevel)
							elseif self._curShowLevel == self._maxLevel and endExp <= self._curShowExp then
								self._curShowLevel = self._maxLevel
								self._curShowExp = self._heroSystem:getNextLvlAddExp(self._heroId, self._maxLevel)
							elseif self._curShowExp == endExp then
								self._curShowExp = 0
								self._curShowLevel = self._curShowLevel + 1
							end

							self:refreshLvlLabel(self._curShowLevel)
							self:refreshProgrView(self._curShowExp, endExp)

							if self._heroSystem:isHeroExpMax(self._heroId, self._curShowLevel, self._curShowExp) then
								-- block empty
							end
						end

						self._cacheInit = false

						self._gotoBtn:setVisible(false)

						local tip = Strings:get("Hero_LvUp_Tips")

						if self._heroSystem:isHeroExpMax(self._heroId) then
							tip = Strings:get("Heros_Tips_ExpFull")

							if self._heroData:getNextQualityId() == "" then
								tip = Strings:get("Heros_Tips_LevelFull")
							else
								tip = Strings:get("HEROS_UI68")

								self._gotoBtn:setVisible(not self._mediator:checkEnabledQuality())
							end
						end

						self._text:setString(tip)
					end
				end
			end
		end
	end
end

function HeroEatItemView:onClickLevelUp()
	if self._closeView then
		return
	end

	if self._heroSystem:isHeroExpMax(self._heroId) then
		local tip = Strings:get("Heros_Tips_ExpFull")

		self._mediator:dispatch(ShowTipEvent({
			tip = (self._heroData:getNextQualityId() == "" or nil) and Strings:get("Heros_Tips_LevelFull")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if #self._itemCost <= 0 then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self._mediator:dispatch(ShowTipEvent({
			tip = Strings:get("HEROS_UI61")
		}))

		return
	end

	local gold = self._goldCostNum
	local goldEnough = CurrencySystem:checkEnoughGold(self._mediator, gold, nil, {
		tipType = "tip"
	})

	if goldEnough then
		self._heroSystem:setEatItemCache({})
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self._heroSystem:requestHeroLvlUp(self._heroId, self._itemCost)
	else
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self._developSystem:requstNotEnoughItem("HERO_LV", CurrencyIdKind.kGold)
	end
end

function HeroEatItemView:onEatItemClicked(sender, eventType, isAdd)
	if eventType == ccui.TouchEventType.began then
		self._selectItemId = sender.data.itemId
		self._touchAddCount = 0

		self:refreshEatData()

		self._touchNode = sender
		self._canTouch = self:checkBeginEatCount(sender, isAdd)

		if not isAdd then
			self._canTouch = self:checkBeginMinusCount(sender)
		end

		if not self._canTouch then
			return
		end

		self._isAdd = isAdd

		self:refreshGoldCost(true)

		self._curLevel = self._curShowLevel
		self._curExp = self._curShowExp
		self._addExp = self._addTotalExp
		self._eatExp = 0

		self:refreshEatOnceExp(self._heroSystem:getNextLvlAddExp(self._heroId, self._curLevel))

		self._minusOnceExp = 1
		self._previewProgrTag = 1
		self._previewProgrState = false

		self:touchBegin(sender)

		if self._endCallbackId then
			self._customAnim1:removeCallback(self._endCallbackId)
		end
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
		self:refreshGoldCost()
	end
end

function HeroEatItemView:showLevelUpCombatAnim()
	AudioEngine:getInstance():playRoleEffect("Se_Alert_Character_Levelup", false)

	self._soundId = self._soundId or AudioEngine:getInstance():playRoleEffect("Voice_" .. self._heroId .. "_11", false, function()
		self._soundId = nil
	end)

	if self._heroSystem:isHeroExpMax(self._heroId) then
		-- block empty
	end

	self._curExp = self._heroData:getExp()
	self._curLevel = self._heroData:getLevel()

	local levelStr = self._showPanel:getChildByFullName("levelPanel.level")
	local levelBg = self._showPanel:getChildByFullName("levelPanel.levelBg")

	levelStr:setString(self._curLevel)
	levelBg:setPositionX(levelStr:getPositionX() - levelStr:getContentSize().width + 15)

	if self._heroData:getLevel() ~= self._showLevel and self._attrArr then
		local a = self._heroData:getAttack()
		local b = self._heroData:getDefense()
		local c = self._heroData:getHp()
		local addA = a - self._attrArr.a
		local addB = b - self._attrArr.b
		local addC = c - self._attrArr.c
		local params = {
			heroId = self._heroId,
			level = self._showLevel,
			attr = {
				hp = {
					self._attrArr.c,
					addC
				},
				attack = {
					self._attrArr.a,
					addA
				},
				defense = {
					self._attrArr.b,
					addB
				}
			}
		}
		local view = self._mediator:getInjector():getInstance("HeroLevelUpTipView")

		self._mediator:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, params))
	else
		self._customAnim1:gotoAndPlay(10)
		self._customAnim2:gotoAndPlay(80)
	end

	self._showLevel = self._heroData:getLevel()
	self._attrArr = {
		a = self._heroData:getAttack(),
		b = self._heroData:getDefense(),
		c = self._heroData:getHp(),
		combat = self._heroData:getSceneCombatByType(SceneCombatsType.kAll)
	}
end
