-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityShowSkinPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResActivityClientNewOpen = require("ClientData/ResActivityClientNewOpen")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResHero = require("ClientData/ResHero")
local UserData = require("Helper/UserData")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResClientConfirm = require("ClientData/ResClientConfirm")
local ResColor = require("ClientData/ResColor")
local NewSkinCell = Class("NewSkinCell", UIControls.Child)

function NewSkinCell:ctor()
	self.btn = UIControls.Button(self, "")
	self.bg = UIControls.Image(self, "Bg")
	self.imgHero = UIControls.Image(self, "ImgHeroPanel/ImgHero")
	self.imgMark = UIControls.Image(self, "ImgMark")
	self.imgOwned = UIControls.Panel(self, "ImgOwned")
	self.imgNewOpen = UIControls.Panel(self, "IconNewOpen")

	self.btn:addEventClick(self.onClick)

	self.groupType = UIConst.ACTIVITY_SHOW_GROUP.SKIN
end

function NewSkinCell:setData(groupInfo)
	self.data = groupInfo

	local skinId = groupInfo.param
	local skinObj = BaseObject.GetObject(skinId)

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

	self.isNewOpen = CurAvatar:_newOpenHasRedDot(self.data)

	self.imgNewOpen:setVisible(self.isNewOpen)
end

function NewSkinCell:setSelected(isSel)
	self.btn:setEnable(not isSel)
end

function NewSkinCell:setIconNew(isNew)
	self.imgNewOpen:setVisible(isNew)
end

function NewSkinCell:onClick()
	self:_onClick()
end

function NewSkinCell:_onClick(isInit)
	if self.mEventClick then
		self:mEventClick()
	end

	self:setSelected(true)

	if not isInit then
		if self.isNewOpen then
			self.isNewOpen = false

			self.imgNewOpen:setVisible(false)

			local groupType = self.groupType
			local actId = self.data.actId or 0
			local cachedData = UserData.getClientData(Const.USER_KEY_ACTIVITY_SHOW) or {}

			cachedData[groupType] = cachedData[groupType] or {}
			cachedData[groupType][actId] = cachedData[groupType][actId] or {}
			cachedData[groupType][actId][self.data.param] = true

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

local classNameStr = "ActivityShowSkinPage"
local ActivityShowSkinPage = Class(classNameStr, UIControls.Child)

MixinClass(ActivityShowSkinPage, ActivityPanelMixin)

function ActivityShowSkinPage:initUI()
	self.bg = UIControls.RawImage(self, "Bg")
	self.txtSkinName = UIControls.Label(self, "TextPanel/TextSkin")
	self.txtHeroName = UIControls.Label(self, "TextPanel/TextHero")
	self.txtTime = UIControls.Label(self, "BgTime/TextTime")
	self.btnGo = UIControls.Button(self, "BtnGo")
	self.btnPreview = UIControls.Button(self, "BtnPreview")
	self.imgOwned = UIControls.Panel(self, "ImgOwned")
	self.groupType = UIConst.ACTIVITY_SHOW_GROUP.SKIN

	self.btnGo:addEventClick(self.onBtnGo)
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

	self.panelExchange = UIControls.Panel(self, "ExchangeGiftPanel")
	self.btnExchangeBuy = UIControls.Button(self, "ExchangeGiftPanel/BtnBuy")

	self.btnExchangeBuy:addEventClick(self.onExchangeBuyClick)

	self.textExchangePrice = UIControls.Label(self, "ExchangeGiftPanel/BtnBuy/TextPrice")
	self.imgExchangeCurrency = UIControls.Image(self, "ExchangeGiftPanel/BtnBuy/TextPrice/IconCost")
	self.imgExchangeState = UIControls.Button(self, "ExchangeGiftPanel/ImgState")

	self.imgExchangeState:addEventClick(self.onExchangeFinishClick)

	self.panelExchangeGiftList = UIControls.Panel(self, "ExchangeGiftPanel/GiftListPanel")
	self.exchangeGrids = {}
	self.giftGrids = {}

	if UIControls.checkControlFunc(self, "BtnGo02") then
		self.btnGo2 = UIControls.Button(self, "BtnGo02", "Text")

		self.btnGo2:addEventClick(self.onBtnGo2)
	end
end

local function SortSkinPage(a, b)
	if a.skinOwned ~= b.skinOwned then
		return a.skinOwned < b.skinOwned
	elseif a.order and b.order then
		return a.order < b.order
	elseif a.order then
		return true
	end
end

function ActivityShowSkinPage:_setData()
	self.clientData = {}

	local groupData = ResActivityClientNewOpen[self.groupType]

	for _, groupInfo in pairs(groupData or {}) do
		local actId = groupInfo.actId

		if actId then
			local actObj = CurAvatar:getActivityObj(actId)

			if actObj and actObj:isValid() then
				CurAvatar:addActivityRelated(actId, "activityMainDlg")
				table.insert(self.clientData, groupInfo)
			end
		elseif ClientUtils.isNewSkinValid(groupInfo) then
			table.insert(self.clientData, groupInfo)
		end
	end

	for _, groupInfo in ipairs(self.clientData) do
		local skinId = groupInfo.param
		local skinObj = BaseObject.GetObject(skinId)

		if skinObj and skinObj:isGet() then
			groupInfo.skinOwned = 1
		else
			groupInfo.skinOwned = 0
		end
	end

	table.sort(self.clientData, SortSkinPage)
end

function ActivityShowSkinPage:_onShow(isOnPageShow)
	if not isOnPageShow then
		self:refreshCells()
	elseif self.skinCells[1] then
		self.skinCells[1]:onClick()
	end
end

function ActivityShowSkinPage:refreshCells()
	for i = #self.skinCells, #self.clientData do
		local cell = NewSkinCell(self, "ListPanel/Content", "System/Activity/ActivityNewSkinCell", 0, 0)

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

function ActivityShowSkinPage:onSkinSelected(sender)
	if self.curSelCell then
		self.curSelCell:setSelected(false)
	end

	self.curSelCell = sender

	self:refreshInfoPanel()
end

function ActivityShowSkinPage:refreshInfoPanel()
	self.actObj = nil
	self.product = nil
	self.rechargeId = nil

	if self.curSelCell then
		local skinObj = self.curSelCell.skinObj
		local heroName = ResHero[skinObj.heroID].hero_name
		local showData = self.curSelCell.data

		self.txtSkinName:setText(skinObj.name)
		self.txtHeroName:setText(heroName)

		if showData and showData.actId then
			local actObj = CurAvatar:getActivityObj(showData.actId)

			if actObj and actObj:isValid() then
				self.actObj = actObj
			end
		end

		if showData and showData.timer_txt then
			ClientTimerManager.RemoveSecondTickUI(self.txtTime)
			self.txtTime:setText(showData.timer_txt or "")
		elseif self.actObj then
			ClientTimerManager.RemoveSecondTickUI(self.txtTime)
			ClientTimerManager.AddSecondFormatTickUI(self.txtTime, self.actObj:getRemainOpenTime(), false, Lang.get(48657), Slot(self._timerOver, self))
		end

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

		if showData.show_type == 2 and self.actObj then
			self.panelGift:setVisible(true)
			self.panelExchange:setVisible(false)
			self.btnGo:setVisible(false)
			self.btnPreview:setVisible(true)
			self.imgOwned:setVisible(false)

			local gData = self.actObj.actData.detailData[1]

			if gData and gData.param then
				self.rechargeId = gData.param[1]

				if self.rechargeId then
					self.product = RechargeManager.getProductByRechargeId(self.rechargeId)

					if self.product then
						self.textBuyState:setText(self.product.priceText)
						self.btnBuy:setText(self.product.priceText)
						ClientUtils.CreateBonusGrid(self, self.giftGrids, "GiftPanel/GiftListPanel/Content", self.product.randId, true, nil, true, {
							isShowPreviewTips = true
						})
					end
				end
			end

			if self.actObj:isFinish() then
				self.imgBuyState:setVisible(true)
				self.btnBuy:setVisible(false)
			else
				self.imgBuyState:setVisible(false)
				self.btnBuy:setVisible(true)
			end
		elseif showData.show_type == 3 and self.actObj then
			self.panelGift:setVisible(false)
			self.panelExchange:setVisible(true)
			self.btnGo:setVisible(false)
			self.btnPreview:setVisible(true)
			self.imgOwned:setVisible(false)

			local shopItems = self.actObj.actData:getCurShopItem()

			if shopItems then
				self.shopItem = shopItems[1]

				if self.shopItem then
					local data = self.shopItem.data
					local moneyInfo = data.use[1]
					local moneyPath = ClientUtils.getMoneyIcon(moneyInfo.ID)

					if moneyPath then
						self.imgExchangeCurrency:setImage(moneyPath[1], moneyPath[2])
					end

					local totalMoney = moneyInfo.discount

					self.textExchangePrice:setText(totalMoney)

					local curValue = ClientUtils.getMoney(moneyInfo.ID)

					if curValue < totalMoney then
						self.textExchangePrice:setFontColor(ResColor.RED)
					end

					local items = {}

					for index = 2, #data.exchg do
						local clientItem = BaseObject.GetObject(data.exchg[index].key, data.exchg[index].value)

						table.insert(items, clientItem)
					end

					local showExchangeGiftList = #items > 0

					self.panelExchangeGiftList:setVisible(showExchangeGiftList)

					if showExchangeGiftList then
						ClientUtils.CreateBonusGridByItems(self, self.exchangeGrids, "ExchangeGiftPanel/GiftListPanel/Content", items)
					end
				end
			end

			if self.actObj:isFinish() then
				self.imgExchangeState:setVisible(true)
				self.btnExchangeBuy:setVisible(false)
			else
				self.imgExchangeState:setVisible(false)
				self.btnExchangeBuy:setVisible(true)
			end
		else
			self.btnGo:setVisible(not self.curSelCell.isOwned)
			self.btnPreview:setVisible(not self.curSelCell.isOwned)
			self.imgOwned:setVisible(self.curSelCell.isOwned)
			self.panelGift:setVisible(false)
			self.panelExchange:setVisible(false)
		end

		if self.btnGo2 then
			if showData.jump_id2 and showData.jump_desc2 and not self.curSelCell.isOwned then
				self.btnGo2:setVisible(true)
				self.btnGo2:setText(showData.jump_desc2)
			else
				self.btnGo2:setVisible(false)
			end
		end
	end
end

function ActivityShowSkinPage:_timerOver()
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	self.txtTime:setText(Lang.get(32785))
end

function ActivityShowSkinPage:onBtnGo()
	if self.curSelCell and self.curSelCell.data.jump_id then
		JumpGuideManager.jump(self.curSelCell.data.jump_id)
	end
end

function ActivityShowSkinPage:onBtnGo2()
	if self.curSelCell and self.curSelCell.data.jump_id2 then
		JumpGuideManager.jump(self.curSelCell.data.jump_id2)
	end
end

function ActivityShowSkinPage:onActivityDataRefresh(actObj)
	self:updateRelatedActivityData(actObj)
end

function ActivityShowSkinPage:updateRelatedActivityData(actObj)
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

function ActivityShowSkinPage:realBuySkin()
	CurAvatar:activityRPC(Functor(RechargeManager.startRecharge, self.rechargeId, nil, nil), self.actObj.opId)
end

function ActivityShowSkinPage:onBuyClick()
	if self.product and self.actObj and self.rechargeId then
		CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_CLICK_RECHARGE, self.rechargeId)

		if self.curSelCell and self.curSelCell.isOwned then
			local msgContent = utils.format(ResClientConfirm[1070].content, self.curSelCell.backNum)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, nil, msgContent, Functor(self.realBuySkin, self))
		else
			self:realBuySkin()
		end
	end
end

function ActivityShowSkinPage:onExchangeBuyClick()
	local ui = UIManager.getUI("skinBuyBox")

	ui:showShopItem(self.shopItem, self, Slot(self.exchangeBuy, self, self.shopItem.id))
	ui:bindWindow(self)
end

function ActivityShowSkinPage:exchangeBuy(exchgid)
	self.actObj.actData:onBuyCB(exchgid, 1)
end

function ActivityShowSkinPage:onExchangeFinishClick()
	MsgManager.notice(Lang.get(63946))
end

function ActivityShowSkinPage:onBtnPreview()
	if self.curSelCell then
		local skinData = self.curSelCell.skinObj.clientData

		if skinData then
			UIManager.getUI("skinPreviewTips"):setObject(skinData, self.curSelCell.skinObj)
		end
	end
end

function ActivityShowSkinPage:_onLeavePage()
	CueManager:stopVocal()
end

return ActivityShowSkinPage
