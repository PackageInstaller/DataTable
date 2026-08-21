-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawFreePoolChild.lua

local DrawPoolChildBase = require("UI/DrawCard/DrawPoolChildBase")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local strClassName = "DrawFreePoolChild"
local DrawFreePoolChild = Class(strClassName, DrawPoolChildBase)

function DrawFreePoolChild:ctor(...)
	self:initUI()
end

function DrawFreePoolChild:initUI(...)
	self:initCommonUI()

	self.freeTicketPanel = UIControls.Label(self, "TextTitleFree")
	self.countdownTxt = UIControls.Label(self, "TextTitleFree/TextFreeTime")
	self.freeTicketImg = UIControls.Image(self, "TextTitleFree/ImgFreeTicket")
	self.buyTenBtn = UIControls.Button(self, "BtnTen", "Text")

	self.buyTenBtn:setEnable(false)
end

function DrawFreePoolChild:_initData(...)
	if self.drawFakeRandData then
		self.freeDrawCD = (self.drawFakeRandData.free_time or 24) * 3600
	end

	if self.needItemIconPath then
		self.needItemIcon:setImage(self.needItemIconPath[1], self.needItemIconPath[2])
	end
end

function DrawFreePoolChild:onPanelOpen(...)
	return
end

function DrawFreePoolChild:onPanelClose(...)
	self:stopCountDown()
end

function DrawFreePoolChild:_refreshPanel(...)
	self:_refreshFreeCountDown()
	self:_refreshRemainCount()
	self:_refreshDrawInfo()
end

function DrawFreePoolChild:_refreshDrawInfo(...)
	if not self.needItemId then
		return
	end

	self.totalNeedItem = 0
	self.totalDrawCount = DrawCardUtils.calcFreeDrawCount(self.needItemId, self.needItemNum)
	self.totalNeedItem = self.needItemNum * self.totalDrawCount

	if self.totalDrawCount <= 0 then
		local countTxt = Lang.get(1340)

		self.buyTenBtn:setText(countTxt)
		self.priceTxt:setTextWithColor(self.needItemNum, "RED")
	else
		local countTxt

		if self.totalDrawCount == 1 then
			countTxt = Lang.get(1340)
		else
			countTxt = string.format(Lang.get(30271), Const.NUMBER_TO_WORD[self.totalDrawCount])
		end

		self.buyTenBtn:setText(countTxt)
		self.priceTxt:setText(self.totalNeedItem)
	end

	if self.hasFreeCount then
		self.totalDrawCount = 1

		self.buyTenBtn:setText(Lang.get(1340))
		self.priceTxt:setText(self.totalDrawCount)
	end
end

function DrawFreePoolChild:_refreshFreeCountDown()
	local typeData = CurAvatar.roleDrawData[self.poolType]

	if not typeData then
		return
	end

	local nextFreeTick = typeData.lastDrawTick + self.freeDrawCD
	local needTick = nextFreeTick - ClientUtils.getServerTime()

	self.hasFreeCount = needTick <= 0

	self.freeLineImg:setVisible(self.hasFreeCount)
	self.freeTxt:setVisible(self.hasFreeCount)
	self.freeTicketPanel:setVisible(true)
	self.freeTicketImg:setVisible(self.hasFreeCount)
	self.countdownTxt:setVisible(not self.hasFreeCount)

	if not self.hasFreeCount then
		self:_startFreeCountDown(nextFreeTick)
	end
end

function DrawFreePoolChild:_startFreeCountDown(nextFreeTick)
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

function DrawFreePoolChild:stopCountDown(...)
	self.countdownTxt:setVisible(false)

	if self.freeCountDownTimer then
		self.freeCountDownTimer:Stop()
	end
end

function DrawFreePoolChild:_countDownFunc()
	local leftTime = self.nextFreeTick - ClientUtils.getServerTime()

	if leftTime > 0 then
		local displayTime = utils.calcTimeTxt(leftTime)

		self.countdownTxt:setText(string.format(Lang.get(30269), displayTime))
	else
		self:stopCountDown()
		self:_refreshPanel()
	end
end

DrawFreePoolChild.needCareRemain = false

function DrawFreePoolChild:_refreshRemainCount(...)
	if not DrawFreePoolChild.needCareRemain then
		return
	end

	if self.poolType == Const.DrawTypeFree then
		self.todayRemain = CurAvatar:getDrawDayCount(Const.DayDrawCounterFree, Const.DayDrawMaxCountFree)
	elseif self.totalDrawCount == 1 then
		self.todayRemain = CurAvatar:getDrawDayCount(Const.DayDrawCounterStandard, Const.DayDrawMaxCountStandard)
	else
		self.todayRemain = CurAvatar:getDrawDayCount(Const.DayDrawCounterStandardTen, Const.DayDrawMaxCountStandardTen)
	end
end

return DrawFreePoolChild
