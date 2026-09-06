-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplantudieventView.lua

module("logic.extensions.richmanxplan.view.RmxplantudieventView", package.seeall)

local RmxplantudieventView = class("RmxplantudieventView", ViewComponent)

function RmxplantudieventView:ctor()
	RmxplantudieventView.super.ctor(self)
end

function RmxplantudieventView:unbindEvents()
	RmxplantudieventView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function RmxplantudieventView:bindEvents()
	RmxplantudieventView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
	self._btnBuy:AddClickListener(self._onClickbtnBuy, self)
end

function RmxplantudieventView:buildUI()
	RmxplantudieventView.super.buildUI(self)

	self._btnCancel = self:getBtn("btns/btnCancel")
	self._btnBuy = self:getBtn("btns/btnBuy")
	self._txtCancel = self:getTxt("btns/btnCancel/txt")
	self._singleLine = self:getGo("btns"):GetComponent(ComponentType.UILayoutSingleLine)
	self._txtCost = self:getTxt("notBuy/txtCost")
	self._txtHave = self:getTxt("notBuy/txtHave")
	self._isBuyGo = self:getGo("isBuy")
	self._notBuyGo = self:getGo("notBuy")
	self._txtNotBuyGain = self:getTxt("notBuy/txtGain")
	self._txtBuyGain = self:getTxt("isBuy/txtGain")
end

function RmxplantudieventView:onExit()
	RmxplantudieventView.super.onExit(self)
end

function RmxplantudieventView:onEnter()
	RmxplantudieventView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RichManXPlanEventRes, self._onRichManXPlanEventRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._event = params[2]
	self._score = RichmanxplanModel.instance:getScore(self._activityId)
	self._params = GameUtil.jsonToTable(self._event.param)
	self._purchased = self._params.purchased

	self:_updateUI()
end

function RmxplantudieventView:_onClickbtnCancel()
	RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, true)
end

function RmxplantudieventView:_onClickbtnBuy()
	local cfg = RichmanxplanConfig.instance:getLandEventCfg(self._activityId, self._event.eventId)

	if self._score >= cfg.cost then
		local text = "确定购买土地吗？"

		TipsFacade.instance:openPopupWindow("提示", text, function()
			RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, false)
		end)
	else
		FloatWordMgr.instance:show("消耗道具不足")
	end
end

function RmxplantudieventView:_updateUI()
	local cfg = RichmanxplanConfig.instance:getLandEventCfg(self._activityId, self._event.eventId)

	goutil.setActive(self._btnBuy.gameObject, not self._purchased)
	self._singleLine:Layout()

	local rateValue = RichmanxplanModel.instance:getBuffRate(self._activityId)

	self._txtCancel.text = self._purchased and "太棒了" or "下次一定"

	if self._purchased then
		self._txtBuyGain.text = cfg.prize * (1 + rateValue)
	else
		self._txtNotBuyGain.text = cfg.prize * (1 + rateValue)
		self._txtCost.text = cfg.cost
		self._txtHave.text = self._score
	end

	goutil.setActive(self._notBuyGo, not self._purchased)
	goutil.setActive(self._isBuyGo, self._purchased)
end

function RmxplantudieventView:_onRichManXPlanEventRes(msg)
	if msg.isEnd then
		self:close()
	end
end

return RmxplantudieventView
