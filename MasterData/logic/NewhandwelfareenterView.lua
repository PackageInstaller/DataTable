-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandwelfareenterView.lua

module("logic.extensions.newhandwelfare.view.NewhandwelfareenterView", package.seeall)

local NewhandwelfareenterView = class("NewhandwelfareenterView", ViewComponent)

NewhandwelfareenterView.CheckRedDot = "NewhandwelfareenterView.CheckRedDot"

function NewhandwelfareenterView:ctor()
	NewhandwelfareenterView.super.ctor(self)
end

function NewhandwelfareenterView:unbindEvents()
	NewhandwelfareenterView.super.unbindEvents(self)
	self._btnPrivilege:RemoveClickListener()
	self._btnSign:RemoveClickListener()
	self._btnWelfare:RemoveClickListener()
	self._btnPet2:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnPet1:RemoveClickListener()
	self._btnOnline:RemoveClickListener()
	self._btnPowerGift:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnPet3:RemoveClickListener()
end

function NewhandwelfareenterView:bindEvents()
	NewhandwelfareenterView.super.bindEvents(self)
	self._btnPrivilege:AddClickListener(self._onClickbtnPrivilege, self)
	self._btnSign:AddClickListener(self._onClickbtnSign, self)
	self._btnWelfare:AddClickListener(self._onClickbtnWelfare, self)
	self._btnPet2:AddClickListener(self._onClickbtnPet2, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnPet1:AddClickListener(self._onClickbtnPet1, self)
	self._btnOnline:AddClickListener(self._onClickbtnOnline, self)
	self._btnPowerGift:AddClickListener(self._onClickbtnPowerGift, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnPet3:AddClickListener(self._onClickbtnPet3, self)
end

function NewhandwelfareenterView:buildUI()
	NewhandwelfareenterView.super.buildUI(self)

	self._btnPrivilege = self:getBtn("btns/btnPrivilege")
	self._btnSign = self:getBtn("btns/btnSign")
	self._btnWelfare = self:getBtn("btns/btnWelfare")
	self._btnPet2 = self:getBtn("btns/btnPet2")
	self._btnClose = self:getBtn("btnClose")
	self._btnPet1 = self:getBtn("btns/btnPet1")
	self._btnPet3 = self:getBtn("btns/btnPet3")
	self._btnOnline = self:getBtn("btns/btnOnline")
	self._btnPowerGift = self:getBtn("btns/btnPowerGift")
	self._btnTip = self:getBtn("btnTip")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txtTime")
	self._btnSignRedpointGo = self:getGo("btns/btnSign/redpoint")
	self._btnPowerGiftRedpointGo = self:getGo("btns/btnPowerGift/redpoint")
	self._btnOnlineRedpointGo = self:getGo("btns/btnOnline/redpoint")
	self._btnPrivilegeRedpointGo = self:getGo("btns/btnPrivilege/redpoint")
	self._btnRedPointGo = self:getGo("btns/btnWelfare/redpoint")
	self._roleGo = self:getGo("role")
end

function NewhandwelfareenterView:onExit()
	NewhandwelfareenterView.super.onExit(self)
	GlobalDispatcher:removeListener(NewhandwelfareController.NewHandWelfareGetInfoRes, self._NewHandWelfareGetInfoRes, self)
	GlobalDispatcher:removeListener(NewhandwelfareController.NewHandWelfareGainOnlinePrizeRes, self._chechRedDot, self)
	GlobalDispatcher:removeListener(NewhandwelfareController.NewHandWelfareGainSignInPrizeRes, self._chechRedDot, self)
	GlobalDispatcher:removeListener(NewhandwelfareController.NewHandWelfareOneKeyGainOnlinePrizeRes, self._chechRedDot, self)
	GlobalDispatcher:removeListener(NewhandwelfareController.NewHandWelfareGainZdlPrizeRes, self._chechRedDot, self)
	GlobalDispatcher:removeListener(NewhandwelfareenterView.CheckRedDot, self._chechRedDot, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateGoldenDiamondCardInfo, self._chechRedDot, self)
	GlobalDispatcher:removeListener(NewhandwelfareController.NewHandWelfareOneKeyGainZdlPrizeRes, self._chechRedDot, self)
	RoleObjectPool.instance:removeRole(self._roleObj)
end

function NewhandwelfareenterView:onEnter()
	NewhandwelfareenterView.super.onEnter(self)
	GlobalDispatcher:addListener(NewhandwelfareController.NewHandWelfareGetInfoRes, self._NewHandWelfareGetInfoRes, self)
	GlobalDispatcher:addListener(NewhandwelfareController.NewHandWelfareGainOnlinePrizeRes, self._chechRedDot, self)
	GlobalDispatcher:addListener(NewhandwelfareController.NewHandWelfareGainSignInPrizeRes, self._chechRedDot, self)
	GlobalDispatcher:addListener(NewhandwelfareController.NewHandWelfareOneKeyGainOnlinePrizeRes, self._chechRedDot, self)
	GlobalDispatcher:addListener(NewhandwelfareController.NewHandWelfareGainZdlPrizeRes, self._chechRedDot, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateGoldenDiamondCardInfo, self._chechRedDot, self)
	GlobalDispatcher:addListener(NewhandwelfareenterView.CheckRedDot, self._chechRedDot, self)
	GlobalDispatcher:addListener(NewhandwelfareController.NewHandWelfareOneKeyGainZdlPrizeRes, self._chechRedDot, self)
	NewHandWelfareAgent.instance:sendNewHandWelfareGetInfoReq()
	self:_setActTime()
	self:_chechRedDot()
	self:_setRole()
	self:_judgeBtnShow()
end

function NewhandwelfareenterView:_onClickbtnPrivilege()
	UIStateManager.instance:push(ViewName.NewhandprivilegeView, {
		source = NewhandwelfareEnum.PrivilegeViewSource_NewHand
	})
end

function NewhandwelfareenterView:_onClickbtnSign()
	UIStateManager.instance:push(ViewName.NewhandwelfaresignView)
end

function NewhandwelfareenterView:_onClickbtnWelfare()
	UIStateManager.instance:push(ViewName.NewhandwelfarejumpView)
	SurveyController.instance:reportBehavior(200660)
end

function NewhandwelfareenterView:_onClickbtnPet2()
	UIStateManager.instance:push(ViewName.NewhandawakengiftView, 2)
	SurveyController.instance:reportBehavior(200659, 2)
end

function NewhandwelfareenterView:_onClickbtnPet1()
	UIStateManager.instance:push(ViewName.NewhandawakengiftView, 1)
	SurveyController.instance:reportBehavior(200659, 1)
end

function NewhandwelfareenterView:_onClickbtnPet3()
	UIStateManager.instance:push(ViewName.NewHandTargetView, 106002, 106003)
end

function NewhandwelfareenterView:_onClickbtnClose()
	self:close()
end

function NewhandwelfareenterView:_onClickbtnOnline()
	local endTime = NewhandwelfareModel.instance:getOnlineTimeActEndTime()

	if endTime <= ServerTime.nowServerLook() then
		FloatWordMgr.instance:show("活动已结束")

		return
	end

	UIStateManager.instance:push(ViewName.NewhandwelfareonlineView)
end

function NewhandwelfareenterView:_onClickbtnPowerGift()
	UIStateManager.instance:push(ViewName.NewhandpowergiftView)
end

function NewhandwelfareenterView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("newhandwelfareenter")
end

function NewhandwelfareenterView:_setActTime()
	local nowTime = ServerTime.now()
	local endTime = NewhandwelfareModel.instance:getNewHandPlayerEndTime()

	self._txtTime.text = "剩余时间：" .. self:_formatTime(endTime - nowTime)
end

function NewhandwelfareenterView:_formatTime(timeStamp)
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(timeStamp)

	return string.format("%d天%d小时", day, hour)
end

function NewhandwelfareenterView:_NewHandWelfareGetInfoRes(status)
	if status == 0 then
		self:_chechRedDot()
	end
end

function NewhandwelfareenterView:_chechRedDot()
	local onlineDot = NewhandwelfareModel.instance:checkOnlinePrizeDot()
	local signInDot = NewhandwelfareModel.instance:checkSignInPrizeDot()
	local zdlDot = NewhandwelfareModel.instance:checkZdlPrizeDot()
	local privilegeDot = NewhandwelfareModel.instance:checkPriviligePrizeDot()

	goutil.setActive(self._btnPowerGiftRedpointGo, zdlDot)
	goutil.setActive(self._btnSignRedpointGo, signInDot)
	goutil.setActive(self._btnOnlineRedpointGo, onlineDot)
	goutil.setActive(self._btnPrivilegeRedpointGo, privilegeDot)
	goutil.setActive(self._btnRedPointGo, privilegeDot)
end

function NewhandwelfareenterView:_setRole()
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, 80013, self._roleGo, 2, nil, true, 0, 0)
end

function NewhandwelfareenterView:_judgeBtnShow()
	local playerTime = RoleModel.instance:getActiveTimeSec()
	local time = GameUtil.string2time("2022/12/23/5:00")

	goutil.setActive(self._btnPet1.gameObject, playerTime < time)
	goutil.setActive(self._btnPet2.gameObject, playerTime < time)
	goutil.setActive(self._btnPet3.gameObject, time < playerTime)
end

return NewhandwelfareenterView
