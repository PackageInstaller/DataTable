-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryGiftCellWidget.lua

GalleryGiftCellWidget = class("GalleryGiftCellWidget", BaseWidget, _M)

GalleryGiftCellWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")
GalleryGiftCellWidget:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryGiftCellWidget:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")

local kConsumeData = {
	["5"] = "HeroGift_Quality5",
	["3"] = "HeroGift_Quality3",
	["4"] = "HeroGift_Quality4",
	["2"] = "HeroGift_Quality2"
}
local UnlockDescType = {
	desc = Strings:get("GALLERY_UI48"),
	func = Strings:get("GALLERY_UI49"),
	past = Strings:get("GALLERY_UI50")
}

function GalleryGiftCellWidget.class:createWidgetNode()
	local resFile = "asset/ui/GalleryGiftWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

function GalleryGiftCellWidget:initialize(view)
	super.initialize(self, view)
end

function GalleryGiftCellWidget:dispose()
	self:closeAllScheduler()
	self:getEventDispatcher():removeEventListener(EVT_PLAYER_SYNCHRONIZED, self, self.refreshBySync)
	self:getEventDispatcher():removeEventListener(EVT_GALLERY_DATE_RESETR_SUCC, self, self.refreshBySync)
	self:getEventDispatcher():removeEventListener(EVT_GALLERY_UI_SHOW, self, self.showUiByEvent)
	super.dispose(self)
end

function GalleryGiftCellWidget:userInject(injector)
	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()

	self:getEventDispatcher():addEventListener(EVT_PLAYER_SYNCHRONIZED, self, self.refreshBySync)
	self:getEventDispatcher():addEventListener(EVT_GALLERY_DATE_RESETR_SUCC, self, self.refreshBySync)
	self:getEventDispatcher():addEventListener(EVT_GALLERY_UI_SHOW, self, self.showUiByEvent)
end

function GalleryGiftCellWidget:setupView(data)
	self._meditor = data.meditor
	self._upAnimPanel = data.upAnimPanel
	self._lovePanel = data.lovePanel
	self._loadingBar = self._lovePanel:getChildByName("loading")
	self._loveExpLabel = self._lovePanel:getChildByName("loveExp")
	self._addLove = self._lovePanel:getChildByName("addLove")

	self._addLove:setVisible(false)
	self:initData(data)
	self:initView()
end

function GalleryGiftCellWidget:initViewShow(data)
	self._meditor = data.meditor
	self._upAnimPanel = data.upAnimPanel
	self._lovePanel = data.lovePanel
	self._loadingBar = self._lovePanel:getChildByName("loading")
	self._loveExpLabel = self._lovePanel:getChildByName("loveExp")
	self._addLove = self._lovePanel:getChildByName("addLove")

	self._addLove:setVisible(false)
	self:initWidgetInfo()
end

function GalleryGiftCellWidget:refreshBySync()
	if not checkDependInstance(self) then
		return
	end

	if not self._heroId then
		return
	end

	self:closeAllScheduler()
	self:refreshData()
	self:refreshView()
end

function GalleryGiftCellWidget:initData(data)
	self._heroId = data.id
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._loveSound = self._heroData:getLoveSound()
	self._type = data.type
	self._dateTimes = self._gallerySystem:getHeroDateTimes()
	self._selectItem = {}
	self._heroGiftsTemp = {}
	self._soundId = nil
	self._touchCancel = false
	self._soundEffectTime = 0
	self._loveUpData = {}

	self:updateGiftsData()
	table.sort(self._heroGifts, function(a, b)
		if a.markTag == b.markTag then
			if a.quality == b.quality then
				return a.sort < b.sort
			end

			return a.quality > b.quality
		end

		return a.markTag < b.markTag
	end)

	for i = 1, #self._heroGifts do
		self._heroGiftsTemp[#self._heroGiftsTemp + 1] = self._heroGifts[i].id
	end

	self._loveLevel = self._heroData:getLoveLevel()
	self._oldLoveLevel = self._loveLevel
	self._loveLevelTemp = self._loveLevel
	self._loveExp = self._heroData:getLoveExp()
	self._previewProgrState = false
	self._previewProgrTag = 1
	self._curExp = self._loveExp
	self._curLevel = self._loveLevel
	self._eatExp = 0
	self._addExp = 0
	self._eatOnceExp = 1
	self._seeTime = 10

	self:createNeedExp()

	self._attrData = {}

	if self._heroSystem:hasHero(self._heroId) then
		local hero = self._heroSystem:getHeroById(self._heroId)

		self._attrData = hero:getLoveModule():getTotalLoveExtraBonus()
	end
end

function GalleryGiftCellWidget:updateGiftsData()
	self._heroGifts = self._heroSystem:getGiftItemList(self._heroId, self._heroGiftsTemp)

	for i = 1, #self._heroGifts do
		local data = self._heroGifts[i]

		self._heroData:getGotGiftMark(data)
	end

	if self._selectItem.data then
		local giftId = self._selectItem.data.id

		if self._bagSystem:getItemCount(giftId) == 0 then
			self._selectItem = {}
		end
	end
end

function GalleryGiftCellWidget:initWidgetInfo()
	self._main = self:getView()

	self._upAnimPanel:setVisible(false)
	self._upAnimPanel:setSwallowTouches(true)
	self._upAnimPanel:addClickEventListener(function()
		self:onClickUpPanel()
	end)

	self._presentPanel = self._main:getChildByFullName("Panel_276")
	self._emptyNode = self._main:getChildByFullName("Panel_12")

	self._emptyNode:setVisible(false)

	self._sendGiftBtn = self._presentPanel:getChildByFullName("sendBtn")
	self._sendGiftBtnAll = self._presentPanel:getChildByFullName("sendBtnAll")

	local unlockSystem = self:getInjector():getInstance(SystemKeeper)

	if not unlockSystem:isUnlock("Gift_piliang") then
		self._sendGiftBtnAll:setVisible(false)
	end

	self._emptyNode:getChildByFullName("taskBtn"):addClickEventListener(function()
		self:onTaskBtnClicked()
	end)
	self._emptyNode:getChildByFullName("shopBtn"):addClickEventListener(function()
		self:onShopBtnClicked()
	end)
	self._presentPanel:getChildByFullName("sendBtn"):addTouchEventListener(function(sender, eventType)
		self:onSendGift(sender, eventType)
	end)
	self._presentPanel:getChildByFullName("sendBtnAll"):addTouchEventListener(function(sender, eventType)
		self:onSendAllGift(sender, eventType)
	end)

	self._toastPanel = self._main:getChildByFullName("toastPanel")

	self._toastPanel:setVisible(false)

	local bg = self._toastPanel:getChildByFullName("bg")

	bg:ignoreContentAdaptWithSize(true)

	self._primeTextPosX = self._toastPanel:getChildByFullName("clipNode.text"):getPositionX()
	self._primeTextPosY = self._toastPanel:getChildByFullName("clipNode.text"):getPositionY()

	self._toastPanel:getChildByFullName("clipNode.text"):getVirtualRenderer():setDimensions(330, 0)
end

function GalleryGiftCellWidget:initView()
	local unlockSystem = self:getInjector():getInstance(SystemKeeper)

	self:doViewSound()
	self:initGiftView()
	self:refreshGiftView()
	self._sendGiftBtn:setVisible(#self._heroGifts > 0)
	self._sendGiftBtnAll:setVisible(#self._heroGifts > 0 and unlockSystem:isUnlock("Gift_piliang"))
	self._presentPanel:setVisible(#self._heroGifts > 0)
end

function GalleryGiftCellWidget:showItemTip()
	local tipName = self._presentPanel:getChildByFullName("name")
	local tipDesc = self._presentPanel:getChildByFullName("desc")

	if not self._selectItem.data then
		tipName:setVisible(false)
		tipDesc:setVisible(false)

		return
	end

	tipName:setVisible(true)
	tipDesc:setVisible(true)

	local item = self._selectItem.data

	tipName:setString(item.name)
	tipName:disableEffect(1)
	GameStyle:setQualityText(tipName, item.quality, true)
	tipDesc:setString(Strings:get("GALLERY_UI44", {
		num = item.addExp
	}))
	tipDesc:removeAllChildren()

	self._useNewDesc = item.extExp ~= 0

	if item.markIcon and item.extExp ~= 0 then
		tipDesc:setString("")

		if item.extExp > 0 then
			if not ("+" .. item.extExp) then
				local num2 = item.extExp
				local color = item.extExp > 0 and "#CDFA64" or "#FF8787"
				local outlineColor = item.extExp > 0 and "#415019" or "#641E1E"
				local str = Strings:get("GALLERY_UI45", {
					fontName = TTF_FONT_FZYH_M,
					fontColor = color,
					outlineColor = outlineColor,
					num1 = item.addExp,
					num2 = num2
				})

				self._desc = str

				local descControl = ccui.RichText:createWithXML(str, {})

				descControl:setAnchorPoint(cc.p(0, 1))
				tipDesc:addChild(descControl)
				descControl:setPosition(cc.p(0, tipDesc:getContentSize().height))
				ajustRichTextCustomWidth(descControl, 205)
			end
		end
	end
end

function GalleryGiftCellWidget:setTextAnim()
	local clipNode = self._qipaoAnimPanel:getChildByFullName("ToastPanel.clipNode")
	local text = self._qipaoAnimPanel:getChildByFullName("ToastPanel.clipNode.text")
	local textSizeHeight = text:getContentSize().height
	local clipNodeSizeHeight = clipNode:getContentSize().height

	if textSizeHeight > clipNodeSizeHeight - 5 then
		local offset = textSizeHeight - clipNodeSizeHeight + 10

		text:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.MoveTo:create(2.5 * (offset / 25), cc.p(self._primeTextPosX, self._primeTextPosY + offset))))
	end
end

function GalleryGiftCellWidget:initGiftView()
	local itemList = self._presentPanel:getChildByName("itemList")

	itemList:removeAllChildren()

	local size_W = 480
	local size_H = 100

	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		return size_W, size_H
	end

	local function numberOfCellsInTableView(table)
		return math.ceil(#self._heroGifts / 5)
	end

	local function tableCellRecycle(table, cell)
		return
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

	self._giftView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(cc.p(0, 0))
	tableView:setPosition(0, 0)
	tableView:setDelegate()
	itemList:addChild(tableView, 11)
	self._giftView:setTag(1241214)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellRecycle, cc.TABLECELL_WILL_RECYCLE)
	tableView:setTouchEnabled(true)
	tableView:reloadData()
end

function GalleryGiftCellWidget:createCell(cell, idx)
	cell:removeAllChildren()

	local layerPanel = ccui.Layout:create()

	layerPanel:setContentSize(cc.size(480, 100))
	layerPanel:removeAllChildren()
	layerPanel:addTo(cell)

	for i = 1, 5 do
		local index = i + (idx - 1) * 5

		if self._heroGifts[index] then
			local data = self._heroGifts[index]
			local icon = IconFactory:createIcon({
				id = data.id,
				amount = data.allCount
			}, {
				showAmount = true
			})

			icon:addTo(layerPanel)
			icon:setPosition(cc.p(50 + (i - 1) * 95, 46))
			icon:setScale(0.7)

			local layer = ccui.Layout:create()

			layer:setAnchorPoint(cc.p(0.5, 0.5))
			layer:setPosition(cc.p(50 + (i - 1) * 95, 50))
			layer:addTo(layerPanel)

			layer.data = data
			layer.icon = icon

			layer:setTouchEnabled(true)
			layer:setContentSize(cc.size(100, 100))
			layer:addTouchEventListener(function(sender, eventType)
				self:onEatItemClicked(sender, eventType)
			end)
			layer:setSwallowTouches(false)

			if self._selectItem.data then
				if self._selectItem.data.id == data.id then
					self._selectItem = {
						data = data,
						icon = icon
					}

					local image = ccui.ImageView:create("img_xiangce_xuanzhong.png", 1)

					image:addTo(layer):center(layer:getContentSize()):offset(0, -3.5)
					image:setName("SelectImage")
				end
			elseif idx == 1 then
				self._selectItem = {
					data = data,
					icon = icon
				}

				local image = ccui.ImageView:create("img_xiangce_xuanzhong.png", 1)

				image:addTo(layer):center(layer:getContentSize()):offset(0, -3.5)
				image:setName("SelectImage")
			end

			local markIcon = data.markIcon

			if markIcon then
				local markImg = ccui.ImageView:create(markIcon, 1)

				markImg:addTo(layer)
				markImg:setPosition(cc.p(80, 72))
				markImg:setScale(0.8)
			end
		end
	end
end

function GalleryGiftCellWidget:refreshData()
	self._dateTimes = self._gallerySystem:getHeroDateTimes()

	self:updateGiftsData()

	self._loveLevel = self._heroData:getLoveLevel()
	self._loveExp = self._heroData:getLoveExp()
	self._previewProgrState = false
	self._previewProgrTag = 1
	self._curExp = self._loveExp
	self._curLevel = self._loveLevel
	self._eatExp = 0
	self._addExp = 0
	self._eatOnceExp = 1
	self._seeTime = 10

	self:createNeedExp()

	self._attrData = {}

	if self._heroSystem:hasHero(self._heroId) then
		local hero = self._heroSystem:getHeroById(self._heroId)

		self._attrData = hero:getLoveModule():getTotalLoveExtraBonus()
	end
end

function GalleryGiftCellWidget:refreshGiftView()
	local showEmptyNode = #self._heroGifts == 0

	self._emptyNode:setVisible(showEmptyNode)
	self._presentPanel:setVisible(not showEmptyNode)

	local minOffset = self._giftView:minContainerOffset().y
	local offsetY = self._giftView:getContentOffset().y

	if offsetY < minOffset then
		offsetY = minOffset
	end

	self._giftView:reloadData()
	self._giftView:setContentOffset(cc.p(0, offsetY))

	local minOffset = self._giftView:minContainerOffset().y
	local offsetY = self._giftView:getContentOffset().y

	if offsetY < minOffset then
		offsetY = minOffset
	end

	self._giftView:setContentOffset(cc.p(0, offsetY))
	self:showItemTip()
end

function GalleryGiftCellWidget:refreshView()
	self:refreshGiftView()
end

function GalleryGiftCellWidget:onClickBack()
	self:stopEffect()
	self:dismiss()
end

function GalleryGiftCellWidget:onTaskBtnClicked()
	local taskSystem = self:getInjector():getInstance("TaskSystem")

	taskSystem:tryEnter({
		tabType = 1
	})
end

function GalleryGiftCellWidget:onShopBtnClicked()
	local shopSystem = self:getInjector():getInstance("ShopSystem")

	shopSystem:tryEnter({
		shopId = "Shop_Normal"
	})
end

function GalleryGiftCellWidget:getTableViewOffsetX()
	local oldOffset = self._giftView:getContentOffset()

	return oldOffset.y
end

function GalleryGiftCellWidget:onEatItemClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

		self._selectItemId = sender.data.itemId
		self._selectItem = {
			data = sender.data,
			icon = sender.icon
		}

		local offsetX = self:getTableViewOffsetX()

		self._giftView:reloadData()
		self._giftView:setContentOffset(cc.p(0, offsetX))
		self:showItemTip()
	end
end

function GalleryGiftCellWidget:refreshProgrView(nowExp, endExp)
	if self._loadingBar:getTag() ~= nowExp or self._loveExpLabel:getTag() ~= endExp then
		self._loadingBar:setPercent(nowExp / endExp * 100)
		self._loadingBar:setTag(nowExp)
		self._loveExpLabel:setString(tostring(nowExp) .. "/" .. tostring(endExp))
		self._loveExpLabel:setTag(endExp)

		local addLove = self._selectItem.data.extExp + self._selectItem.data.addExp

		self:showDateToast(nil, nil, addLove)
	end

	self:playEffect()
end

function GalleryGiftCellWidget:playEffect()
	local remoteTimestamp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()

	if self._soundEffectTime == 0 then
		self._soundId1 = AudioEngine:getInstance():playEffect("Se_Alert_Favor_Up", false)
		self._soundEffectTime = remoteTimestamp
	end

	local diff = remoteTimestamp - self._soundEffectTime

	if diff > 1 then
		self._soundId1 = AudioEngine:getInstance():playEffect("Se_Alert_Favor_Up", false)
		self._soundEffectTime = remoteTimestamp
	end
end

function GalleryGiftCellWidget:checkBeginEatCount(sender)
	if self._heroSystem:isLoveLevelMax(self._heroId) then
		self._meditor:dispatch(ShowTipEvent({
			tip = Strings:get("GALLERY_UI41")
		}))

		return false
	end

	local data = sender.data
	local lastCount = data.allCount - data.eatCount

	if lastCount == 0 or self._touchCancel then
		self:sendMessage(sender)

		return false
	end

	return true
end

function GalleryGiftCellWidget:createNeedExp()
	self._maxExpNeed = self._heroSystem:getMaxLevelCost(self._heroId)
end

function GalleryGiftCellWidget:canEatItem(itemNode, hasTip)
	local data = itemNode.data

	if data.allCount == 0 or data.allCount == data.eatCount then
		return false
	end

	if self._addExp >= self._maxExpNeed then
		return false
	end

	return true
end

function GalleryGiftCellWidget:touchBegin(sender)
	local canAdd = self:canEatItem(sender, true)

	if not canAdd then
		self:closeLongAddScheduler()

		return false
	end

	local data = sender.data

	if not data.markSound then
		local soundId = "Voice_" .. self._heroId .. "_20"
		local useSound = data.useSoundDes

		performWithDelay(self:getView(), function()
			if not self._soundId and useSound then
				self._soundId = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
					self._soundId = nil
				end)
			end
		end, 0.5)
		self:playEffect()
		self:createProgrScheduler(sender)
		self:createLongAddSch(sender)
	end
end

function GalleryGiftCellWidget:createLongAddSch(sender)
	self:closeSleepScheduler()

	local time = 1

	self:createSleepScheduler(time, sender)
end

function GalleryGiftCellWidget:touchEnd(sender)
	self:eatOneItem(self._touchNode)
	self:sendMessage(sender)
end

function GalleryGiftCellWidget:touchSleepEnd(sender)
	self:closeSleepScheduler()
	self:createProgrScheduler(sender)
	self:eatOneItem(self._touchNode)

	local time = self:getSpeedByItemCount(self._touchAddCount, sender)

	self:createLongAddScheduler(time, sender)
end

function GalleryGiftCellWidget:longAdd(sender)
	local onceAddTime = self:getCostNumByItemCount(self._touchAddCount, sender)

	for i = 1, onceAddTime do
		local stopAdd = self:eatOneItem(self._touchNode)

		if not stopAdd then
			break
		end
	end

	if not self._soundId then
		local data = sender.data

		if not data.markSound then
			self._soundId = AudioEngine:getInstance():playRoleEffect(data.markSound, false, function()
				self._soundId = nil
			end)
		end
	end
end

function GalleryGiftCellWidget:getSpeedByItemCount(count, sender)
	local quality = sender.data.quality
	local data = ConfigReader:getRecordById("ExpConsume", kConsumeData[tostring(quality)])

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

function GalleryGiftCellWidget:getCostNumByItemCount(count, sender)
	local quality = sender.data.quality
	local data = ConfigReader:getRecordById("ExpConsume", kConsumeData[tostring(quality)])

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

function GalleryGiftCellWidget:eatOneItem(sender)
	local canAdd = self:canEatItem(sender, true)

	if not canAdd then
		self:closeLongAddScheduler()

		return false
	end

	local data = sender.data

	data.eatCount = data.eatCount + 1
	self._touchAddCount = self._touchAddCount + 1

	local changeExp = data.exp

	if self._addExp + data.exp >= self._maxExpNeed then
		changeExp = self._maxExpNeed - self._addExp
	end

	self._eatExp = self._eatExp + changeExp
	self._addExp = self._addExp + changeExp

	self:refreshEatNode(sender)

	return true
end

function GalleryGiftCellWidget:refreshEatNode(sender)
	if next(self._selectItem) and self._selectItem.icon and self._selectItem.icon.setAmount then
		local data = sender.data
		local itemIcon = self._selectItem.icon

		itemIcon:setAmount(data.allCount - data.eatCount)
	end
end

function GalleryGiftCellWidget:progrShow(sender)
	if self._previewProgrState and not self._touchCancel then
		self:progrPreviewShow(sender)
	else
		self:progrNormalShow(false, sender)
	end
end

function GalleryGiftCellWidget:checkCanEatItem(nextExp, sender)
	if self._touchCancel then
		self:sendMessage(sender)

		return false
	end

	if self._eatExp <= 0 then
		self:progrNormalShow(true, sender)

		return false
	end

	if not nextExp then
		self:sendMessage(sender)

		return false
	end

	return true
end

function GalleryGiftCellWidget:refreshEatOnceExp(nextExp)
	self._eatOnceExp = (nextExp - self._curExp) / self._seeTime

	if self._eatOnceExp > self._eatExp then
		self._eatOnceExp = self._eatExp
	end

	self._eatOnceExp = self._eatOnceExp < 1 and 1 or self._eatOnceExp
	self._eatOnceExp = math.modf(self._eatOnceExp)
end

function GalleryGiftCellWidget:progrNormalShow(closeCheck, sender)
	local nextExp = self._heroSystem:getNextLoveExp(self._heroId, self._curLevel)

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

		nextExp = self._heroSystem:getNextLoveExp(self._heroId, self._curLevel)

		if not nextExp then
			stopSche = true

			break
		end

		if nextExp <= self._curExp then
			expChange = true
			self._curLevel = self._curLevel + 1
			self._curExp = 0
			nextExp = self._heroSystem:getNextLoveExp(self._heroId, self._curLevel)
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
		self:sendMessage(sender)
		self:closeProgrScheduler()
	end

	if levelUp then
		self:refreshLvlLabel()
	end

	if expChange then
		nextExp = self._heroSystem:getNextLoveExp(self._heroId, self._curLevel)

		self:refreshProgrView(self._curExp, nextExp)
	end
end

function GalleryGiftCellWidget:progrPreviewShow()
	if self._previewProgrTag == 1 then
		local nextExp = self._heroSystem:getNextLoveExp(self._heroId, self._curLevel - 1)

		self:refreshProgrView(nextExp, nextExp)
		self:refreshLvlLabel(self._curLevel - 1)
	elseif self._previewProgrTag == 2 then
		local nextExp = self._heroSystem:getNextLoveExp(self._heroId, self._curLevel)

		self:refreshProgrView(0, nextExp)
		self:refreshLvlLabel(self._curLevel)
	elseif self._previewProgrTag == 3 then
		local nextExp = self._heroSystem:getNextLoveExp(self._heroId, self._curLevel)

		self:refreshProgrView(self._curExp, nextExp)

		self._previewProgrTag = 1
		self._previewProgrState = false

		if self._curExp == nextExp then
			if self._curLevel > self._heroData:getMaxLoveLevel() then
				self:refreshProgrView(self._curExp, nextExp)
				self:refreshLvlLabel(self._curLevel)
			else
				self:refreshProgrView(0, self._heroSystem:getNextLoveExp(self._heroId, self._curLevel + 1))
				self:refreshLvlLabel(self._curLevel + 1)
			end
		end

		return
	end

	self._previewProgrTag = self._previewProgrTag + 1
end

function GalleryGiftCellWidget:refreshLvlLabel(level)
	level = level or self._curLevel

	self._lovePanel:getChildByFullName("loveLevel"):setString(level)

	local soundId = self._loveSound[level - 1]

	if self._type == GalleryFuncName.kGift and self._oldLoveLevel ~= level then
		if soundId then
			self:stopEffect()

			self._soundId = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
				self._soundId = nil
			end)
		end

		self._oldLoveLevel = level
	end
end

local progrSleepTime = 0.02

function GalleryGiftCellWidget:createProgrScheduler(sender)
	self:closeProgrScheduler()

	if self._progrScheduler == nil then
		self._progrScheduler = LuaScheduler:getInstance():schedule(function()
			self:progrShow(sender)
		end, progrSleepTime, false)
	end
end

function GalleryGiftCellWidget:closeProgrScheduler()
	if self._progrScheduler then
		LuaScheduler:getInstance():unschedule(self._progrScheduler)

		self._progrScheduler = nil
	end
end

function GalleryGiftCellWidget:createSleepScheduler(time, sender)
	self:closeSleepScheduler()

	if self._sleepScheduler == nil then
		self._sleepScheduler = LuaScheduler:getInstance():schedule(function()
			self:touchSleepEnd(sender)
		end, time, false)
	end
end

function GalleryGiftCellWidget:closeSleepScheduler()
	if self._sleepScheduler then
		LuaScheduler:getInstance():unschedule(self._sleepScheduler)

		self._sleepScheduler = nil
	end
end

function GalleryGiftCellWidget:createLongAddScheduler(time, sender)
	self:closeLongAddScheduler()

	if self._longAddScheduler == nil then
		self._longAddScheduler = LuaScheduler:getInstance():schedule(function()
			self:longAdd(sender)
		end, time, false)
	end
end

function GalleryGiftCellWidget:closeLongAddScheduler()
	if self._longAddScheduler then
		LuaScheduler:getInstance():unschedule(self._longAddScheduler)

		self._longAddScheduler = nil
	end
end

function GalleryGiftCellWidget:closeAllScheduler()
	self:closeLongAddScheduler()
	self:closeSleepScheduler()
	self:closeProgrScheduler()
end

function GalleryGiftCellWidget:sendMessage(sender)
	if self._heroSystem:isLoveLevelMax(self._heroId) then
		self._meditor:dispatch(ShowTipEvent({
			tip = Strings:get("GALLERY_UI41")
		}))

		return
	end

	if sender.data.eatCount > 0 then
		local oldLevel = self._heroData:getLoveLevel()

		self:closeAllScheduler()

		local params = {
			heroId = self._heroId,
			itemId = sender.data.itemId,
			amount = sender.data.eatCount
		}
		local addLove = (sender.data.extExp + sender.data.addExp) * sender.data.eatCount
		local showTip = self._heroData:getGiftTip(self._selectItemId)

		if sender.data.useSoundDes then
			local desc = ConfigReader:getDataByNameIdAndKey("Sound", sender.data.markSound, "SoundDesc")

			if desc then
				showTip = Strings:get(desc)
			end
		end

		self._gallerySystem:requestSendGift(params, function()
			if DisposableObject:isDisposed(self) then
				return
			end

			self:refreshData()

			if oldLevel ~= self._loveLevel then
				self:showUpAnim(Strings:get(showTip), addLove)
			else
				self:showDateToast(Strings:get(showTip), 2, addLove)
				self:getView():removeChildByName("LoveAnim")

				local anim = IconFactory:createLoveUpAnim(self._heroId, addLove, self._heroData:getModel())

				if anim then
					anim:addTo(self:getView())
					anim:setPosition(cc.p(230, 210))
					anim:setName("LoveAnim")
				end
			end

			self._touchCancel = false
		end)
	else
		self._touchCancel = false
	end
end

function GalleryGiftCellWidget:onSendGift(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		if not self._selectItem.data then
			return
		end

		self._offSetX = self:getTableViewOffsetX()
		self._touchAddCount = 0
		self._touchNode = self._selectItem
		self._canTouch = self:checkBeginEatCount(self._selectItem)

		if not self._canTouch then
			return
		end

		self:closeSleepScheduler()
		self:closeLongAddScheduler()
		self:touchBegin(self._selectItem)
	elseif eventType == ccui.TouchEventType.moved then
		if not self._selectItem.data then
			return
		end

		if not self._canTouch then
			return
		end

		if math.abs(self._offSetX - self:getTableViewOffsetX()) > 2 then
			self:closeSleepScheduler()
			self:closeLongAddScheduler()
		end
	elseif eventType == ccui.TouchEventType.canceled then
		if not self._selectItem.data then
			return
		end

		if not self._canTouch then
			return
		end

		self:closeSleepScheduler()
		self:closeLongAddScheduler()
		self:sendMessage(self._selectItem)
	elseif eventType == ccui.TouchEventType.ended then
		if not self._selectItem.data then
			self._meditor:dispatch(ShowTipEvent({
				tip = Strings:get("GALLERY_UI51")
			}))

			return
		end

		self:closeSleepScheduler()
		self:closeLongAddScheduler()

		if not self._canTouch then
			return
		end

		self:touchEnd(self._selectItem)
	end
end

function GalleryGiftCellWidget:onSendAllGift(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._heroSystem:isLoveLevelMax(self._heroId) then
			self._meditor:dispatch(ShowTipEvent({
				tip = Strings:get("GALLERY_UI41")
			}))

			return
		end

		selectType = SelectItemType.kForUse
		sender = self._selectItem
		title = Strings:get("UITitle_CH_Piliangshiyong")
		title1 = Strings:get("UITitle_EN_Piliangshiyong")

		local data = {
			selectType = selectType,
			title = title,
			title1 = title1,
			entryId = self._selectItem.data.id,
			desc = self._desc,
			useNewDesc = self._useNewDesc
		}
		local bagBatchUseSellMediator = self:getInjector():getInstance("BagBatchUseSellView")
		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				local itemId = data.itemId
				local eatCount = data.count

				if outSelf._heroSystem:isLoveLevelMax(outSelf._heroId) then
					outSelf._meditor:dispatch(ShowTipEvent({
						tip = Strings:get("GALLERY_UI41")
					}))

					return
				end

				local oldLevel = outSelf._heroData:getLoveLevel()

				outSelf:closeAllScheduler()

				local params = {
					heroId = outSelf._heroId,
					itemId = itemId,
					amount = eatCount
				}
				local addLove = (sender.data.extExp + sender.data.addExp) * eatCount
				local showTip = outSelf._heroData:getGiftTip(outSelf._selectItemId)

				outSelf._gallerySystem:requestSendGift(params, function()
					if DisposableObject:isDisposed(outSelf) then
						return
					end

					outSelf:refreshData()

					if oldLevel ~= outSelf._loveLevel then
						outSelf:showUpAnim(Strings:get(showTip), addLove)
					else
						outSelf:showDateToast(Strings:get(showTip), 2, addLove)
						outSelf:getView():removeChildByName("LoveAnim")

						local anim = IconFactory:createLoveUpAnim(outSelf._heroId, addLove, outSelf._heroData:getModel())

						if anim then
							anim:addTo(outSelf:getView())
							anim:setPosition(cc.p(230, 210))
							anim:setName("LoveAnim")
						end
					end

					outSelf._touchCancel = false
				end)
			elseif data.response == "cancel" then
				-- block empty
			elseif data.response == "close" then
				-- block empty
			end
		end

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, bagBatchUseSellMediator, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	end
end

function GalleryGiftCellWidget:stopEffect()
	if self._soundId then
		AudioEngine:getInstance():stopEffect(self._soundId)

		self._soundId = nil
	end

	if self._soundId1 then
		AudioEngine:getInstance():stopEffect(self._soundId1)

		self._soundId1 = nil
	end

	if self._soundEffectId then
		AudioEngine:getInstance():stopEffect(self._soundEffectId)

		self._soundEffectId = nil
	end
end

function GalleryGiftCellWidget:showUpAnim(str, addLove)
	local soundId = self._loveSound[self._loveLevel - 1]

	if soundId then
		local desc = ConfigReader:getDataByNameIdAndKey("Sound", soundId, "SoundDesc")

		str = Strings:get(desc)
	end

	self:showUi(false)

	local anim = self._upAnimPanel:getChildByFullName("UpAnim")

	if not anim then
		anim = cc.MovieClip:create("qian_haogandutisheng")

		anim:addTo(self._upAnimPanel)
		anim:setPosition(cc.p(693, 426))
		anim:setName("UpAnim")
		anim:addCallbackAtFrame(72, function()
			self._upAnimPanel:setTouchEnabled(true)
			anim:stop()
		end)

		local label1 = anim:getChildByFullName("label_1")
		local image1 = ccui.ImageView:create("xc_word_haogan.png", 1)

		image1:addTo(label1)

		local label2 = anim:getChildByFullName("label_2")
		local image2 = ccui.ImageView:create("xc_word_haogan.png", 1)

		image2:addTo(label2)
	end

	self._upAnimPanel:setTouchEnabled(false)
	anim:gotoAndPlay(0)

	if self._callbackAtFrame12 then
		anim:removeCallback(self._callbackAtFrame12)
	end

	self._callbackAtFrame12 = anim:addCallbackAtFrame(12, function()
		self:showDateToast(str, nil, addLove, true)
	end)
	self._soundEffectId = self._soundEffectId or AudioEngine:getInstance():playEffect("Se_Alert_Favor_Update", false, function()
		self._soundEffectId = nil
	end)
end

function GalleryGiftCellWidget:onClickUpPanel()
	if self._curExp == self._heroData:getLoveModule():getCurMaxExp() then
		if not self._loveLevel then
			local level = self._loveLevel - 1

			for i = self._loveLevelTemp, level do
				self:getUnlockData(i, level)
			end

			self._loveUpDataTemp = {}

			for i, v in pairs(self._loveUpData) do
				v.showIndex = i

				table.insert(self._loveUpDataTemp, v)
			end

			table.sort(self._loveUpDataTemp, function(a, b)
				return a.showIndex < b.showIndex
			end)

			if #self._loveUpDataTemp > 0 and not self._showLoveUp then
				self._showLoveUp = true

				if self._soundEffectId then
					AudioEngine:getInstance():stopEffect(self._soundEffectId)

					self._soundEffectId = nil
				end

				self._soundEffectId = AudioEngine:getInstance():playEffect("Se_Alert_Pop", false, function()
					self._soundEffectId = nil
				end)

				self._toastPanel:stopAllActions()
				self._toastPanel:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
					self._toastPanel:setOpacity(255)
					self._toastPanel:setVisible(false)
					self:showLoveUpView()
				end)))
			else
				self._loveLevelTemp = self._loveLevel
				self._loveUpData = {}

				self:showUi(true)

				self._showLoveUp = false
			end
		end
	end
end

function GalleryGiftCellWidget:showLoveUpView()
	local data = table.remove(self._loveUpDataTemp, 1)

	if data then
		function data.callback()
			self:showLoveUpView()
		end

		local view = self:getInjector():getInstance("GalleryLoveUpView")

		self._meditor:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, data, nil))
	else
		self._loveLevelTemp = self._loveLevel
		self._loveUpData = {}

		self:showUi(true)

		self._showLoveUp = false
	end
end

function GalleryGiftCellWidget:showDateToast(label, time, addLove, ignoreCallback)
	if label then
		local qipaoAnim = self._toastPanel:getChildByFullName("QiPaoAnim")

		if not qipaoAnim then
			local qipao = self._toastPanel:clone()

			qipao:setVisible(true)
			qipao:setPosition(cc.p(0, 0))
			qipao:setName("ToastPanel")
			self._toastPanel:removeAllChildren()

			qipaoAnim = cc.MovieClip:create("qipao_haogandutisheng")

			qipaoAnim:addTo(self._toastPanel)
			qipaoAnim:setName("QiPaoAnim")
			qipaoAnim:setPosition(cc.p(0, 0))
			qipaoAnim:addCallbackAtFrame(21, function()
				qipaoAnim:stop()
			end)

			self._qipaoAnimPanel = qipaoAnim:getChildByFullName("qipaoPanel")

			qipao:addTo(self._qipaoAnimPanel)
		end

		qipaoAnim:gotoAndPlay(0)
		self._toastPanel:stopAllActions()
		self._toastPanel:setVisible(true)

		local text = self._qipaoAnimPanel:getChildByFullName("ToastPanel.clipNode.text")

		text:setString(label)
		text:stopAllActions()
		text:setPosition(cc.p(self._primeTextPosX, self._primeTextPosY))
		self:setTextAnim()

		if not ignoreCallback then
			self._toastPanel:runAction(cc.Sequence:create(cc.DelayTime:create(time or 2), cc.FadeOut:create(0.2), cc.CallFunc:create(function()
				if DisposableObject:isDisposed(self) then
					return
				end

				self._toastPanel:setOpacity(255)
				self._toastPanel:setVisible(false)
			end)))
		else
			self._toastPanel:setOpacity(255)
		end
	end

	if addLove then
		self._addLove:setVisible(true)
		self._addLove:setString("+" .. addLove)
		self._addLove:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
			self._addLove:setVisible(false)
		end)))
	end
end

function GalleryGiftCellWidget:getUnlockData(levelStart, levelEnd)
	local loveLevel = levelStart

	self._upData = {}

	local bonusData = self._gallerySystem:getCurLoveExtraBonus(self._heroId, loveLevel)

	for i = 1, #bonusData do
		if bonusData[i].proportion == 1 then
			self._upData = bonusData[i]

			break
		end
	end

	local data = self._upData

	if table.nums(data) < 1 then
		return nil
	end

	local heroAttr = {
		DEF = self._heroData:getDefense(),
		ATK = self._heroData:getAttack(),
		HP = self._heroData:getHp(),
		SPEED = self._heroData:getSpeed()
	}

	self._upAnimPanel:setTouchEnabled(false)

	local desc = ""
	local attr = {}
	local params = data.param

	for i = 1, #params do
		local param = params[i]

		if type(param) == "string" then
			desc = desc == "" and param or desc .. "    " .. param
		else
			local attrType = param[3]

			attr[#attr + 1] = {
				value = heroAttr[attrType],
				addValue = param[2],
				type = attrType
			}
		end
	end

	local sounds = {}

	if levelStart == levelEnd and levelEnd ~= 1 then
		local soundList = self._heroSystem:getHeroSoundListById(self._heroId)

		for i = 1, #soundList do
			local sound = soundList[i].sound
			local conditions = sound:getUnlockCondition()

			if sound:getUnlock() then
				for j = 1, #conditions do
					local condition = conditions[j]

					if condition.HeroLove and condition.HeroLove == loveLevel + 1 then
						table.insert(sounds, sound)

						break
					end
				end
			end
		end
	end

	self._loveUpData[loveLevel] = {
		title = UnlockDescType[data.descType],
		desc = desc,
		attr = attr,
		sounds = sounds,
		model = self._heroData:getModel()
	}
end

function GalleryGiftCellWidget:showUiByEvent(event)
	local show = event:getData().show

	self:showUi(show)
end

function GalleryGiftCellWidget:showUi(show)
	self._sendGiftBtn:setTouchEnabled(show)
	self._sendGiftBtnAll:setTouchEnabled(show)
	self._upAnimPanel:setVisible(not show)
end

function GalleryGiftCellWidget:doViewSound()
	local soundId = ""

	if self._type == GalleryFuncName.kGift then
		local rarity = self._heroData:getRarity()

		if rarity > 12 then
			soundId = "Voice_" .. self._heroId .. "_36"
		else
			soundId = "Voice_" .. self._heroId .. "_22_1"

			local random = math.random(1, 2)

			if random == 2 then
				soundId = "Voice_" .. self._heroId .. "_22_2"
			end
		end
	elseif self._type == GalleryFuncName.kDate then
		soundId = "Voice_" .. self._heroId .. "_21"
	end

	if soundId ~= "" then
		local cfg = ConfigReader:getRecordById("Sound", id)

		if cfg then
			self._soundId = AudioEngine:getInstance():playRoleEffect(soundId, false)
		end
	end
end
