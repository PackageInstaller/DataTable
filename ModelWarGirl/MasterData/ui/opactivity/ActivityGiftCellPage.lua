-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityGiftCellPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResActivityClientGiftCell = require("ClientData/ResActivityClientGiftCell")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResHero = require("ClientData/ResHero")
local UserData = require("Helper/UserData")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResClientConfirm = require("ClientData/ResClientConfirm")
local ResColor = require("ClientData/ResColor")
local ResPushGiftPkg = require("ClientData/ResPushGiftPkg")
local EventConst = require("EventConst")
local ActivityGiftPageCell = Class("ActivityGiftPageCell", UIControls.Child)

function ActivityGiftPageCell:ctor()
	self.btn = UIControls.Button(self, "")
	self.bg = UIControls.Image(self, "Bg")
	self.imgHero = UIControls.Image(self, "ImgHeroPanel/ImgHero")
	self.imgMark = UIControls.Image(self, "ImgMark")
	self.imgOwned = UIControls.Panel(self, "ImgOwned")
	self.imgNewOpen = UIControls.Panel(self, "IconNewOpen")

	self.btn:addEventClick(self.onClick)
end

function ActivityGiftPageCell:setData(clientData)
	self.serverData = clientData[1]
	self.clientData = clientData[2]
	self.data = clientData[3]
	self.skinId = self.data.skin_item_id

	local skinObj = BaseObject.GetObject(self.skinId)

	self.skinObj = skinObj

	if skinObj then
		local iconPath = skinObj:getSkinHeadIconPath()
		local qualityicon = skinObj:getQualityIconPath()
		local qualityBg = skinObj:getQualityBgPath()

		self.isOwned = skinObj:isGet()
		self.backNum = skinObj:getSkinBackNum()

		if iconPath and iconPath[1] and iconPath[2] then
			self.imgHero:setImage(iconPath[1], iconPath[2])
		end

		if qualityicon and qualityicon[1] and qualityicon[2] then
			self.imgMark:setImage(qualityicon[1], qualityicon[2])
		end

		self.imgOwned:setVisible(self.isOwned)

		if qualityBg and qualityBg[1] and qualityBg[2] then
			self.bg:setImage(qualityBg[1], qualityBg[2])
		end
	end

	local cachedData = UserData.getClientData(Const.USER_KEY_ACTIVITY_SHOW) or {}

	cachedData = cachedData.GiftCellPage or {}

	if not cachedData[self.skinId] and not CurAvatar:hasGetHeroSkin(self.skinId) then
		self.isNewOpen = true
	else
		self.isNewOpen = false
	end

	self.imgNewOpen:setVisible(self.isNewOpen)
end

function ActivityGiftPageCell:setSelected(isSel)
	self.btn:setEnable(not isSel)
end

function ActivityGiftPageCell:onClick()
	self:_onClick()
end

function ActivityGiftPageCell:_onClick(isInit)
	if self.mEventClick then
		self:mEventClick()
	end

	self:setSelected(true)

	if not isInit then
		if self.isNewOpen then
			self.isNewOpen = false

			self.imgNewOpen:setVisible(false)

			local actId = self.data.actId or 0
			local cachedData = UserData.getClientData(Const.USER_KEY_ACTIVITY_SHOW) or {}

			cachedData.GiftCellPage = cachedData.GiftCellPage or {}
			cachedData.GiftCellPage[self.skinId] = true

			UserData.setClientData(Const.USER_KEY_ACTIVITY_SHOW, cachedData)

			local activityMainDlg = UIManager.tryGetUI("activityMainDlg")

			if activityMainDlg then
				activityMainDlg:onRefreshMainBanner()
			end
		end

		if self.data.voice_id then
			CueManager.playGroupVocal(self.data.voice_id)
		end
	end
end

local classNameStr = "ActivityGiftCellPage"
local ActivityGiftCellPage = Class(classNameStr, UIControls.Child)

MixinClass(ActivityGiftCellPage, ActivityPanelMixin)

function ActivityGiftCellPage:initUI()
	self.bg = UIControls.RawImage(self, "Bg")
	self.txtSkinName = UIControls.Label(self, "TextPanel/TextSkin")
	self.txtHeroName = UIControls.Label(self, "TextPanel/TextHero")
	self.txtTime = UIControls.Label(self, "ImgNewcomer/TextTime")
	self.btnPreview = UIControls.Button(self, "BtnPreview")

	self.btnPreview:addEventClick(self.onBtnPreview)

	self.skinCells = {}
	self.panelGift = UIControls.Panel(self, "GiftPanel")
	self.btnBuy = UIControls.Button(self, "GiftPanel/BtnBuy", "TextPrice")

	self.btnBuy:addEventClick(self.onBuyClick)

	self.imgBuyState = UIControls.Button(self, "GiftPanel/ImgState")
	self.textBuyState = UIControls.Label(self, "GiftPanel/ImgState/TextPrice")

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "GiftPanel/ImgState/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "GiftPanel/ImgState/TextPt")

		self.priceDmmPanel:setVisible(true)
	end

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "GiftPanel/BtnBuy/TextPt") then
		self.priceBuyDmmPanel = UIControls.Panel(self, "GiftPanel/BtnBuy/TextPt")

		self.priceBuyDmmPanel:setVisible(true)
	end

	self.giftGrids = {}
end

local function SortSkinPage(a, b)
	return a[1].start_time > b[1].start_time
end

function ActivityGiftCellPage:_setData()
	self.clientData = {}

	local pushGifts = CurAvatar:getPushGift(true)

	for rechargeId, giftServerData in pairs(pushGifts) do
		local giftClientData = ResPushGiftPkg[giftServerData.gift_id]
		local pageId = giftClientData.client_page_id

		if ResActivityClientGiftCell[pageId] then
			table.insert(self.clientData, {
				giftServerData,
				giftClientData,
				ResActivityClientGiftCell[pageId]
			})
		end
	end

	table.sort(self.clientData, SortSkinPage)

	self._slot4ProductLoaded = Slot(self.resetUI, self)

	EventCenter.addEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
end

function ActivityGiftCellPage:resetUI()
	self:refreshInfoPanel()
end

function ActivityGiftCellPage:_onShow(isOnPageShow)
	if not isOnPageShow then
		self:refreshCells()
	elseif self.skinCells[1] then
		self.skinCells[1]:onClick()
	end
end

function ActivityGiftCellPage:refreshCells()
	for i = #self.skinCells, #self.clientData do
		local cell = ActivityGiftPageCell(self, "ListPanel/Content", "System/Activity/ActivityNewcomerSkinCell", 0, 0)

		self.skinCells[i] = cell
		self.skinCells[i].mEventClick = Slot(self.onSkinSelected, self)
	end

	for i = 1, #self.skinCells do
		if self.clientData[i] then
			self.skinCells[i]:setData(self.clientData[i])
			self.skinCells[i]:setVisible(true)
		else
			self.skinCells[i]:setVisible(false)
		end
	end

	if self.skinCells[1] then
		self.skinCells[1]:_onClick(true)
	end
end

function ActivityGiftCellPage:onSkinSelected(sender)
	if self.curSelCell then
		self.curSelCell:setSelected(false)
	end

	self.curSelCell = sender

	self:refreshInfoPanel()
end

function ActivityGiftCellPage:_onClosePanel()
	EventCenter.removeEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
end

function ActivityGiftCellPage:refreshInfoPanel()
	self.product = nil
	self.rechargeId = nil

	if self.curSelCell then
		local serverData = self.curSelCell.serverData
		local skinObj = self.curSelCell.skinObj
		local heroName = ResHero[skinObj.heroID].hero_name
		local showData = self.curSelCell.data

		self.txtSkinName:setText(skinObj.name)
		self.txtHeroName:setText(heroName)

		local newPushGifts = CurAvatar:getPushGift(true)

		if showData.timer_color then
			local timeColor = showData.timer_color

			self.txtTime:setColorByRGBA(timeColor[1] / 255, timeColor[2] / 255, timeColor[3] / 255, 1)
		end

		if showData.spec_icon_path then
			self.bg:setImage("NoAlpha/Activity/BgNewSkin/" .. showData.spec_icon_path)
		end

		if showData.skin_name_color then
			local skinColor = showData.skin_name_color

			self.txtSkinName:setColorByRGBA(skinColor[1] / 255, skinColor[2] / 255, skinColor[3] / 255, 1)
		end

		if showData.hero_name_color then
			local heroColor = showData.hero_name_color

			self.txtHeroName:setColorByRGBA(heroColor[1] / 255, heroColor[2] / 255, heroColor[3] / 255, 1)
		end

		self.rechargeId = serverData.recharge_id

		if not newPushGifts[self.rechargeId] then
			ClientTimerManager.RemoveSecondTickUI(self.txtTime)
			self.txtTime:setText(Lang.get(96613))

			for _, grid in ipairs(self.giftGrids) do
				grid:setGet(true)
			end

			self.imgBuyState:setVisible(true)
			self.btnBuy:setVisible(false)
		else
			local remainTime = serverData.endTime - ClientUtils.getServerTime()

			ClientTimerManager.RemoveSecondTickUI(self.txtTime)
			ClientTimerManager.AddSecondFormatTickUI(self.txtTime, remainTime, false, "%s", Slot(self._timerOver, self))

			self.product = RechargeManager.getProductByRechargeId(self.rechargeId)

			if self.product then
				self.textBuyState:setText(self.product.priceText)
				self.btnBuy:setText(self.product.priceText)
				ClientUtils.CreateBonusGrid(self, self.giftGrids, "GiftPanel/GiftListPanel/Content", self.product.randId, true, nil, true, {
					isShowPreviewTips = true
				})

				for _, grid in ipairs(self.giftGrids) do
					grid:setGet(false)
				end

				self.imgBuyState:setVisible(false)
				self.btnBuy:setVisible(true)
			end
		end
	end
end

function ActivityGiftCellPage:_timerOver()
	self.txtTime:setText(Lang.get(653))
end

function ActivityGiftCellPage:updateRelatedActivityData(actObj)
	for index, cell in ipairs(self.skinCells) do
		if cell.data and cell.data.actId == actObj.actId then
			cell:setData(cell.data)

			break
		end
	end

	if self.curSelCell and self.curSelCell.data.actId == actObj.actId then
		self:refreshInfoPanel()
	end
end

function ActivityGiftCellPage:realBuySkin()
	RechargeManager.startRecharge(self.rechargeId)
end

function ActivityGiftCellPage:onBuyClick()
	if self.product then
		local serverData = self.curSelCell.serverData
		local remainTime = serverData.endTime - ClientUtils.getServerTime()

		if remainTime < 0 then
			MsgManager.notice(Lang.get(96614))

			return
		end

		if self.curSelCell and self.curSelCell.isOwned then
			local msgContent = utils.format(ResClientConfirm[1070].content, self.curSelCell.backNum)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, nil, msgContent, Functor(self.realBuySkin, self))
		else
			self:realBuySkin()
		end
	end
end

function ActivityGiftCellPage:onBtnPreview()
	if self.curSelCell then
		local skinData = self.curSelCell.skinObj.clientData

		if skinData then
			UIManager.getUI("skinPreviewTips"):setObject(skinData, self.curSelCell.skinObj)
		end
	end
end

function ActivityGiftCellPage:_onLeavePage()
	CueManager:stopVocal()
end

return ActivityGiftCellPage
