-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/MCInfoPopMediator.lua

MCInfoPopMediator = class("MCInfoPopMediator", DmPopupViewMediator, _M)

MCInfoPopMediator:has("_rechargeAndVipSystem", {
	is = "r"
}):injectWith("RechargeAndVipSystem")

local kBtnHandlers = {
	["main.payBtn.button"] = {
		func = "payforMonthCard"
	}
}

function MCInfoPopMediator:initialize()
	super.initialize(self)
end

function MCInfoPopMediator:dispose()
	super.dispose(self)
end

function MCInfoPopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_MONTHCARD_SUCC, self, self.onClickBack)

	local bgNode = self:getView():getChildByFullName("main.bg")
	local widget = self:bindWidget(bgNode, PopupNormalWidget, {
		bg = "tishi_bg_584.png",
		ignoreBtnBg = true,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.close, self)
		},
		title = Strings:get("Activity_RewardDetail"),
		title1 = Strings:get("UITitle_EN_Jianglixiangqing"),
		bgSize = {
			width = 725,
			height = 480
		}
	})
end

function MCInfoPopMediator:enterWithData(data)
	self._info = data.info
	self._index = data.index
	self._remainDays = data.remainDays
	self._moneyInfo = data.moneyInfo
	self._main = self:getView():getChildByName("main")

	self:setupView()
end

function MCInfoPopMediator:setupView()
	self._payment = self._info.Price

	local symbol, price = self._moneyInfo:getPaySymbolAndPrice()
	local btnText = self._main:getChildByFullName("payBtn.name")

	btnText:setString(symbol .. price)

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(129, 118, 113, 255)
		}
	}
	local monthCardCell = self._main:getChildByName("monthCardCell")
	local remainDayPanel = monthCardCell:getChildByName("remainDay")

	monthCardCell:getChildByName("TextCardBg"):getChildByName("TextCard"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))

	local TextNum1 = self._main:getChildByFullName("TextNum1")
	local TextNum2 = self._main:getChildByFullName("TextNum2")

	TextNum1:setString(100)
	TextNum2:setString(50)

	if self._remainDays > 0 then
		remainDayPanel:setVisible(true)
		remainDayPanel:getChildByName("remain"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
			x = 0,
			y = -1
		}))
		remainDayPanel:getChildByName("num"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
			x = 0,
			y = -1
		}))
		remainDayPanel:getChildByName("day"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
			x = 0,
			y = -1
		}))
		remainDayPanel:getChildByName("num"):setString(self._remainDays)
	else
		remainDayPanel:setVisible(false)
	end
end

function MCInfoPopMediator:payforMonthCard()
	self._rechargeAndVipSystem:requestBuyMonthCard(self._info.Id, self._index)
end

function MCInfoPopMediator:onClickBack()
	self:close()
end
