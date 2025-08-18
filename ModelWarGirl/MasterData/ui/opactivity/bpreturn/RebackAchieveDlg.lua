-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\BPReturn\\RebackAchieveDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local RebackAchieveGiftCell = Class("RebackAchieveGiftCell", UIControls.Panel)

function RebackAchieveGiftCell:ctor()
	self.btnSensor = UIControls.Button(self, self.mPath)

	self.btnSensor:addEventClick(self.onSensorClick)

	self.panelNml = UIControls.Panel(self, self.mPath .. "/BuyNmlState")
	self.textPrice = UIControls.Label(self, self.mPath .. "/BuyNmlState/BgPrice/TextPrice")
	self.panelDis = UIControls.Panel(self, self.mPath .. "/BuyDisState")

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, self.mPath .. "/BuyNmlState/BgPrice/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, self.mPath .. "/BuyNmlState/BgPrice/TextPt")

		self.priceDmmPanel:setVisible(true)
	end
end

function RebackAchieveGiftCell:setData(product, giftActObj)
	self.product = product

	local count = giftActObj.actData:getHasBuyNum(product.rechargeId)

	self.giftActObj = giftActObj
	self.buyTimesLeft = product.buyTimesMax - count

	self.panelNml:setVisible(self.buyTimesLeft > 0)
	self.panelDis:setVisible(self.buyTimesLeft <= 0)
	self.textPrice:setText(product.priceText)
end

function RebackAchieveGiftCell:onSensorClick()
	if self.buyTimesLeft > 0 then
		local ui = UIManager.getUI("giftBuyBox")

		ui:showShopItem(self.product, self, nil, nil, self.giftActObj)
		ui:bindWindow(self.mWindow)
		ui:setVisible(true)
	end
end

local strClassName = "RebackAchieveDlg"
local RebackAchieveDlg = Class(strClassName, UIControls.Window)

MixinClass(RebackAchieveDlg, ActivityPanelMixin)

local MAX_GIFT_NUM = 3

function RebackAchieveDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickClose)

	self.textTime = UIControls.Label(self, "BgPanel/BgTime/TxtTime")
	self.gridAwards = {}
	self.btnGetAchieve = UIControls.Button(self, "BgPanel/BtnGetAll", "Text")

	self.btnGetAchieve:addEventClick(self.onGetAchieveClick)

	self.imgNewGetAchieve = UIControls.Panel(self, "BgPanel/BtnGetAll/IconNew")
	self.giftCells = {}

	for index = 1, MAX_GIFT_NUM do
		local newCell = RebackAchieveGiftCell(self, "BgPanel/GiftPanel/BtnGift" .. index)

		table.insert(self.giftCells, newCell)
	end
end

function RebackAchieveDlg:onClickClose()
	self:setVisible(false)
end

function RebackAchieveDlg:onGetAchieveClick()
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.actObj.opId, 1, self.achieveType), self.actObj.opId)
end

function RebackAchieveDlg:_setData()
	local tempData = self.actObj.templateData or {}

	self.giftActId = tonumber(tempData.relate_act and tempData.relate_act[1] or 0)
	self.relateGiftObj = CurAvatar:getActivityObj(self.giftActId)

	if self.giftActId and self.relateGiftObj then
		CurAvatar:addActivityRelated(self.giftActId, self.mUIName)
	end

	self:refrehData()
end

function RebackAchieveDlg:refrehData()
	local actData = self.actObj.actData

	for aType, aData in pairs(actData.clientData or {}) do
		self.achieveType = aType

		break
	end

	if not self.achieveType then
		return
	end

	self.achieveData = actData.clientData[self.achieveType][1]

	local bonusId = self.achieveData.award

	ClientUtils.CreateBonusGrid(self, self.gridAwards, "BgPanel/AwardPanel", bonusId, true, 4, true)

	local state = actData:getAchieveState(self.achieveType, 1)

	for _, grid in ipairs(self.gridAwards) do
		grid:setGet(state == Const.ACT_ACHIEVE_STATE_GOT)
	end

	if state == Const.ACT_ACHIEVE_STATE_GOT then
		self.btnGetAchieve:setEnable(false)
		self.btnGetAchieve:setText(Lang.get(74))
		self.imgNewGetAchieve:setVisible(false)
	elseif state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.btnGetAchieve:setEnable(true)
		self.imgNewGetAchieve:setVisible(true)
	else
		self.btnGetAchieve:setEnable(false)
		self.imgNewGetAchieve:setVisible(false)
	end

	if self.relateGiftObj then
		local allProducts = self.relateGiftObj.actData:getAllProduct() or {}

		for index, cell in ipairs(self.giftCells) do
			if allProducts[index] then
				cell:setVisible(true)
				cell:setData(allProducts[index][1], self.relateGiftObj)
			else
				cell:setVisible(false)
			end
		end
	else
		for index, cell in ipairs(self.giftCells) do
			cell:setVisible(false)
		end
	end
end

function RebackAchieveDlg:updateActivityData()
	self:refrehData()
end

return RebackAchieveDlg
