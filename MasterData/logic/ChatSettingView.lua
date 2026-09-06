-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/ChatSettingView.lua

module("logic.extensions.chat.view.ChatSettingView", package.seeall)

local ChatSettingView = class("ChatSettingView", ViewComponent)

function ChatSettingView:buildUI()
	self._btnClose = self:getBtn("btnClose")
	self._toggles = {}
	self._toggles[GameEnum.ChatChannel.Zone] = self:getToggle("gridlayout/Tog_Zone")
	self._toggles[GameEnum.ChatChannel.World] = self:getToggle("gridlayout/Tog_World")
	self._toggles[GameEnum.ChatChannel.League] = self:getToggle("gridlayout/Tog_League")
	self._toggles[GameEnum.ChatChannel.System] = self:getToggle("gridlayout/Tog_System")
	self._toggles[GameEnum.ChatChannel.Private] = self:getToggle("gridlayout/Tog_Private")
	self._toggles[GameEnum.ChatChannel.Share] = self:getToggle("gridlayout/Tog_Share")
	self._toggles[GameEnum.ChatChannel.All] = self:getToggle("gridlayout/Tog_All")
end

function ChatSettingView:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)

	for k, v in pairs(self._toggles) do
		v:AddOnValueChanged(function()
			self:_onTogValueChanged(k)
		end)
	end
end

function ChatSettingView:unbindEvents()
	self._btnClose:RemoveClickListener()

	for k, v in pairs(self._toggles) do
		v:RemoveOnValueChanged()
	end
end

function ChatSettingView:onEnter()
	self._isChanged = false

	for k, v in pairs(self._toggles) do
		v.isOn = ChatSettingModel.instance:GetMainShow(k)
	end
end

function ChatSettingView:_onClickClose()
	if self._isChanged then
		for k, v in pairs(self._toggles) do
			ChatSettingModel.instance:SetMainShow(k, v.isOn)
		end

		self:notify(GlobalNotify.ChatSettingChange)
	end

	if self._isChanged then
		ChatAgent.instance:sendSetChatSettingsReq()
	end

	self:close()
end

function ChatSettingView:_onTogValueChanged(channel)
	self._isChanged = true
end

return ChatSettingView
