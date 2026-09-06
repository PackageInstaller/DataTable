-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtreebottle/view/WishTreeBottleEditView.lua

module("logic.extensions.wishtreebottle.view.WishTreeBottleEditView", package.seeall)

local WishTreeBottleEditView = class("WishTreeBottleEditView", ViewComponent)

function WishTreeBottleEditView:ctor()
	WishTreeBottleEditView.super.ctor(self)
end

function WishTreeBottleEditView:unbindEvents()
	WishTreeBottleEditView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChange)
	GameUtil.rmClickHandler(self._btnSure)
	self._inputField:RemoveOnValueChanged()
end

function WishTreeBottleEditView:bindEvents()
	WishTreeBottleEditView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnChange, self._onClickChange, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	self._inputField:AddOnValueChanged(self._onValueChange, self)
end

function WishTreeBottleEditView:buildUI()
	WishTreeBottleEditView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTip = self:getTxt("txtTip")
	self._btnSure = self:getBtn("btnSure")
	self._btnChange = self:getBtn("btnChange")
	self._bottle = self:getGo("bottle"):GetComponent("UIImageSpriteChange")
	self._txtName = self:getTxt("bottle/txtName")
	self._inputField = self:getInput("inputField")
	self._typeDrop = DropDownAdapter.GetFrom(self.mainGO, "dropdown")
end

function WishTreeBottleEditView:onExit()
	WishTreeBottleEditView.super.onExit(self)
end

function WishTreeBottleEditView:onEnter()
	WishTreeBottleEditView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.WishTreeBottleSendRes, self._refresh, self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.WishTreeBottle)
	self._typeId = WiShTreeBottleModel.instance:getBottleTypeId()
	self._actCfg = WiShTreeBottleConfig.instance:getWtbActCfg(self._activityId)
	self._typeCfg = WiShTreeBottleConfig.instance:getWtbTypeCfgById(self._activityId, self._typeId)
	self._titleCfg = WiShTreeBottleConfig.instance:getWtbTitleCfg(self._activityId)
	self._wishData = WiShTreeBottleModel.instance:getWishData()
	self._txtName.text = self._typeCfg.content
	self._wishDescLength = self._actCfg.wishDescLength - 2

	self._inputField:SetText(self._wishData.desc)
	self._inputField:SetCharacterLimit(self._wishDescLength)
	self._bottle:ChangeSprite(self._typeCfg.pic)
	self._typeDrop:ClearOptions()

	for i, v in ipairs(self._titleCfg) do
		self._typeDrop:AddOptions(v.content)
	end

	self._typeDrop:SetValue(self._wishData.titleId - 1)

	self._txtTip.text = string.format("0/%d", self._wishDescLength)
end

function WishTreeBottleEditView:_refresh()
	FloatWordMgr.instance:show("许愿成功！")
	WiShTreeBottleModel.instance:setBottleTypeId(1)
	WiShTreeBottleModel.instance:resetWishData()
	self:close()
end

function WishTreeBottleEditView:_onValueChange()
	local text = self._inputField:GetText()
	local t = StringUtil.utf8split(text)
	local len = 0

	for i = 1, #t do
		if i > self._wishDescLength then
			break
		else
			len = len + 1
		end
	end

	self._txtTip.text = string.format("%d/%d", len, self._wishDescLength)
end

function WishTreeBottleEditView:_onClickChange()
	local wishData = {}

	wishData.titleId = self._titleCfg[self._typeDrop:GetValue() + 1].titleId
	wishData.desc = self._inputField:GetText()

	WiShTreeBottleModel.instance:setWishCache(wishData)
	WiShTreeBottleModel.instance:setBottleTypeId(self._typeId)
	UIStateManager.instance:push(ViewName.WishTreeBottleView)
	self:close()
end

function WishTreeBottleEditView:_onClickSure()
	local desc = self._inputField:GetText()

	if string.nilorempty(desc) then
		FloatWordMgr.instance:show("还未填入愿望哦~")

		return
	else
		local titleId = self._titleCfg[self._typeDrop:GetValue() + 1].titleId

		WiShTreeBottleController.instance:sendPM_WishTreeBottleSendReq(self._activityId, self._typeId, titleId, desc)
	end
end

function WishTreeBottleEditView:_onClickClose()
	WiShTreeBottleModel.instance:setBottleTypeId(1)
	WiShTreeBottleModel.instance:resetWishData()
	self:close()
end

return WishTreeBottleEditView
