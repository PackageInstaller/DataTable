-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/SendBlessPopup.lua

module("logic.extensions.birthdaywishes.view.SendBlessPopup", package.seeall)

local SendBlessPopup = class("SendBlessPopup", ViewComponent)

function SendBlessPopup:ctor()
	SendBlessPopup.super.ctor(self)
end

function SendBlessPopup:onExit()
	SendBlessPopup.super.onExit(self)
end

function SendBlessPopup:destroyUI()
	SendBlessPopup.super.destroyUI(self)
end

function SendBlessPopup:bindEvents()
	SendBlessPopup.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._sendBtn:AddClickListener(self._onClickSendBtn, self)
	self._restBtn:AddClickListener(self._onClickRestBtn, self)
end

function SendBlessPopup:unbindEvents()
	SendBlessPopup.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._sendBtn:RemoveClickListener()
	self._restBtn:RemoveClickListener()
end

function SendBlessPopup:buildUI()
	SendBlessPopup.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._sendBtn = self:getBtn("sendBtn")
	self._restBtn = self:getBtn("restBtn")
	self._descTxt = self:getTxt("descTxt")
end

function SendBlessPopup:onEnter()
	SendBlessPopup.super.onEnter(self)

	self._params = self:getFirstParam()

	if self._params == nil or self._params.planId == nil then
		printError("sr---生日祝福    SendBlessPopup:onEnter()    请传入参数！")

		return
	end

	self._textCfgs = BirthdayWishesConfig.instance:getBirthdayWishesTextPlanCfgs(self._params.planId)

	self:_onClickRestBtn()
end

function SendBlessPopup:_getRandom()
	math.randomseed(tostring(os.time()):reverse():sub(1, 5))

	return math.random(1, #self._textCfgs)
end

function SendBlessPopup:_onClickRestBtn()
	self._curValue = self:_getRandom()
	self._descTxt.text = self._textCfgs[self._curValue].desc
end

function SendBlessPopup:_onClickSendBtn()
	BirthdayWishesController.instance:csGetBirthdayWishesSendWishReq(self._params.activityId, self._curValue)
	self:close()
end

return SendBlessPopup
