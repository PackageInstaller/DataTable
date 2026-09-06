-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/privilege/view/PrivilegeView.lua

module("logic.extensions.privilege.view.PrivilegeView", package.seeall)

local PrivilegeView = class("PrivilegeView", ViewComponent)

function PrivilegeView:ctor()
	PrivilegeView.super.ctor(self)
end

function PrivilegeView:buildUI()
	PrivilegeView.super.buildUI(self)

	self._btnHelp = self:getBtn("btnHelp")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "txtTime/txt")
	self._txtAddDay = goutil.findChildTextComponent(self.mainGO, "txtTime/txt/txtAddDay")

	local initColor = self._txtAddDay.color

	self._colorAddDay = Color.New(initColor.r, initColor.g, initColor.b, 255)
	self._goAddDay = self:getGo("txtTime/txt/txtAddDay")
	self._showTips = self:getGo("showTips/Viewport/Content")

	local goTip = self:getGo("showTips/Viewport/Content/tip")

	GameUtil.SetActive(goTip, false)

	local baseCfg = PrivilegeConfig.instance:getShowCfgs()

	for _, v in ipairs(baseCfg) do
		if not GameUtil.isEmptyString(v.dec) then
			local copyTip = goutil.clone(goTip)

			goutil.addChildToParent(copyTip, self._showTips)

			local txtTip = goutil.findChildTextComponent(copyTip, "txt")

			txtTip.text = v.dec

			local txtAddTime = goutil.findChildTextComponent(copyTip, "txtAddTime")

			txtAddTime.text = "+" .. v.superTimes - v.freeTimes

			GameUtil.SetActive(copyTip, true)
		end
	end

	self._privileges = {}

	for i = 1, 2 do
		local privilege = {}
		local giftCfg = PrivilegeConfig.instance:getPayGiftCfgById(i)

		privilege.go = self:getGo("privilege" .. i)
		privilege.btnBuy = goutil.findChildButtonComponent(privilege.go, "btnBuy")
		privilege.txtBtnBuy = goutil.findChildTextComponent(privilege.go, "btnBuy/txt")
		privilege.txtDay = goutil.findChildTextComponent(privilege.go, "txtDay")
		privilege.firstBuy = goutil.findChild(privilege.go, "firstBuy")
		privilege.txtFirstBuy = goutil.findChildTextComponent(privilege.firstBuy, "txt")

		local priceCfg = PayConfig.instance:getPayGoodsCfg(giftCfg.payGoodsId)

		privilege.txtBtnBuy.text = string.format("¥%s", priceCfg.payMoney / 100)
		privilege.txtDay.text = giftCfg.name
		privilege.txtFirstBuy.text = string.format("首购送%s天", giftCfg.consumePrize)
		self._privileges[i] = privilege
	end
end

function PrivilegeView:bindEvents()
	PrivilegeView.super.bindEvents(self)
	self._btnHelp:AddClickListener(self._onClickBtnHelp, self)

	for i = 1, 2 do
		GameUtil.asBtn(self._privileges[i].btnBuy):AddClickListener(function()
			self:_onClickBuy(i)
		end)
	end
end

function PrivilegeView:unbindEvents()
	PrivilegeView.super.unbindEvents(self)
	self._btnHelp:RemoveClickListener()

	for i = 1, 2 do
		GameUtil.asBtn(self._privileges[i].btnBuy):RemoveClickListener()
	end
end

function PrivilegeView:destroyUI()
	PrivilegeView.super.destroyUI(self)
end

function PrivilegeView:onEnter()
	PrivilegeView.super.onEnter(self)

	self._isAni = false
	self._txtAddDay.color = Color.New(self._colorAddDay.r, self._colorAddDay.g, self._colorAddDay.b, 0)

	PrivilegeController.instance:sendGetInfoReq(self._refreshUI, self, false)
	GlobalDispatcher:addListener(PayAgent.NotifyPayResultRes, self.handleNotifyPayResultRes, self)
	GlobalDispatcher:addListener(PrivilegeGiftAgent.PM_NotifyBuyPrivilegeGiftRes, self.handleNotifyBuyPrivilegeGiftRes, self)
end

function PrivilegeView:onEnterFinished()
	PrivilegeView.super.onEnterFinished(self)
end

function PrivilegeView:onExit()
	PrivilegeView.super.onExit(self)
	PrivilegeModel.instance:updateRestDay()
	removetimer(self._endAddDay, self)
	GlobalDispatcher:removeListener(PayAgent.NotifyPayResultRes, self.handleNotifyPayResultRes, self)
	GlobalDispatcher:removeListener(PrivilegeGiftAgent.PM_NotifyBuyPrivilegeGiftRes, self.handleNotifyBuyPrivilegeGiftRes, self)
end

function PrivilegeView:onExitFinished()
	PrivilegeView.super.onExitFinished(self)
end

function PrivilegeView:_onClickBtnHelp()
	ViewMgr.instance:open(ViewName.RulesView, "privilegerule")
end

function PrivilegeView:_onClickBuy(id)
	local giftCfg = PrivilegeConfig.instance:getPayGiftCfgById(id)
	local title = "提示"
	local text = string.format("是否确认购买%s？", giftCfg.name)

	local function func1()
		PayController.instance:sendGenOrderNoReq(giftCfg.payGoodsId, 7, id)
	end

	local btnText1 = "确定"
	local btnText2 = "取消"

	TipsFacade.instance:openPopupWindow(title, text, func1, func2, btnText1, btnText2, alignment)
end

function PrivilegeView:_refreshUI(isBuySuc)
	local hasPayGifts = PrivilegeModel.instance:getHasPayGifts()

	for i = 1, 2 do
		GameUtil.SetActive(self._privileges[i].firstBuy, not table.indexof(hasPayGifts, i))
	end

	if checkbool(isBuySuc) then
		self._isAni = true

		self:_resetAddDay()
		self._txtAddDay:DOFade(0, 3)
		removetimer(self._endAddDay, self)
		settimer(3, self._endAddDay, self, false)
	end

	self._txtTime.text = string.format("<color=#11a568ff>%s</color>天", PrivilegeModel.instance:getRestDay())
end

function PrivilegeView:_resetAddDay()
	self._txtAddDay.text = string.format("+%s天", PrivilegeModel.instance:getPlusDay())
	self._txtAddDay.color = self._colorAddDay
end

function PrivilegeView:_endAddDay()
	self._isAni = false

	PrivilegeModel.instance:updateRestDay()

	self._txtTime.text = string.format("<color=#11a568ff>%s</color>天", PrivilegeModel.instance:getRestDay())
end

function PrivilegeView:handleNotifyPayResultRes(status, msg)
	if status ~= 0 then
		local title = "提示"
		local text = "购买失败"
		local func
		local btnText = "确定"

		TipsFacade.instance:openTipWindowNoX(title, text, func, btnText, alignment)
	end
end

function PrivilegeView:handleNotifyBuyPrivilegeGiftRes(status, msg)
	if status == 0 then
		if self._isAni == true then
			PrivilegeModel.instance:updateRestDay()
		end

		PrivilegeModel.instance:updateAfterBuyGiftSuc(msg)

		local title = "提示"
		local text = "特权购买成功，快去畅玩吧！"

		local function func()
			self:_refreshUI(true)
		end

		local btnText = "确定"

		TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)
	end
end

return PrivilegeView
