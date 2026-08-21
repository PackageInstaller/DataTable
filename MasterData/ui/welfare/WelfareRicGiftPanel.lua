-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\WelfareRicGiftPanel.lua

local welfareBase = require("UI/Welfare/WelfarePanelBase")
local ResRandClient = require("ClientData/ResRandClient")
local RechargeManager = require("System/Recharge/RechargeManager")
local EventConst = require("EventConst")
local ResVIP = require("ClientData/ResVIP")
local ResClientHardCode = require("ClientData/ResClientHardCode")
local ResRedPacketShow = require("ClientData/ResRedPacketShow")
local GiftCell = Class("GiftCell", UIControls.Child)

function GiftCell:ctor()
	self.imgSource = UIControls.Image(self, "")
	self.imgIcon = UIControls.Image(self, "ContentPanel/Icon")
	self.txtPrice = UIControls.Label(self, "ContentPanel/PricePanel/TextPrice")
	self.imgSp = UIControls.Image(self, "ContentPanel/IconSp")
	self.imgGet = UIControls.Image(self, "ContentPanel/GetPanel/Icon")
	self.txtGet = UIControls.Label(self, "ContentPanel/GetPanel/TextNum")
	self.giftPanel = UIControls.Panel(self, "ContentPanel/GiftPanel")
	self.imgGift = UIControls.Image(self, "ContentPanel/GiftPanel/Icon")
	self.txtGift = UIControls.Label(self, "ContentPanel/GiftPanel/TextNum")
	self.btnBuy = UIControls.Button(self, "")

	self.btnBuy:addEventClick(self.onClickBuy)

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "ContentPanel/PricePanel/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "ContentPanel/PricePanel/TextPt")

		self.priceDmmPanel:setVisible(true)
	end

	if UIControls.checkControlFunc(self, "ContentPanel/IconGroupon") then
		self.iconGroupon = UIControls.Image(self, "ContentPanel/IconGroupon")
	end
end

function GiftCell:setData(data, isLastOne)
	self.data = data

	if isLastOne == true then
		self.imgSource:setImage("Atlas/StoreAtlas/StoreGiftAtlas2", "BgRechargeYellow")
	else
		self.imgSource:setImage("Atlas/StoreAtlas/StoreGiftAtlas2", "BgRechargeWhite")
	end

	self.imgIcon:setImage("Atlas/" .. data.iconPath, data.iconName)

	local moneyInfo = UIConst.MONEY_ID2INFO[Const.MONEY_ID_DIAMOND]

	self.imgGet:setImage(moneyInfo[1], moneyInfo[2])
	self.imgGift:setImage(moneyInfo[1], moneyInfo[2])
	self.txtGet:setText(data.rechargeNum)
	self.txtPrice:setText(data.priceText)

	if data.isFirstRecharge == true then
		self.imgSp:setVisible(true)
		self.txtGift:setText(data.firstBonus)
	else
		self.imgSp:setVisible(false)
		self.txtGift:setText(data.normalBonus)
	end

	if self.iconGroupon then
		local giftDrawData = CurAvatar:checkShowActGiftDrawIcon(data)

		if giftDrawData and giftDrawData.gear_icon_path then
			self.iconGroupon:setImage(giftDrawData.gear_icon_path, giftDrawData.gear_icon)
			self.iconGroupon:setVisible(true)
		else
			self.iconGroupon:setVisible(false)
		end
	end
end

function GiftCell:onClickBuy()
	if self.mEventClick then
		self:mEventClick(self.data)
	end
end

local strClassName = "WelfareRicGiftPanel"
local WelfareRicGiftPanel = Class(strClassName, welfareBase)

function WelfareRicGiftPanel:ctor()
	self.cells = {}

	self:initUI()

	self._slot4ClickCell = Slot(self.onCellClick, self)
	self._slot4LoadEnd = Slot(self.refreshMixinData, self)

	EventCenter.removeEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4LoadEnd)
	EventCenter.addEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4LoadEnd)
end

function WelfareRicGiftPanel:initUI()
	self.btnRedMoney = UIControls.Button(self, "BtnRedMoney")

	self.btnRedMoney:addEventClick(self.onBtnRedMoneyClick)

	self.btnVip = UIControls.Button(self, "BtnVIP")

	self.btnVip:addEventClick(self.onBtnVipClick)

	self.redHintVip = UIControls.RedDot(self, "BtnVIP/IconNew")

	self.redHintVip:addHint({
		UIConst.RD_HINT_FUNCENTRY_DIAMOND
	})

	self.imgVip = UIControls.Image(self, "BtnVIP/IconVIP")
	self.imgFull = UIControls.Image(self, "BtnVIP/VIPPointSlider/FillArea/Fill")
	self.img4Slider = UIControls.Image(self, "BtnVIP/VIPPointSlider/ProgressPanel/Icon")
	self.txtVip = UIControls.Label(self, "BtnVIP/TextVIP")
	self.slider = UIControls.Slider(self, "BtnVIP/VIPPointSlider", "ProgressPanel/Text")

	if RegionUtils.isKR() then
		self.btnVip:setVisible(true)
	else
		self.btnVip:setVisible(false)
	end
end

function WelfareRicGiftPanel:onBtnRedMoneyClick()
	local activityPrivilegePreviewDlg = UIManager.getUI("activityPrivilegePreviewDlg", true)
end

function WelfareRicGiftPanel:refreshMixinData()
	CurAvatar:refreshGiftUI(self.giftType)
	self:refreshData()
end

function WelfareRicGiftPanel:refreshData()
	self.Data = {}
	self.giftType = self.panelConfigData.pageType

	local giftData = CurAvatar:getGiftData(self.giftType)

	if giftData and giftData.gifts then
		for _, v in pairs(giftData.gifts) do
			self.Data[#self.Data + 1] = v
		end

		table.sort(self.Data, function(a, b)
			return a.rechargeId < b.rechargeId
		end)
		self:refreshUI()
	end

	if self.btnVip:getVisible() then
		self:refreshVipUI()
	end

	local redPackageObj = CurAvatar:getRedPackageActivity()

	if redPackageObj then
		self.btnRedMoney:setVisible(true)

		local redPacketShowType = ResClientHardCode[13].value[1]

		if redPacketShowType and redPacketShowType ~= 1 and ResRedPacketShow[redPacketShowType] then
			local imgPath = ResRedPacketShow[redPacketShowType].buytip_image_path
			local imgName = ResRedPacketShow[redPacketShowType].buytip_image_name

			self.btnRedMoney:setImage(imgPath, imgName)
		end
	else
		self.btnRedMoney:setVisible(false)
	end
end

function WelfareRicGiftPanel:refreshUI()
	for i = #self.cells + 1, #self.Data do
		if not self.cells[i] then
			self.cells[i] = GiftCell(self, "RechargePanel", "System/Common/Grid/GridStoreRecharge", 0, 0)
		end
	end

	for idx, cell in ipairs(self.cells) do
		if self.Data[idx] then
			local isLastOne = false

			if idx == #self.Data then
				isLastOne = true
			end

			cell:setData(self.Data[idx], isLastOne)

			cell.mEventClick = self.onCellClick

			cell:setVisible(true)
		else
			cell:setVisible(false)
		end
	end
end

function WelfareRicGiftPanel:refreshVipUI(...)
	local srvData = CurAvatar:getVipSrvData()
	local level = 0

	for i = Const.VIP_MAX_LEVEL, 0, -1 do
		local info = ResVIP[i]

		if srvData.value >= info.need_exp then
			level = i

			break
		end
	end

	local data = CurAvatar:getVipClientData(level)

	self.txtVip:setText(level)

	local moneyInfo = UIConst.MONEY_ID2INFO[Const.MONEY_ID_VIP_POINT]

	self.img4Slider:setImage(moneyInfo[1], moneyInfo[2])

	if ResVIP[level + 1] then
		self.slider:setText(string.format("%d/%d", srvData.value, ResVIP[level + 1].need_exp))
	end

	self.imgVip:setImage("Atlas/StoreAtlas/" .. data.icon_path, data.icon_name)
	self.imgVip:setObjGray(false)

	local state = 0

	if data.need_exp > srvData.value then
		if ResVIP[level - 1] then
			state = ResVIP[level - 1].need_exp <= srvData.value and 1 or 0
		end

		self.slider:setValue(0)
		self.slider:setText("")
		self.imgVip:setObjGray(true)
	else
		state = 2

		if ResVIP[level + 1] then
			if ResVIP[level + 1].need_exp > srvData.value then
				self.slider:setValue(srvData.value / ResVIP[level + 1].need_exp)
			else
				self.slider:setText(Lang.get(98))
				self.slider:setValue(1)
			end
		end
	end

	if not ResVIP[level + 1] then
		if state == 2 then
			self.slider:setText(srvData.value)
			self.slider:setValue(1)
			self.imgFull:setImage("Atlas/StoreAtlas/StoreVIPAtlas", "BgExpMax")
		end
	else
		self.imgFull:setImage("Atlas/StoreAtlas/StoreVIPAtlas", "BgExp")
	end
end

function WelfareRicGiftPanel:onBtnVipClick(...)
	local ui = UIManager.getUI("rechargeVipDlg", true)

	if ui then
		ui:onShow(31, 61)
	end
end

function WelfareRicGiftPanel:onOpenPanel()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_MALL, self.panelConfigData.id)
	self:refreshData()
end

function WelfareRicGiftPanel:onClosePanel()
	WelfareRicGiftPanel.super.onClosePanel(self)
end

function WelfareRicGiftPanel:onCellClick(data)
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_CLICK_RECHARGE, data.rechargeId)
	RechargeManager.startRecharge(data.rechargeId, nil, nil)
end

function WelfareRicGiftPanel:onDestroy()
	EventCenter.removeEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4LoadEnd)
end

return WelfareRicGiftPanel
