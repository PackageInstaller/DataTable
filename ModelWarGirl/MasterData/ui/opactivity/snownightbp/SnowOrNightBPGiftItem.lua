-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SnowNightBP\\SnowOrNightBPGiftItem.lua

local BPGiftCell = require("UI/OpActivity/BPGiftCell")
local strClassName = "SnowOrNightBPGiftItem"
local SnowOrNightBPGiftItem = Class(strClassName, BPGiftCell)

function SnowOrNightBPGiftItem:initUI()
	self.uiAni = UIControls.UIAni(self, "")
	self.starLockPanel = UIControls.Panel(self, "LockPanel")
	self.imgStar = UIControls.Image(self, "UnLockText/Image")
	self.payGiftPanel = UIControls.Panel(self, "PayGiftPanel")
	self.imgBgPay = UIControls.Image(self, "PayGiftPanel/BgImage")
	self.btnConfirmPay = UIControls.Button(self, "PayGiftPanel/BtnConfirm", "Text")

	self.btnConfirmPay:addEventClick(self.onBtnPayClick)

	self.txtBuyCount = UIControls.Label(self, "PayGiftPanel/PayNum")
	self.imgSoldOutPay = UIControls.Panel(self, "PayGiftPanel/SoldOutImage")
	self.gridSoldOutBlack = UIControls.Panel(self, "SoldOutBlack")
	self.slider = UIControls.Slider(self, "Slider")
	self.efxUnLock = UIControls.LazyEffectPlayer(self, "EfxUnLock")
	self.freeItems = {}
	self.payItems = {}
	self.resPath = "Atlas/ActivityAtlas/ActivitySnowOrNightBP12204Atlas"

	if self.mParent.replaceableCellPath and self.mParent.replaceableCellPath[2] then
		self.resPath = "Atlas/ActivityAtlas/" .. self.mParent.replaceableCellPath[2]
	end

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "PayGiftPanel/BtnConfirm/TextPt") then
		self.textPt = UIControls.Label(self, "PayGiftPanel/BtnConfirm/TextPt")

		self.textPt:setVisible(true)
	end

	self.resName = "/SnowOrNightBPGiftAtlas"
end

function SnowOrNightBPGiftItem:setData(data, svrData, objGift, rechargeId, lastAchieveData, newIdx)
	self.actId = self.mParent.actObj.actId
	self.data = data
	self.svrData = svrData
	self.rechargeId = rechargeId
	self.objGift = objGift
	self.state = svrData:getAchieveState(data.type, data.index)

	self.starLockPanel:setVisible(self.state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH)
	self:refreshPayPart(objGift, rechargeId)
	self:refreshHeroPart()

	if lastAchieveData then
		self.slider:setVisible(true)

		local progress = self.mParent.actData:getAchieveProgress(data.type)
		local showProgress = math.max(progress - lastAchieveData.param, 0) / math.max(data.param - lastAchieveData.param, 0)

		self.slider:setValue(math.min(showProgress, 1))
	else
		self.slider:setVisible(false)
	end
end

function SnowOrNightBPGiftItem:refreshPayPart(objGift, rechargeId)
	SnowOrNightBPGiftItem.super.refreshPayPart(self, objGift, rechargeId)
	self.gridSoldOutBlack:setVisible(self.canBuyCount <= 0)

	local starAlpha = self.canBuyCount <= 0 and 60 or 255

	self.imgStar:setColorAlpha(starAlpha)
end

function SnowOrNightBPGiftItem:setPayPartLockShow()
	self.starLockPanel:setVisible(true)
end

function SnowOrNightBPGiftItem:playUnlock()
	self.uiAni:startAni("UnLockSnowOrNightBPGiftItem", true)
end

function SnowOrNightBPGiftItem:onClear()
	SnowOrNightBPGiftItem.super.onClear(self)
	self.efxUnLock:setVisible(false)
end

return SnowOrNightBPGiftItem
