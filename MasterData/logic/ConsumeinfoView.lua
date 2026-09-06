-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/consumelottery/view/ConsumeinfoView.lua

module("logic.extensions.consumelottery.view.ConsumeinfoView", package.seeall)

local ConsumeinfoView = class("ConsumeinfoView", ViewComponent)

function ConsumeinfoView:ctor()
	ConsumeinfoView.super.ctor(self)
end

function ConsumeinfoView:buildUI()
	ConsumeinfoView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._btnClose = self:getBtn("btnClose")
	self._imgNum = self:getGo("number/imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._phoneInput = self:getInput("info/phone/Input")
	self._qqInput = self:getInput("info/qq/Input")
	self._recipientInput = self:getInput("info/recipient/Input")
	self._addressInput = self:getInput("info/address/Input")
	self._blurBg = goutil.findChild(self.mainGO, "img"):GetComponent(typeof(StaticBluredScreen))
	self._blurBg.blur = 0.2
end

function ConsumeinfoView:bindEvents()
	ConsumeinfoView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function ConsumeinfoView:unbindEvents()
	ConsumeinfoView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function ConsumeinfoView:destroyUI()
	ConsumeinfoView.super.destroyUI(self)
end

function ConsumeinfoView:onEnter()
	ConsumeinfoView.super.onEnter(self)
	GlobalDispatcher:addListener(ConsumelotteryController.PM_ConsumeLotteryGetAddressInfoRes, self._PM_ConsumeLotteryGetAddressInfoRes, self)
	GlobalDispatcher:addListener(ConsumelotteryController.PM_ConsumeLotteryUpdateAddressInfoRes, self._PM_ConsumeLotteryUpdateAddressInfoRes, self)

	local cfgs = ConsumelotteryConfig.instance:getActCfgs()

	self._actId = false

	for actId, v in pairs(cfgs) do
		if type(actId) == "number" then
			local prizePlanCfgs = ConsumelotteryConfig.instance:getLotteryPrizeCfg(v.prizePlanId)

			for round, list in pairs(prizePlanCfgs) do
				for _, vo in pairs(list) do
					if vo.type == 1 then
						self._actId = v.activityId

						break
					end
				end
			end
		end
	end

	if self._actId then
		ConsumeLotteryAgent.instance:sendPM_ConsumeLotteryGetAddressInfoReq(self._actId)
	end

	self:_setBlurBg()
end

function ConsumeinfoView:onEnterFinished()
	ConsumeinfoView.super.onEnterFinished(self)
end

function ConsumeinfoView:onExit()
	ConsumeinfoView.super.onExit(self)
	GlobalDispatcher:removeListener(ConsumelotteryController.PM_ConsumeLotteryGetAddressInfoRes, self._PM_ConsumeLotteryGetAddressInfoRes, self)
	GlobalDispatcher:removeListener(ConsumelotteryController.PM_ConsumeLotteryUpdateAddressInfoRes, self._PM_ConsumeLotteryUpdateAddressInfoRes, self)
	self._blurBg:Release()
end

function ConsumeinfoView:onExitFinished()
	ConsumeinfoView.super.onExitFinished(self)
end

function ConsumeinfoView:_onClickbtnSure()
	if not self._actId then
		FloatWordMgr.instance:show("提交异常")

		return
	end

	local phoneStr = self._phoneInput:GetText()

	if string.nilorempty(phoneStr) then
		FloatWordMgr.instance:show("请输入电话号码")

		return
	elseif not string.find(phoneStr, "^(%d+)$") then
		FloatWordMgr.instance:show("手机号只能是数字")

		return
	end

	local qqStr = self._qqInput:GetText()

	if string.nilorempty(qqStr) then
		FloatWordMgr.instance:show("请输入QQ号码")

		return
	elseif not string.find(qqStr, "^(%d+)$") then
		FloatWordMgr.instance:show("QQ号只能是数字")

		return
	end

	if string.nilorempty(self._addressInput:GetText()) then
		FloatWordMgr.instance:show("请输入联系地址")

		return
	end

	if string.nilorempty(self._recipientInput:GetText()) then
		FloatWordMgr.instance:show("请输入收件人姓名")

		return
	end

	ConsumeLotteryAgent.instance:sendPM_ConsumeLotteryUpdateAddressInfoReq(self._actId, self._recipientInput:GetText(), phoneStr, qqStr, self._addressInput:GetText())
end

function ConsumeinfoView:_onClickbtnClose()
	self:close()
end

function ConsumeinfoView:_PM_ConsumeLotteryGetAddressInfoRes(status, msg)
	if status == 0 then
		self:_updateView(msg)
	end
end

function ConsumeinfoView:_updateView(data)
	self._imgNum:SetText(tostring(data.rank))
	self._phoneInput:SetText(data.mobilePhone or "")
	self._qqInput:SetText(data.qq or "")
	self._addressInput:SetText(data.address or "")
	self._recipientInput:SetText(data.address or "")
end

function ConsumeinfoView:_setBlurBg()
	goutil.setActive(self.mainGO, false)
	self._blurBg:Release()
	self._blurBg:AddCaptureFinishListener(self._onCaptureScreenFinish, self)
	self._blurBg:Capture()
end

function ConsumeinfoView:_onCaptureScreenFinish()
	goutil.setActive(self.mainGO, true)
end

function ConsumeinfoView:_PM_ConsumeLotteryUpdateAddressInfoRes(status)
	if status == 0 then
		self:close()
	end
end

return ConsumeinfoView
