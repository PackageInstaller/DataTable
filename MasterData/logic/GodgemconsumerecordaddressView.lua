-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godgemconsume/view/GodgemconsumerecordaddressView.lua

module("logic.extensions.godgemconsume.view.GodgemconsumerecordaddressView", package.seeall)

local GodgemconsumerecordaddressView = class("GodgemconsumerecordaddressView", ViewComponent)

function GodgemconsumerecordaddressView:ctor()
	GodgemconsumerecordaddressView.super.ctor(self)
end

function GodgemconsumerecordaddressView:unbindEvents()
	GodgemconsumerecordaddressView.super.unbindEvents(self)
	self._btnSave:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function GodgemconsumerecordaddressView:bindEvents()
	GodgemconsumerecordaddressView.super.bindEvents(self)
	self._btnSave:AddClickListener(self._onClickbtnSave, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function GodgemconsumerecordaddressView:buildUI()
	GodgemconsumerecordaddressView.super.buildUI(self)

	self._inputFieldAddress = self:getInput("inputFieldAddress")
	self._inputFieldPhone = self:getInput("inputFieldPhone")
	self._inputFieldName = self:getInput("inputFieldName")
	self._inputFieldCity = self:getInput("inputFieldCity")
	self._inputFieldProvince = self:getInput("inputFieldProvince")
	self._inputFieldArea = self:getInput("inputFieldArea")
	self._btnSave = self:getBtn("btnSave")
	self._btnClose = self:getBtn("btnClose")
end

function GodgemconsumerecordaddressView:onExit()
	GodgemconsumerecordaddressView.super.onExit(self)
	GlobalDispatcher:removeListener(GodgemconsumeController.PM_GGACChangeRecipientInfoRes, self._saveSuccess, self)
	GlobalDispatcher:removeListener(GodgemconsumeController.PM_GGACChangeRecipientInfoRes, self.close, self)

	self._cacheInfo = nil
end

function GodgemconsumerecordaddressView:onEnter()
	GodgemconsumerecordaddressView.super.onEnter(self)
	GlobalDispatcher:addListener(GodgemconsumeController.PM_GGACChangeRecipientInfoRes, self._saveSuccess, self)
	GlobalDispatcher:addListener(GodgemconsumeController.PM_GGACChangeRecipientInfoRes, self.close, self)

	self._activityId = GodgemconsumeModel.instance:getCurrActivityId()

	self:_updateView()
end

function GodgemconsumerecordaddressView:_onClickbtnSave()
	if not self:_checkMod() then
		FloatWordMgr.instance:show("信息未修改")

		return
	end

	local recipient = self._inputFieldName:GetText()
	local telephone = self._inputFieldPhone:GetText()
	local addressDetail = self._inputFieldAddress:GetText()
	local province = self._inputFieldProvince:GetText()
	local city = self._inputFieldCity:GetText()
	local area = self._inputFieldArea:GetText()

	if string.nilorempty(recipient) or string.nilorempty(telephone) or string.nilorempty(addressDetail) or string.nilorempty(province) or string.nilorempty(city) or string.nilorempty(area) then
		FloatWordMgr.instance:show("你还有必填项未填写哦！")

		return
	end

	local function saveFunc()
		local recipientInfo = GodGemAccConsumeExtension_pb.PM_GGACRecipientInfo()

		recipientInfo.recipient = recipient
		recipientInfo.telephone = telephone
		recipientInfo.qq = ""
		recipientInfo.province = province
		recipientInfo.city = city
		recipientInfo.area = area
		recipientInfo.addressDetail = addressDetail
		self._cacheInfo = recipientInfo

		GodgemconsumeController.instance:sendPM_GGACChangeRecipientInfoReq(self._activityId, recipientInfo)
	end

	if not string.find(telephone, "^1%d%d%d%d%d%d%d%d%d%d$") then
		local content = "您填写的联系方式不是常见格式，是否确认保存？"

		TipsFacade.instance:openPopupWindow(lang("tip"), content, saveFunc)
		FloatWordMgr.instance:show(content)

		return
	else
		saveFunc()
	end
end

function GodgemconsumerecordaddressView:_onClickbtnClose()
	local function okFunc()
		self:close()
	end

	if self:_checkMod() then
		local content = "收货地址有修改，是否【不保存】直接关闭？"

		TipsFacade.instance:openPopupWindow(lang("tip"), content, okFunc)
	else
		okFunc()
	end
end

function GodgemconsumerecordaddressView:_checkMod()
	local recipient = self._inputFieldName:GetText()
	local telephone = self._inputFieldPhone:GetText()
	local addressDetail = self._inputFieldAddress:GetText()
	local province = self._inputFieldProvince:GetText()
	local city = self._inputFieldCity:GetText()
	local area = self._inputFieldArea:GetText()

	if not self._info then
		local finalStr = string.format("%s%s%s%s%s", recipient, telephone, addressDetail, province, city, area)

		if not string.nilorempty(finalStr) then
			return true
		end
	elseif self._info.recipient ~= recipient or self._info.telephone ~= telephone or self._info.province ~= province or self._info.city ~= city or self._info.area ~= area or self._info.addressDetail ~= addressDetail then
		return true
	end

	return false
end

function GodgemconsumerecordaddressView:_saveSuccess(status)
	self:_updateView()
end

function GodgemconsumerecordaddressView:_updateView()
	self._info = GodgemconsumeModel.instance:getRecipientInfo()

	if self._info then
		self._inputFieldName:SetText(self._info.recipient)
		self._inputFieldCity:SetText(self._info.city)
		self._inputFieldArea:SetText(self._info.area)
		self._inputFieldAddress:SetText(self._info.addressDetail)
		self._inputFieldProvince:SetText(self._info.province)
		self._inputFieldPhone:SetText(self._info.telephone)
	end
end

return GodgemconsumerecordaddressView
