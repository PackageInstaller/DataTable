-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightregress/view/SaintKnightRegressAddressView.lua

module("logic.extensions.saintknightregress.view.SaintKnightRegressAddressView", package.seeall)

local SaintKnightRegressAddressView = class("SaintKnightRegressAddressView", ViewComponent)

function SaintKnightRegressAddressView:ctor()
	SaintKnightRegressAddressView.super.ctor(self)
end

function SaintKnightRegressAddressView:unbindEvents()
	SaintKnightRegressAddressView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function SaintKnightRegressAddressView:bindEvents()
	SaintKnightRegressAddressView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	self._inputPhone:AddOnValueChanged(self._inputValueChanged, self)
	self._inputName:AddOnValueChanged(self._inputValueChanged, self)
	self._inputAddress:AddOnValueChanged(self._inputValueChanged, self)
end

function SaintKnightRegressAddressView:buildUI()
	SaintKnightRegressAddressView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._inputPhone = self:getInput("inputPhoneNumber")
	self._inputName = self:getInput("inputName")
	self._inputAddress = self:getInput("inputAddress")
	self._btnSure = self:getGo("btnSure")
	self._txtSure = self:getTxt("btnSure/txt")
	self._txtItem = self:getTxt("txtItem")
	self._txtTime = self:getTxt("txtTime")
end

function SaintKnightRegressAddressView:onExit()
	SaintKnightRegressAddressView.super.onExit(self)
end

function SaintKnightRegressAddressView:onEnter()
	SaintKnightRegressAddressView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	local lotteryMsgInfo = SaintKnightRegressModel.instance:getLotteryMsgInfo(self._activityId)

	if lotteryMsgInfo and not string.nilorempty(lotteryMsgInfo.phoneNumber) and not string.nilorempty(lotteryMsgInfo.receiver) and not string.nilorempty(lotteryMsgInfo.receiverAddr) then
		self._inputPhone:SetText(lotteryMsgInfo.phoneNumber)
		self._inputName:SetText(lotteryMsgInfo.receiver)
		self._inputAddress:SetText(lotteryMsgInfo.receiverAddr)

		self._txtSure.text = lang("修改地址")
	else
		self._inputPhone:SetText("")
		self._inputName:SetText("")
		self._inputAddress:SetText("")

		self._txtSure.text = lang("保存地址")
	end

	GameUtil.SetGray(self._btnSure, not self:_checkInput())

	local superPrizeId = SaintKnightRegressModel.instance:getSuperPrizeId(self._activityId)
	local superPrizeCfg = SaintKnightRegressConfig.instance:getSuperLotteryPrizeCfg(self._activityId, superPrizeId)

	self._txtItem.text = langPara("恭喜您成功抽中<color=#EB4642>%s</color>，现需要您填写部分信息，仅用于实物发货用！", MaterialMgr.getMaterialsNameByCfg(superPrizeCfg.prize))

	local activityDifineCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.SaintKnightRegress, self._activityId)
	local endTime = GameUtil.string2date(activityDifineCfg.endTime)

	self._txtTime.text = langPara("注：地址在<color=#EB4642>%d月%d日5:00前</color>均可修改，活动结束后若未填写则视为放弃处理", endTime.month, endTime.day)
end

function SaintKnightRegressAddressView:_checkInput()
	local phoneNumber = self._inputPhone:GetText()
	local name = self._inputName:GetText()
	local address = self._inputAddress:GetText()

	if string.nilorempty(phoneNumber) or string.nilorempty(name) or string.nilorempty(address) then
		return false
	else
		return true
	end
end

function SaintKnightRegressAddressView:_onClickSure()
	local phoneNumber = self._inputPhone:GetText()
	local name = self._inputName:GetText()
	local address = self._inputAddress:GetText()
	local lotteryMsgInfo = SaintKnightRegressModel.instance:getLotteryMsgInfo(self._activityId)

	if self:_checkInput() == true then
		if ((lotteryMsgInfo and string.nilorempty(lotteryMsgInfo.phoneNumber) and string.nilorempty(lotteryMsgInfo.receiver) and string.nilorempty(lotteryMsgInfo.receiverAddr) or nil) and false) == false then
			SaintKnightRegressController.instance:sendPM_SaintKnightRegressFillMsgReq(self._activityId, phoneNumber, name, address)
			self:close()
		elseif not PasswordLockController.instance:checkNeedOpenVerifyView() then
			SaintKnightRegressController.instance:sendPM_SaintKnightRegressFillMsgReq(self._activityId, phoneNumber, name, address)
			self:close()
		end
	else
		FloatWordMgr.instance:show(lang("请填写完整的信息"))
	end
end

function SaintKnightRegressAddressView:_inputValueChanged()
	GameUtil.SetGray(self._btnSure, not self:_checkInput())
end

return SaintKnightRegressAddressView
