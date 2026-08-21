-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivitySingleGiftPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local RechargeManager = require("System/Recharge/RechargeManager")
local classNameStr = "ActivitySingleGiftPage"
local ActivitySingleGiftPage = Class(classNameStr, UIControls.Child)

MixinClass(ActivitySingleGiftPage, ActivityPanelMixin)

function ActivitySingleGiftPage:initUI()
	self.textTime = UIControls.Label(self, "TextTime")
	self.txtLimit = UIControls.Label(self, "TextLimit")
	self.panelState = UIControls.Panel(self, "ImgState")
	self.btnConfirm = UIControls.Button(self, "BtnFunc", "TextPrice")
	self.panelLimit = UIControls.Panel(self, "BgLimit")
	self.imgLimit = UIControls.MaterialProgress(self, "BgLimit/ImgBar")

	self.btnConfirm:addEventClick(self._onClickConfirm)

	self.awardItems = {}

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "BtnFunc/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "BtnFunc/TextPt")

		self.priceDmmPanel:setVisible(true)
	end

	if UIControls.checkControlFunc(self, "BtnAddress") then
		self.btnAddress = UIControls.Button(self, "BtnAddress")

		self.btnAddress:addEventClick(self.onBtnAddressClick)
	end
end

function ActivitySingleGiftPage:_onShow(isOnPageShow)
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_ACT, self.clientTemplateData.template_id)

	if isOnPageShow then
		self:_setData()
	end
end

function ActivitySingleGiftPage:_setData(pageData)
	local detailData = self.actObj.actData.clientData
	local svrData = self.actObj.actData.serverData

	for idx, dDate in pairs(detailData) do
		self.rechargeId = dDate.param[1]
		self.svrData = svrData and svrData[self.rechargeId] or {
			count = 0
		}

		break
	end

	local Product = RechargeManager.getProductByRechargeId(self.rechargeId)

	if not Product then
		return
	end

	self:_setUI(Product)
	self:_setItems(Product.randId)
end

function ActivitySingleGiftPage:_setUI(product)
	local buyTimesLeft = product.buyTimesMax - self.svrData.count

	if buyTimesLeft ~= 0 then
		local limitValue = buyTimesLeft / product.buyTimesMax

		self.imgLimit:setValue(limitValue)
		self.txtLimit:setText(buyTimesLeft)
		self.btnConfirm:setText(product.priceText)
		self.btnConfirm:setVisible(true)
		self.panelState:setVisible(false)
		self.panelLimit:setVisible(true)
	else
		self.btnConfirm:setVisible(false)
		self.panelState:setVisible(true)
		self.panelLimit:setVisible(false)
	end
end

function ActivitySingleGiftPage:_setItems(randId)
	ClientUtils.CreateBonusGrid(self, self.awardItems, "GiftPanel", randId, true, 6, true)

	local awardData = ResRandClient[randId] or {}
	local show_flag = awardData.show_flag or {}

	for idx, container in ipairs(self.awardItems) do
		if container.grid then
			container.grid.isShowPreviewTips = true
		end

		if show_flag[idx] and show_flag[idx] >= 1 then
			container:setSpe(true, 3, show_flag[idx])
		else
			container:setSpe(false)
		end
	end
end

function ActivitySingleGiftPage:onActivityDataRefresh(actObj)
	self:_setData()
end

function ActivitySingleGiftPage:_onClickConfirm()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_CLICK_RECHARGE, self.rechargeId)
	CurAvatar:activityRPC(Functor(RechargeManager.startRecharge, self.rechargeId, nil, nil), self.actObj.opId)
end

function ActivitySingleGiftPage:onBtnAddressClick()
	UIManager.getUI("editAdressDlg", true):setData()
end

return ActivitySingleGiftPage
