-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawStandardPoolChild.lua

local DrawPoolChildBase = require("UI/DrawCard/DrawPoolChildBase")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local DrawCountNoticePanel = require("UI/DrawCard/DrawCountNoticePanel")
local strClassName = "DrawStandardPoolChild"
local DrawStandardPoolChild = Class(strClassName, DrawPoolChildBase)

function DrawStandardPoolChild:ctor(...)
	self:initUI()
end

function DrawStandardPoolChild:initUI(...)
	self:initCommonUI()

	self.freeTicketPanel = UIControls.Label(self, "TextTitleFree")
	self.countdownTxt = UIControls.Label(self, "TextTitleFree/TextFreeTime")
	self.freeTicketImg = UIControls.Panel(self, "TextTitleFree/ImgFreeTicket")
	self.buyOneBtn = UIControls.Button(self, "BtnBuyNumPanel/BtnOne")

	self.buyOneBtn:addEventClick(self._selectBuyOne)

	self.buyTenBtn = UIControls.Button(self, "BtnBuyNumPanel/BtnTen")

	self.buyTenBtn:addEventClick(self._selectBuyTen)

	self.discountPanel = UIControls.Panel(self, "BtnBuyNumPanel/BtnTen/ImgSale")
	self.discountInfoTxt = UIControls.Label(self, "BtnBuyNumPanel/BtnTen/ImgSale/TextDiscount")
	self.discountNumTxt = UIControls.Label(self, "BtnBuyNumPanel/BtnTen/ImgSale/TextSaleNum")
	self.buyFreeRD = UIControls.Panel(self, "BtnBuy/IconNew")
	self.buyFreeTxt = UIControls.Label(self, "BtnBuy/TextBuy")
	self.countNoticePanel = DrawCountNoticePanel(self, "BgPoint")
end

function DrawStandardPoolChild:_initData(...)
	if self.drawFakeRandData then
		self.freeDrawCD = (self.drawFakeRandData.free_time or 24) * 3600

		self.discountNumTxt:setText(self.drawFakeRandData.ten_consume_num or 2700)
		self.discountInfoTxt:setText(DrawCardUtils.calcDisconnectTex())
	end

	self.countNoticePanel:initData(self.poolId, self.poolType)
end

function DrawStandardPoolChild:onPanelOpen(...)
	self:_calcFreeFlag()

	if DrawCardUtils.checkDrawCost(self.poolId, 10, true) ~= false and not self.hasFreeCount then
		self.totalDrawCount = 10

		self.buyOneBtn:setEnable(true)
		self.buyTenBtn:setEnable(false)
	else
		self.totalDrawCount = 1

		self.buyOneBtn:setEnable(false)
		self.buyTenBtn:setEnable(true)
	end

	BeginnerManager.ShowDrawStandardHero(self.hero or self.mWindow.selectedHero)
end

function DrawStandardPoolChild:onPanelClose(...)
	self:stopCountDown()
end

function DrawStandardPoolChild:_refreshPanel(...)
	self:_refreshFreeCountDown()
	self:_refreshRemainCount()
	self:_refreshDrawInfo()
	self.countNoticePanel:refreshCountNotice()
end

function DrawStandardPoolChild:_refreshDrawInfo(...)
	if not self.needItemId then
		return
	end

	local curItemNum = CurAvatar:getItemNumById(self.needItemId)
	local curMoneyNum = ClientUtils.getMoney(self.needMoneyId)

	self.totalNeedItem = 0
	self.totalNeedItem = self.needItemNum * self.totalDrawCount

	if self.totalDrawCount == 1 then
		self.totalNeedMoney = self.needMoneyNum
	else
		self.totalNeedMoney = self.needMoneyNumTen
	end

	if curItemNum >= self.totalNeedItem then
		self.needItemIcon:setImage(self.needItemIconPath[1], self.needItemIconPath[2])
		self.priceTxt:setText(self.totalNeedItem)
	else
		self.needItemIcon:setImage(self.needMoneyIconPath[1], self.needMoneyIconPath[2])

		if curMoneyNum >= self.totalNeedMoney then
			self.priceTxt:setText(self.totalNeedMoney)
		else
			self.priceTxt:setTextWithColor(self.totalNeedMoney, "RED")
		end
	end
end

function DrawStandardPoolChild:_selectBuyOne()
	self.totalDrawCount = 1

	self.buyOneBtn:setEnable(false)
	self.buyTenBtn:setEnable(true)
	self:_refreshPanel()
end

function DrawStandardPoolChild:_selectBuyTen()
	self.totalDrawCount = 10

	self.buyOneBtn:setEnable(true)
	self.buyTenBtn:setEnable(false)
	self:_refreshPanel()
end

function DrawStandardPoolChild:_refreshFreeCountDown()
	local nextFreeTick = self:_calcFreeFlag()

	if self.totalDrawCount ~= 1 then
		self.freeLineImg:setVisible(false)
		self.freeTxt:setVisible(false)
		self.freeTicketPanel:setVisible(not self.hasFreeCount)
		self.freeTicketImg:setVisible(false)
		self.countdownTxt:setVisible(not self.hasFreeCount)
		self.buyFreeRD:setVisible(false)
		self.buyFreeTxt:setText(Lang.get(1271))

		if not self.hasFreeCount and self.mWindow:isInShow() then
			self:_startFreeCountDown(nextFreeTick)
		end
	else
		self.freeLineImg:setVisible(self.hasFreeCount)
		self.freeTxt:setVisible(self.hasFreeCount)
		self.freeTicketPanel:setVisible(true)
		self.freeTicketImg:setVisible(self.hasFreeCount)
		self.countdownTxt:setVisible(not self.hasFreeCount)
		self.buyFreeRD:setVisible(self.hasFreeCount)

		if self.hasFreeCount then
			self.buyFreeTxt:setText(Lang.get(32776))
		else
			self.buyFreeTxt:setText(Lang.get(1271))
		end

		if not self.hasFreeCount and self.mWindow:isInShow() then
			self:_startFreeCountDown(nextFreeTick)
		end
	end
end

function DrawStandardPoolChild:_calcFreeFlag()
	local typeData = CurAvatar.roleDrawData[self.poolType]

	if not typeData then
		return
	end

	if not self.freeDrawCD then
		return
	end

	local nextFreeTick = typeData.lastDrawTick + self.freeDrawCD
	local needTick = nextFreeTick - ClientUtils.getServerTime()

	self.hasFreeCount = needTick <= 0

	return nextFreeTick
end

function DrawStandardPoolChild:_startFreeCountDown(nextFreeTick)
	self.nextFreeTick = nextFreeTick

	self.countdownTxt:setVisible(true)
	self:_countDownFunc()

	if not self.freeCountDownTimer then
		self.freeCountDownTimer = Timer.New(Slot(self._countDownFunc, self), 1, -1)

		self.freeCountDownTimer:Start()
	else
		self.freeCountDownTimer:Restart()
	end
end

function DrawStandardPoolChild:stopCountDown(...)
	self.countdownTxt:setVisible(false)

	if self.freeCountDownTimer then
		self.freeCountDownTimer:Stop()
	end
end

function DrawStandardPoolChild:_countDownFunc()
	local leftTime = self.nextFreeTick - ClientUtils.getServerTime()

	if leftTime > 0 then
		local displayTime = utils.calcTimeTxt(leftTime)

		self.countdownTxt:setText(string.format(Lang.get(36317), displayTime))
	else
		self:stopCountDown()
		self:_refreshPanel()
	end
end

DrawStandardPoolChild.needCareRemain = false

function DrawStandardPoolChild:_refreshRemainCount(...)
	if self.limitNumPanel and CurAvatar:dayDrawCountLimitOpen() then
		self.limitNumPanel:setVisible(true)

		local todayRemain = CurAvatar:getDrawDayCount(self.poolType, Const.DayDrawMaxCountFree)

		if todayRemain >= Const.DayDrawMaxCountFree then
			self.node01:setVisible(false)
			self.node02:setVisible(true)
		else
			self.node01:setVisible(true)
			self.node02:setVisible(false)
			self.remainTxt:setText(todayRemain .. "/" .. Const.DayDrawMaxCountFree)
		end
	end
end

return DrawStandardPoolChild
