-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/social/view/ItemMail.lua

module("logic.extensions.social.view.ItemMail", package.seeall)

local ItemMail = class("ItemMail")
local LuaComponentContainer = Framework.LuaComponentContainer

function ItemMail:ctor(go)
	self.mainGO = go
	self._imgSelected = goutil.findChild(self.mainGO, "bg_Saw")
	self._imgRead = goutil.findChild(self.mainGO, "imgRead")
	self._imgNotRead = goutil.findChild(self.mainGO, "imgNotRead")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtSendTime = goutil.findChildTextComponent(self.mainGO, "txtSendTime")
	self._txtExpiredTime = goutil.findChildTextComponent(self.mainGO, "txtExpiredTime")
	self._imgAttach = goutil.findChild(self.mainGO, "imgAttach")
	self._imgPoint = goutil.findChild(self.mainGO, "imgPoint")
	self._btnSelf = Framework.ButtonAdapter.Get(go.gameObject)

	self._btnSelf:AddClickListener(self._onClickSelf, self)

	self._imgYear = goutil.findChild(self.mainGO, "imgYear")
	self._imgUnSelect = goutil.findChild(self.mainGO, "imgBk")
	self._uiChangeGroup = self.mainGO:GetComponent("UIChangeGroup")
end

function ItemMail.AddOnce(go)
	local component = LuaComponentContainer.Get(go, ItemMail)

	component = component or LuaComponentContainer.Add(go, ItemMail)

	return component
end

function ItemMail:onSetMo(mo)
	self._mo = mo

	local isSelected = self._mo.mailId == MailController.instance:getCurSelectedId()

	goutil.setActive(self._imgSelected, isSelected)
	goutil.setActive(self._imgUnSelect, not isSelected)
	goutil.setActive(self._imgRead, self._mo.read)
	goutil.setActive(self._imgNotRead, not self._mo.read)
	goutil.setActive(self._imgPoint, not self._mo.read)
	goutil.setActive(self._imgAttach, self._mo:getHasAttachment())

	self._txtTitle.text = self._mo.title

	local lastTime = mo:getLastTime()

	self._txtExpiredTime.text = mo:getShowExpireTime()
	self._txtSendTime.text = mo:getIsNearInvalid() and "" or lastTime >= 86400 and GameUtil.formatTimeStamp("%Y.%m.%d", mo.sendTime / 1000) or lastTime >= 3600 and string.format("%d小时前", math.floor(lastTime / 3600)) or lastTime >= 60 and string.format("%d分钟前", math.floor(lastTime / 60)) or "小于一分钟"

	goutil.setActive(self._imgYear, self._mo.isYear)
	self._uiChangeGroup:SetState(isSelected and 1 or 0)
end

function ItemMail:getShowTitle(title)
	return
end

function ItemMail:_onClickSelf()
	if self._mo.mailId == MailController.instance:getCurSelectedId() then
		return
	end

	if not self._mo.read then
		goutil.setActive(self._imgRead, true)
		goutil.setActive(self._imgNotRead, false)
		goutil.setActive(self._imgPoint, false)
	end

	goutil.setActive(self._imgSelected, true)
	MailController.instance:localNotify("selectedMail", self._mo)
end

return ItemMail
