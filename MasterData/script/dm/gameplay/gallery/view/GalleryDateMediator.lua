-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryDateMediator.lua

GalleryDateMediator = class("GalleryDateMediator", DmAreaViewMediator, _M)

GalleryDateMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryDateMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")

local kBtnHandlers = {
	["main.datePanel.dateBtn"] = {
		ignoreClickAudio = true,
		func = "onClickDate"
	},
	["main.presentPanel.sendBtn"] = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onSendGift"
	},
	["main.presentPanel.emptyNode.taskBtn"] = {
		eventType = 4,
		clickAudio = "Se_Click_Common_1",
		func = "onTaskBtnClicked"
	},
	["main.presentPanel.emptyNode.shopBtn"] = {
		eventType = 4,
		clickAudio = "Se_Click_Common_1",
		func = "onShopBtnClicked"
	}
}
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

function GalleryDateMediator:initialize()
	super.initialize(self)
end

function GalleryDateMediator:dispose()
	self:closeAllScheduler()

	if self._toastPanel then
		self._toastPanel:stopAllActions()
	end

	super.dispose(self)
end

function GalleryDateMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshBySync)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_GALLERY_DATE_RESETR_SUCC, self, self.refreshBySync)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_GALLERY_UI_SHOW, self, self.showUiByEvent)
end

function GalleryDateMediator:enterWithData(data)
	self:initData(data)
	self:initWidgetInfo()
	self:initView()
	self:setupClickEnvs()
	self:setupTopInfoWidget()
end

function GalleryDateMediator:resumeWithData()
	return
end

function GalleryDateMediator:refreshBySync()
	self:closeAllScheduler()
	self:refreshData()
	self:refreshView()
end

function GalleryDateMediator:initData(data)
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

function GalleryDateMediator:updateGiftsData()
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

function GalleryDateMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._upAnimPanel = self._main:getChildByFullName("upAnimPanel")

	self._upAnimPanel:setVisible(false)
	self._upAnimPanel:setSwallowTouches(true)
	self._upAnimPanel:addClickEventListener(function()
		self:onClickUpPanel()
	end)

	self._bonusPanel = self:getView():getChildByFullName("bonusPanel")

	self._bonusPanel:setVisible(false)

	self._toastPanel = self._main:getChildByFullName("toastPanel")

	self._toastPanel:setVisible(false)

	local bg = self._toastPanel:getChildByFullName("bg")

	bg:ignoreContentAdaptWithSize(true)

	self._primeTextPosX = self._toastPanel:getChildByFullName("clipNode.text"):getPositionX()
	self._primeTextPosY = self._toastPanel:getChildByFullName("clipNode.text"):getPositionY()

	self._toastPanel:getChildByFullName("clipNode.text"):getVirtualRenderer():setDimensions(330, 0)

	self._heroPanel = self._main:getChildByFullName("heroPanel")
	self._talkPanel = self._main:getChildByFullName("talkPanel")
	self._datePanel = self._main:getChildByFullName("datePanel")
	self._presentPanel = self._main:getChildByFullName("presentPanel")
	self._emptyNode = self._presentPanel:getChildByFullName("emptyNode")

	self._emptyNode:setVisible(false)

	self._itemTip = self._presentPanel:getChildByFullName("itemTip")

	self._itemTip:setVisible(false)

	self._lovePanel = self._main:getChildByFullName("lovePanel")
	self._loadingBar = self._lovePanel:getChildByName("loading")
	self._loveExpLabel = self._lovePanel:getChildByName("loveExp")
	self._addLove = self._lovePanel:getChildByName("addLove")

	self._addLove:setVisible(false)

	self._sendGiftBtn = self._presentPanel:getChildByFullName("sendBtn")
	self._rewardTip = self._lovePanel:getChildByName("rewardTip")

	self._rewardTip:setVisible(false)
	self._loadingBar:setScale9Enabled(true)
	self._loadingBar:setCapInsets(cc.rect(1, 1, 1, 1))

	self._touchPanel = self:getView():getChildByFullName("touchPanel")

	self._touchPanel:setTouchEnabled(true)
	self._touchPanel:setSwallowTouches(false)
	self._touchPanel:addClickEventListener(function()
		if self._bonusPanel:isVisible() then
			self._bonusPanel:setVisible(false)
		end
	end)
	GameStyle:setCommonOutlineEffect(self._itemTip:getChildByFullName("panel.desc"))
end

function GalleryDateMediator:initView()
	self._heroPanel:removeAllChildren()

	local img = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = self._heroData:getModel()
	})

	self._heroPanel:addChild(img)
	img:setPosition(cc.p(self._heroPanel:getContentSize().width / 2 + 50, self._heroPanel:getContentSize().height / 2 - 110))
	self:doViewSound()

	if self._type == GalleryFuncName.kGift then
		self._talkPanel:setVisible(false)
		self._datePanel:setVisible(false)
		self._presentPanel:setVisible(true)
		self:initGiftView()
		self:refreshGiftView()
		self:showDateToast(Strings:get(self._heroData:getGiftGreetingDesc()), 10)
	elseif self._type == GalleryFuncName.kDate then
		self._datePanel:setVisible(true)
		self._presentPanel:setVisible(false)
		self:refreshDateView()
	end

	self:refreshLove()

	local maxImage = self._lovePanel:getChildByName("maxImage")

	maxImage:setTouchEnabled(true)
	maxImage:addClickEventListener(function()
		if self._heroSystem:hasHero(self._heroId) then
			self:onClickBonus(maxImage, self._attrData, true)
		end
	end)
	self._sendGiftBtn:setVisible(#self._heroGifts > 0)
end

function GalleryDateMediator:showDateToast(label, time, addLove, ignoreCallback)
	local HideVoice = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HideVoice", "content")
	local isHide = table.indexof(HideVoice, self._heroId)

	if label and not isHide then
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

function GalleryDateMediator:setTextAnim()
	local clipNode = self._qipaoAnimPanel:getChildByFullName("ToastPanel.clipNode")
	local text = self._qipaoAnimPanel:getChildByFullName("ToastPanel.clipNode.text")
	local textSizeHeight = text:getContentSize().height
	local clipNodeSizeHeight = clipNode:getContentSize().height

	if textSizeHeight > clipNodeSizeHeight - 5 then
		local offset = textSizeHeight - clipNodeSizeHeight + 10

		text:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.MoveTo:create(2.5 * (offset / 25), cc.p(self._primeTextPosX, self._primeTextPosY + offset))))
	end
end

function GalleryDateMediator:showItemTip()
	if not self._selectItem.data then
		self._itemTip:setVisible(false)

		return
	end

	self._itemTip:setVisible(true)

	local item = self._selectItem.data
	local panel = self._itemTip:getChildByName("panel")
	local name = panel:getChildByName("name")

	name:setString(item.name)
	name:disableEffect(1)
	GameStyle:setQualityText(name, item.quality)

	local desc = panel:getChildByName("desc")

	desc:setString(Strings:get("GALLERY_UI44", {
		num = item.addExp
	}))
	desc:removeAllChildren()

	if item.markIcon and item.extExp ~= 0 then
		desc:setString("")

		if item.extExp > 0 then
			if not ("+" .. item.extExp) then
				do
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
					local descControl = ccui.RichText:createWithXML(str, {})

					descControl:setAnchorPoint(cc.p(0, 1))
					desc:addChild(descControl)
					descControl:setPosition(cc.p(0, desc:getContentSize().height))
					ajustRichTextCustomWidth(descControl, 205)
				end

				local targetNode = self._selectItem.targetNode

				if targetNode then
					local targetPos = targetNode:getParent():convertToWorldSpace(cc.p(targetNode:getPosition()))
					local posX = self._itemTip:getParent():convertToNodeSpace(targetPos).x + 61

					self._itemTip:setPositionX(posX)
				end
			end
		end
	end
end

function GalleryDateMediator:refreshInnerAttrPanel(data, title)
	local titleAttr = self._bonusPanel:getChildByFullName("title_attr")

	titleAttr:setVisible(false)

	local titleInfo = self._bonusPanel:getChildByFullName("title_info")

	titleInfo:setVisible(false)

	local titleTotal = self._bonusPanel:getChildByFullName("title_total")

	titleTotal:setVisible(false)

	local textLabel = self._bonusPanel:getChildByName("text_clone")

	textLabel:setVisible(false)

	local list = data.param

	if title and #list == 0 then
		self._bonusPanel:setVisible(false)

		return
	end

	local panel = self._bonusPanel:getChildByName("panel")

	panel:removeAllChildren()

	local height = 40
	local posY = 15

	if title then
		titleTotal:setVisible(true)

		local length = math.ceil(#list / 2)

		for i = 1, length do
			local node = textLabel:clone()

			for j = 1, 2 do
				local index = 2 * (i - 1) + j
				local str = list[index]

				if str then
					local text = node:getChildByFullName("text_" .. j)
					local attr = node:getChildByFullName("attr_" .. j)

					text:setVisible(true)
					text:setString(str[1])
					attr:setVisible(true)
					attr:setString(str[2])

					local image = text:getChildByFullName("image")

					image:setVisible(true)
					image:loadTexture(AttrTypeImage[str[3]], 1)
				end
			end

			node:setVisible(true)
			node:addTo(panel)
			node:setPosition(cc.p(0, posY + (length - i) * 35))

			height = height + 30
		end

		titleTotal:setPositionY(posY + length * 30 + 15)

		height = height + 30

		self._bonusPanel:getChildByName("imageBg"):setContentSize(cc.size(302, height))
	else
		local infoList = {}
		local attrList = {}

		for key, value in pairs(list) do
			if type(value) == "table" then
				attrList[#attrList + 1] = {
					value[1],
					value[2],
					value[3]
				}
			else
				infoList[#infoList + 1] = value
			end
		end

		if #attrList > 0 then
			titleAttr:setVisible(true)

			local length = math.ceil(#attrList / 2)

			for i = 1, length do
				local node = textLabel:clone()

				for j = 1, 2 do
					local index = 2 * (i - 1) + j
					local str = attrList[#attrList + 1 - index]

					if str then
						local text = node:getChildByFullName("text_" .. j)
						local attr = node:getChildByFullName("attr_" .. j)

						text:setVisible(true)
						text:setString(str[1])
						attr:setVisible(true)
						attr:setString(str[2])

						local image = text:getChildByFullName("image")

						image:setVisible(true)
						image:loadTexture(AttrTypeImage[str[3]], 1)
					end
				end

				node:setVisible(true)
				node:addTo(panel)
				node:setPosition(cc.p(0, posY + (i - 1) * 30))

				height = height + 30
			end

			titleAttr:setPositionY(posY + length * 30 + 15)

			posY = posY + (length + 1) * 30 + 25
			height = height + 30
		end

		if #infoList > 0 then
			titleInfo:setVisible(true)

			local node = textLabel:clone()
			local str = ""

			for i = 1, #infoList do
				str = str .. infoList[i] .. "      "
			end

			node:getChildByFullName("text_1"):setVisible(true)
			node:getChildByFullName("text_1"):setString(str)

			if getCurrentLanguage() ~= GameLanguageType.CN then
				node:getChildByFullName("text_1"):setPositionX(-4)
				node:getChildByFullName("text_1"):setFontSize(17)
			end

			node:setVisible(true)
			node:addTo(panel)
			node:setPosition(cc.p(0, posY))

			height = height + 30

			titleInfo:setPositionY(posY + 30 + 15)

			height = height + 55
		end

		self._bonusPanel:getChildByName("imageBg"):setContentSize(cc.size(302, height))
	end
end

function GalleryDateMediator:initGiftView()
	local itemList = self._presentPanel:getChildByName("itemList")

	itemList:removeAllChildren()

	local size_W = 113
	local size_H = itemList:getContentSize().height

	local function scrollViewDidScroll(view)
		self._isReturn = false

		local targetNode = self._selectItem.targetNode

		if targetNode and self._itemTip:isVisible() then
			local targetPos = targetNode:getParent():convertToWorldSpace(cc.p(targetNode:getPosition()))
			local posX = self._itemTip:getParent():convertToNodeSpace(targetPos).x + 61

			if posX < 78 then
				posX = 78
			elseif posX > 926 then
				posX = 926
			end

			self._itemTip:setPositionX(posX)
		end
	end

	local function cellSizeForTable(table, idx)
		return size_W, size_H
	end

	local function numberOfCellsInTableView(table)
		return #self._heroGifts
	end

	local function tableCellRecycle(table, cell)
		local targetNodeTag = self._selectItem.targetNodeTag
		local targetNode = self._selectItem.targetNode

		if targetNode and targetNodeTag == cell:getTag() then
			self._selectItem.targetNode = nil
		end
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

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
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

function GalleryDateMediator:createCell(cell, idx)
	cell:removeAllChildren()

	local data = self._heroGifts[idx]
	local icon = IconFactory:createIcon({
		id = data.id,
		amount = data.allCount
	}, {
		showAmount = true
	})

	icon:addTo(cell)
	icon:setPosition(cc.p(58, 77))
	icon:setScale(0.78)

	local layer = ccui.Layout:create()

	layer:setAnchorPoint(cc.p(0.5, 0.5))
	layer:setPosition(cc.p(58, 80))
	layer:addTo(cell)

	layer.data = data
	layer.icon = icon

	layer:setTouchEnabled(true)
	layer:setContentSize(cc.size(100, 100))
	layer:addTouchEventListener(function(sender, eventType)
		self:onEatItemClicked(sender, eventType)
	end)
	layer:setSwallowTouches(false)

	cell.layer = layer

	local markIcon = data.markIcon

	if markIcon then
		local markImg = ccui.ImageView:create(markIcon, 1)

		markImg:addTo(cell)
		markImg:setPosition(cc.p(99, 108))
	end

	if self._selectItem.data then
		if self._selectItem.data.id == data.id then
			self._selectItem = {
				data = data,
				targetNode = cell,
				targetNodeTag = cell:getTag(),
				icon = icon
			}

			local image = ccui.ImageView:create("img_xiangce_xuanzhong.png", 1)

			image:addTo(layer):center(layer:getContentSize()):offset(-0.5, -3.5)
			image:setName("SelectImage")
		end
	elseif idx == 1 then
		self._selectItem = {
			data = data,
			targetNode = cell,
			targetNodeTag = cell:getTag(),
			icon = icon
		}

		local image = ccui.ImageView:create("img_xiangce_xuanzhong.png", 1)

		image:addTo(layer):center(layer:getContentSize()):offset(-0.5, -3.5)
		image:setName("SelectImage")
	end
end

function GalleryDateMediator:refreshData()
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

function GalleryDateMediator:refreshGiftView()
	local showEmptyNode = #self._heroGifts == 0

	self._emptyNode:setVisible(showEmptyNode)
	self._presentPanel:getChildByName("remainTime"):setVisible(not showEmptyNode)

	local offsetX = self._giftView:getContentOffset().x

	self._giftView:reloadData()
	self._giftView:setContentOffset(cc.p(offsetX, 0))
	self:showItemTip()
end

function GalleryDateMediator:refreshDateView()
	local loveModule = self._heroData:getLoveModule()
	local conversation = ""

	if not self._gallerySystem:isHeroTodayDate(self._heroId) then
		self._datePanel:getChildByName("remainTime"):setString(Strings:get("GALLERY_UI21", {
			times = self._dateTimes
		}))

		conversation = loveModule:getDateGreetingDesc()

		self._talkPanel:setVisible(true)
	else
		self._datePanel:getChildByName("remainTime"):setString(Strings:get("GALLERY_UI38"))

		conversation = loveModule:getDateRefuseDesc()

		self._talkPanel:setVisible(false)
	end

	local name, _ = self._heroData:getName()

	self._talkPanel:getChildByName("name"):setString(name)
	self._talkPanel:getChildByName("conversation"):setString(Strings:get(conversation))
end

function GalleryDateMediator:refreshView()
	self:refreshLove()

	if self._type == GalleryFuncName.kGift then
		self:refreshGiftView()
		self._sendGiftBtn:setVisible(#self._heroGifts > 0)
	elseif self._type == GalleryFuncName.kDate then
		self:refreshDateView()
	end
end

function GalleryDateMediator:refreshLove()
	local progress = self._loveExp / self._heroData:getLoveModule():getCurMaxExp() * 100

	self._loveExpLabel:setString(self._loveExp .. "/" .. self._heroData:getLoveModule():getCurMaxExp())
	self._loadingBar:setPercent(progress)
	self._lovePanel:getChildByFullName("loveLevel"):setString(self._loveLevel)

	local soundId = self._loveSound[self._loveLevel - 1]

	if self._type == GalleryFuncName.kGift and soundId and (self._oldLoveLevel ~= self._loveLevel or self._oldLoveLevel == self._loveLevel and self._loveExp == 0) then
		self:stopEffect()

		self._soundId = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
			self._soundId = nil
		end)
		self._oldLoveLevel = self._loveLevel
	end

	local max = self._heroSystem:isLoveLevelMax(self._heroId)

	if max then
		self._loadingBar:setPercent(100)
		self._loveExpLabel:setString(Strings:get("GALLERY_UI33"))
	end

	local name, _ = self._heroData:getName()

	self._lovePanel:getChildByFullName("heroName"):setString(name)

	local bonusData = self._gallerySystem:getCurLoveExtraBonus(self._heroId, self._loveLevel)
	local loading = self._loadingBar

	loading:removeAllChildren()

	for i = 1, #bonusData do
		local data = bonusData[i]
		local rewardTip = self._rewardTip:clone()

		rewardTip:setVisible(data.proportion > 0)
		rewardTip:addTo(loading)

		local icon = rewardTip:getChildByFullName("icon")

		icon:setTouchEnabled(true)
		icon:addClickEventListener(function()
			self:onClickBonus(icon, data)
		end)
		rewardTip:setPosition(cc.p(loading:getContentSize().width * data.proportion, -31.5))

		if data.proportion == 1 then
			rewardTip:offset(-2, 0)
		end

		local fullBg = rewardTip:getChildByFullName("fullBg")
		local fullBgEnd = rewardTip:getChildByFullName("fullBgEnd")
		local full = rewardTip:getChildByFullName("full")

		full:setVisible(max or progress >= data.proportion * 100)
		fullBg:setVisible(data.proportion < 1)
		fullBgEnd:setVisible(data.proportion == 1)

		local heroNode = rewardTip:getChildByFullName("hero")
		local heroImg = IconFactory:createRoleIconSpriteNew({
			id = self._heroData:getModel()
		})

		heroImg:addTo(heroNode):center(heroNode:getContentSize()):setScale(0.2)
	end
end

function GalleryDateMediator:onClickBack()
	self:stopEffect()
	self:dismiss()
end

function GalleryDateMediator:onClickDate()
	if self._gallerySystem:isHeroTodayDate(self._heroId) then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = Strings:get("GALLERY_UI38")
		}))

		return
	elseif self._dateTimes == 0 then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = Strings:get("GALLERY_UI39")
		}))

		return
	elseif not self._heroData:getDateStory() then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Source_General_Unknown")
		}))

		return
	end

	self:stopEffect()
	AudioEngine:getInstance():playEffect("Se_Click_Date", false)
	self._gallerySystem:setDateOptions({})

	local dateData = self._heroData:getDateStory()
	local storyIndex, storyId = dateData.storyIndex, dateData.storyId
	local storyOption = dateData.option

	self._gallerySystem:setCurDate({
		heroData = self._heroData,
		storyIndex = storyIndex,
		storyId = storyId,
		storyOption = storyOption
	})

	local function endCallBack()
		local settingSystem = self:getInjector():getInstance(SettingSystem)
		local mainBgMuisId = settingSystem:getCurBGMusicId()

		if mainBgMuisId and mainBgMuisId ~= "" then
			AudioEngine:getInstance():playBackgroundMusic(mainBgMuisId)
		end

		local options, loves = self._gallerySystem:getDateOptionsValue()
		local params = {
			heroId = self._heroId,
			storyIndex = storyIndex,
			options = options
		}
		local addLove = loves

		self._gallerySystem:requestHeroDate(params, function()
			self:dispatch(ShowTipEvent({
				tip = Strings:get("GALLERY_UI42")
			}))
			self:getView():removeChildByName("LoveAnim")

			if not self._heroSystem:isLoveLevelMax(self._heroId) then
				local anim = IconFactory:createLoveUpAnim(self._heroId, addLove, self._heroData:getModel())

				if anim then
					anim:addTo(self:getView())
					anim:setPosition(cc.p(568, 250))
					anim:setName("LoveAnim")
				end
			end

			self._gallerySystem:setDateOptions({})
		end)
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local storyAgent = storyDirector:getStoryAgent()

	storyAgent:setSkipCheckSave(true)
	storyAgent:trigger(storyId, nil, endCallBack)
end

function GalleryDateMediator:onTaskBtnClicked()
	local taskSystem = self:getInjector():getInstance("TaskSystem")

	taskSystem:tryEnter({
		tabType = 1
	})
end

function GalleryDateMediator:onShopBtnClicked()
	local shopSystem = self:getInjector():getInstance("ShopSystem")

	shopSystem:tryEnter({
		shopId = "Shop1"
	})
end

function GalleryDateMediator:getTableViewOffsetX()
	local oldOffset = self._giftView:getContentOffset()

	return oldOffset.x
end

function GalleryDateMediator:onEatItemClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

		self._selectItemId = sender.data.itemId

		local var_44_0 = {
			data = sender.data,
			targetNode = sender:getParent()
		}

		var_44_0.targetNodeTag = sender:getParent():getTag()
		var_44_0.icon = sender.icon
		self._selectItem = var_44_0

		local offsetX = self:getTableViewOffsetX()

		self._giftView:reloadData()
		self._giftView:setContentOffset(cc.p(offsetX, 0))
		self:showItemTip()
	end
end

function GalleryDateMediator:refreshLvlLabel(level)
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

function GalleryDateMediator:refreshProgrView(nowExp, endExp)
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

function GalleryDateMediator:playEffect()
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

function GalleryDateMediator:checkBeginEatCount(sender)
	if self._heroSystem:isLoveLevelMax(self._heroId) then
		self:dispatch(ShowTipEvent({
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

function GalleryDateMediator:createNeedExp()
	self._maxExpNeed = self._heroSystem:getMaxLevelCost(self._heroId)
end

function GalleryDateMediator:canEatItem(itemNode, hasTip)
	local data = itemNode.data

	if data.allCount == 0 or data.allCount == data.eatCount then
		return false
	end

	if self._addExp >= self._maxExpNeed then
		return false
	end

	return true
end

function GalleryDateMediator:touchBegin(sender)
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

function GalleryDateMediator:createLongAddSch(sender)
	self:closeSleepScheduler()

	local time = 1

	self:createSleepScheduler(time, sender)
end

function GalleryDateMediator:touchEnd(sender)
	self:eatOneItem(self._touchNode)
	self:sendMessage(sender)
end

function GalleryDateMediator:touchSleepEnd(sender)
	self:closeSleepScheduler()
	self:createProgrScheduler(sender)
	self:eatOneItem(self._touchNode)

	local time = self:getSpeedByItemCount(self._touchAddCount, sender)

	self:createLongAddScheduler(time, sender)
end

function GalleryDateMediator:longAdd(sender)
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

function GalleryDateMediator:getSpeedByItemCount(count, sender)
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

function GalleryDateMediator:getCostNumByItemCount(count, sender)
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

function GalleryDateMediator:eatOneItem(sender)
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

function GalleryDateMediator:refreshEatNode(sender)
	local data = sender.data
	local itemIcon = self._selectItem.icon
	local targetNode = self._selectItem.targetNode

	if targetNode then
		itemIcon:setAmount(data.allCount - data.eatCount)
	end
end

function GalleryDateMediator:progrShow(sender)
	if self._previewProgrState and not self._touchCancel then
		self:progrPreviewShow(sender)
	else
		self:progrNormalShow(false, sender)
	end
end

function GalleryDateMediator:checkCanEatItem(nextExp, sender)
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

function GalleryDateMediator:refreshEatOnceExp(nextExp)
	self._eatOnceExp = (nextExp - self._curExp) / self._seeTime

	if self._eatOnceExp > self._eatExp then
		self._eatOnceExp = self._eatExp
	end

	self._eatOnceExp = self._eatOnceExp < 1 and 1 or self._eatOnceExp
	self._eatOnceExp = math.modf(self._eatOnceExp)
end

function GalleryDateMediator:progrNormalShow(closeCheck, sender)
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

function GalleryDateMediator:progrPreviewShow()
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

local progrSleepTime = 0.02

function GalleryDateMediator:createProgrScheduler(sender)
	self:closeProgrScheduler()

	if self._progrScheduler == nil then
		self._progrScheduler = LuaScheduler:getInstance():schedule(function()
			self:progrShow(sender)
		end, progrSleepTime, false)
	end
end

function GalleryDateMediator:closeProgrScheduler()
	if self._progrScheduler then
		LuaScheduler:getInstance():unschedule(self._progrScheduler)

		self._progrScheduler = nil
	end
end

function GalleryDateMediator:createSleepScheduler(time, sender)
	self:closeSleepScheduler()

	if self._sleepScheduler == nil then
		self._sleepScheduler = LuaScheduler:getInstance():schedule(function()
			self:touchSleepEnd(sender)
		end, time, false)
	end
end

function GalleryDateMediator:closeSleepScheduler()
	if self._sleepScheduler then
		LuaScheduler:getInstance():unschedule(self._sleepScheduler)

		self._sleepScheduler = nil
	end
end

function GalleryDateMediator:createLongAddScheduler(time, sender)
	self:closeLongAddScheduler()

	if self._longAddScheduler == nil then
		self._longAddScheduler = LuaScheduler:getInstance():schedule(function()
			self:longAdd(sender)
		end, time, false)
	end
end

function GalleryDateMediator:closeLongAddScheduler()
	if self._longAddScheduler then
		LuaScheduler:getInstance():unschedule(self._longAddScheduler)

		self._longAddScheduler = nil
	end
end

function GalleryDateMediator:closeAllScheduler()
	self:closeLongAddScheduler()
	self:closeSleepScheduler()
	self:closeProgrScheduler()
end

function GalleryDateMediator:sendMessage(sender)
	if self._heroSystem:isLoveLevelMax(self._heroId) then
		self:dispatch(ShowTipEvent({
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
					anim:setPosition(cc.p(916, 260))
					anim:setName("LoveAnim")
				end
			end

			self._touchCancel = false

			self:setupGuideRevEnvs("Guide_GALLERY_SEND_GIF_SUC")
		end)
	else
		self._touchCancel = false
	end
end

function GalleryDateMediator:onClickBonus(sender, data, showTitle)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local targetPos = sender:getParent():convertToWorldSpace(cc.p(sender:getPosition()))

	self._bonusPanel:setVisible(true)
	self:refreshInnerAttrPanel(data, showTitle)

	local imageBg = self._bonusPanel:getChildByFullName("imageBg")
	local posX = self._bonusPanel:getParent():convertToNodeSpace(targetPos).x
	local posY = self._bonusPanel:getParent():convertToNodeSpace(targetPos).y + (180 - imageBg:getContentSize().height)

	if showTitle then
		posX = self._bonusPanel:getParent():convertToNodeSpace(targetPos).x + 150
		posY = posY + 20
	end

	self._bonusPanel:setPosition(cc.p(posX, posY))
end

function GalleryDateMediator:onSendGift(sender, eventType)
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
			self:dispatch(ShowTipEvent({
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

function GalleryDateMediator:stopEffect()
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

function GalleryDateMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function GalleryDateMediator:showUpAnim(str, addLove)
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

function GalleryDateMediator:onClickUpPanel()
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

function GalleryDateMediator:showLoveUpView()
	local data = table.remove(self._loveUpDataTemp, 1)

	if data then
		function data.callback()
			self:showLoveUpView()
		end

		local view = self:getInjector():getInstance("GalleryLoveUpView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, data, nil))
	else
		self._loveLevelTemp = self._loveLevel
		self._loveUpData = {}

		self:showUi(true)

		self._showLoveUp = false
	end
end

function GalleryDateMediator:getUnlockData(levelStart, levelEnd)
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

function GalleryDateMediator:showUiByEvent(event)
	local show = event:getData().show

	self:showUi(show)
end

function GalleryDateMediator:showUi(show)
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setVisible(show)
	self._lovePanel:setVisible(show)
	self._presentPanel:setVisible(show)
	self._upAnimPanel:setVisible(not show)
end

function GalleryDateMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		if self._giftView then
			local cellOne = self._giftView:cellAtIndex(0)

			if cellOne then
				local giftBtn = self:getView():getChildByFullName("main.presentPanel.sendBtn")

				storyDirector:setClickEnv("GalleryDateMediator.giftBtn", giftBtn, function(sender, eventType)
					self:onSendGift(sender, ccui.TouchEventType.began)
					self:onSendGift(sender, eventType)
				end)

				local layerOne = cellOne.layer

				storyDirector:setClickEnv("GalleryDateMediator.cellOne", cellOne, function(sender, eventType)
					self:onEatItemClicked(layerOne, eventType)
				end)
			end
		end

		storyDirector:notifyWaiting("enter_GalleryDateMediator")
	end))

	self:getView():runAction(sequence)
end

function GalleryDateMediator:setupGuideRevEnvs(name)
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting(name)
end

function GalleryDateMediator:doViewSound()
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
