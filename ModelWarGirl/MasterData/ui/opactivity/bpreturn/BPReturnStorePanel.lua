-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\BPReturn\\BPReturnStorePanel.lua

local WelfarePanelBase = require("UI/Welfare/WelfarePanelBase")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResRandClient = require("ClientData/ResRandClient")
local BPReturnGiftCell = Class("BPReturnGiftCell", UIControls.ScrollViewLoopCell)

BPReturnGiftCell.colorLimit = {
	g = 0.3764705882352941,
	b = 0.3764705882352941,
	r = 0.3764705882352941
}
BPReturnGiftCell.colorNormal = {
	g = 1,
	b = 1,
	r = 1
}

function BPReturnGiftCell:ctor()
	self.btnPay = UIControls.Button(self, "")

	self.btnPay:addEventClick(self.onBtnPayClick)

	self.imgBg = UIControls.Image(self, "ContentPanel/Bg")
	self.imgIcon = UIControls.Image(self, "ContentPanel/Icon")
	self.textNum = UIControls.Label(self, "ContentPanel/BgNum/TextNum")
	self.textCurLv = UIControls.Label(self, "ContentPanel/BPLvPanel/TextNowNum")
	self.textPlanLv = UIControls.Label(self, "ContentPanel/BPLvPanel/TextPlanNum")
	self.textPrice = UIControls.Label(self, "ContentPanel/PricePanel/TextPrice")
	self.textLimit = UIControls.Label(self, "ContentPanel/TextLimit")
	self.imgArrow = UIControls.Image(self, "ContentPanel/BPLvPanel/BgArrow")

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "ContentPanel/PricePanel/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "ContentPanel/PricePanel/TextPt")

		self.priceDmmPanel:setVisible(true)
	end
end

function BPReturnGiftCell:setCellData(data, getBPStoreDataFunc)
	local product = RechargeManager.getProductByRechargeId(data.param[1])

	if not product then
		return
	end

	self.product = product
	self.rechargeId = product.rechargeId

	self.textPrice:setText(product.priceText)

	self.randData = ResRandClient[product.randId]

	if self.randData then
		self.buyPoint = self.randData.show_nums and self.randData.show_nums[1]

		self.textNum:setText(self.buyPoint)

		local needPoint, curLv, planLv = getBPStoreDataFunc(self.buyPoint)

		if curLv == -1 then
			self.textCurLv:setText(Lang.get(1699))
		elseif Const.REVIEW_VERSION then
			self.textCurLv:setText(Lang.get(1203) .. (curLv or 0))
		else
			self.textCurLv:setText("Lv." .. (curLv or 0))
		end

		if planLv == -1 then
			self.textPlanLv:setText(Lang.get(1699))
		else
			self.textPlanLv:setText(planLv)
		end

		self.needPoint = needPoint
	end

	self:levelUp2()
	self.textLimit:setText(string.format(Lang.get(52063), product.buyTimesLeft))

	if product.buyTimesLeft > 0 then
		self.imgBg:setImage("Atlas/ReturnAtlas/ReturnBPAtlas2", "BgPropBottom")
		self.imgIcon:setImageGray(false)
		self.imgArrow:setImageGray(false)
		self.textLimit:setColorByRGBA(self.colorNormal.r, self.colorNormal.g, self.colorNormal.b)
	else
		self.imgBg:setImage("Atlas/ReturnAtlas/ReturnBPAtlas3", "BgPropBottomDis")
		self.imgIcon:setImageGray(true)
		self.imgArrow:setImageGray(true)
		self.textLimit:setColorByRGBA(self.colorLimit.r, self.colorLimit.g, self.colorLimit.b)
	end
end

function BPReturnGiftCell:levelUp2()
	return
end

function BPReturnGiftCell:canBuy()
	if self.product.buyTimesMax then
		if self.mParent.svrData[self.rechargeId] then
			return self.product.buyTimesMax > self.mParent.svrData[self.rechargeId].count
		else
			return true
		end
	end

	return false
end

function BPReturnGiftCell:onShowPay()
	CurAvatar:activityRPC(Functor(RechargeManager.startRecharge, self.rechargeId, nil, nil), self.mParent.actObj.opId)

	local activityBattlePassDlg = UIManager.tryGetUI("activityBattlePassDlg")

	if activityBattlePassDlg then
		activityBattlePassDlg:setLvUpBoxEnable(true)
	end
end

function BPReturnGiftCell:onBtnPayClick()
	if not self:canBuy() then
		MsgManager.notice(Lang.get(30596))

		return
	end

	if self.buyPoint and self.needPoint then
		if self.buyPoint > self.needPoint then
			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), Lang.get(51412), Slot(self.onShowPay, self))
		else
			self:onShowPay()
		end
	end
end

local BPReturnStorePanel = Class("BPReturnStorePanel", WelfarePanelBase)

MixinClass(BPReturnStorePanel, ActivityPanelMixin)

function BPReturnStorePanel:ctor()
	self.productData = {}
	self.btnClose = UIControls.Button(self, "Bg/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.txtBpPoint = UIControls.Label(self, "Bg/BPFullTips/TextBPPoint")
	self.scrollGiftList = UIControls.ScrollViewLoopH(self, "Bg/GiftList", 0, self.onGiftCellChanged)
	self.panelFullStore = UIControls.Panel(self, "Bg/FullStorePanel")

	self.panelFullStore:setVisible(false)

	self.btnFullStore = UIControls.Button(self, "Bg/FullStorePanel/BtnFullStore")

	self.btnFullStore:addEventClick(self.onStoreClick)
end

function BPReturnStorePanel:onStoreClick()
	return
end

function BPReturnStorePanel:onCloseClick()
	self.mParent:setVisible(false)
end

function BPReturnStorePanel:_setData()
	self.clientData = {}

	local detailData = self.actObj.actData.clientData

	self.svrData = self.actObj.actData.serverData

	for _, dDate in pairs(detailData) do
		self.clientData[#self.clientData + 1] = dDate
	end

	table.sort(self.clientData, function(a, b)
		local productA = RechargeManager.getProductByRechargeId(a.param[1])
		local productB = RechargeManager.getProductByRechargeId(b.param[1])

		if productA and productB then
			return productA.price < productB.price
		end

		return false
	end)

	self.getBPStoreData = self.actObj.getBPStoreData

	self.scrollGiftList:setTotalCount(#self.clientData)

	local needPoint = self.getBPStoreData()

	if needPoint then
		if needPoint >= 0 then
			self.txtBpPoint:setText(needPoint)
		elseif needPoint < 0 then
			self.txtBpPoint:setText(0)
			self.panelFullStore:setVisible(true)
		end
	end
end

function BPReturnStorePanel:onGiftCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = BPReturnGiftCell(sender, "System/Return/BPGiftItem", newIdx, 0, 0)
	else
		targetCell.mIndex = newIdx
	end

	targetCell:setCellData(self.clientData[newIdx], self.getBPStoreData)
end

function BPReturnStorePanel:refreshActivityData()
	self:onCloseClick()
end

function BPReturnStorePanel:updateActivityData()
	self:_setData()
end

return BPReturnStorePanel
