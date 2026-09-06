-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/travel/CutepettravelmainView.lua

module("logic.extensions.cutepet.view.CutepettravelmainView", package.seeall)

local CutepettravelmainView = class("CutepettravelmainView", ViewComponent)

function CutepettravelmainView:ctor()
	CutepettravelmainView.super.ctor(self)
end

function CutepettravelmainView:unbindEvents()
	CutepettravelmainView.super.unbindEvents(self)
	self._btnSingle:RemoveClickListener()
	self._btnTeam:RemoveClickListener()
	self._btnCommunity:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function CutepettravelmainView:bindEvents()
	CutepettravelmainView.super.bindEvents(self)
	self._btnSingle:AddClickListener(self._onClickbtnSingle, self)
	self._btnTeam:AddClickListener(self._onClickbtnTeam, self)
	self._btnCommunity:AddClickListener(self._onClickbtnCommunity, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
end

function CutepettravelmainView:buildUI()
	CutepettravelmainView.super.buildUI(self)

	self._btnSingle = self:getBtn("btns/btnSingle")
	self._btnTeam = self:getBtn("btns/btnTeam")
	self._btnCommunity = self:getBtn("btns/btnCommunity")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtDesc = self:getTxt("txtDesc")
	self._goldbarconGo = self:getGo("goldbarcon")
	self._timeTip = self:getGo("timeTip")
	self._txtTipTime = self:getTxt("timeTip/txtTipTime")
	self._txtTipDesc = self:getTxt("timeTip/txtTipDesc")
end

function CutepettravelmainView:onExit()
	CutepettravelmainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LoadTravelInfoResp, self._updateUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_CutePetTravelMySelfPairingResp, self._PM_CutePetTravelMySelfPairingResp, self)
	removetimer(self._updateTimeTip, self)
end

function CutepettravelmainView:onEnter()
	CutepettravelmainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_LoadTravelInfoResp, self._updateUI, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_CutePetTravelMySelfPairingResp, self._PM_CutePetTravelMySelfPairingResp, self)

	if FuncOpenController.instance:checkFuncIdOrShowLockTips(910) == false then
		self:close()

		return
	end

	CutePetGardenAgent.instance:sendPM_LoadTravelInfoReq()

	local privateUseTime = CutePetConfig.instance:getPrivilegeCommonValue("Privilege_TravelDailyMaxCount", true)

	self._txtTipDesc.text = langPara("每日出游次数增加至%d次", privateUseTime)

	self:_updateTimeTip()
	settimer(10, self._updateTimeTip, self)
end

function CutepettravelmainView:_onClickbtnSingle()
	local isCanJump = self:_checkIsCanJump()

	if isCanJump then
		UIStateManager.instance:push(ViewName.CutepettravelsingleView)
	end
end

function CutepettravelmainView:_onClickbtnTeam()
	UIStateManager.instance:push(ViewName.CutepettravelteamView)
end

function CutepettravelmainView:_onClickbtnCommunity()
	UIStateManager.instance:push(ViewName.CutePetCommunityView)
end

function CutepettravelmainView:_onClickbtnClose()
	self:close()
end

function CutepettravelmainView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("cute_pet_travel_main_rule")
end

function CutepettravelmainView:_updateUI()
	self:_updateDesc()
end

function CutepettravelmainView:_updateDesc()
	local leftTime, totalCount = CutePetController.instance:getTravelTimeParams()

	self._txtDesc.text = langPara("当前剩余出游次数：%d/%d（每日5:00重置）", leftTime, totalCount)
end

function CutepettravelmainView:_checkIsCanJump()
	local leftTime, totalCount = CutePetController.instance:getTravelTimeParams()

	if leftTime <= 0 then
		FloatWordMgr.instance:show("出游次数已用完")

		return false
	end

	return true
end

function CutepettravelmainView:_PM_CutePetTravelMySelfPairingResp()
	CutePetGardenAgent.instance:sendPM_LoadTravelInfoReq()
end

function CutepettravelmainView:_updateTimeTip()
	local isInTime, txtTime = CutePetController.instance:updateTimeTip(CutePetConfig.instance:getPrivilegeCommonValue("PrivilegeTimePlan_TravelDailyMaxCount", false))

	self:_updateDesc()
	goutil.setActive(self._timeTip, isInTime)

	self._txtTipTime.text = txtTime
end

return CutepettravelmainView
