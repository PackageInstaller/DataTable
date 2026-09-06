-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/ItemChatMain.lua

module("logic.extensions.mainui.view.ItemChatMain", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local ItemChatMain = class("ItemChatMain")

ItemChatMain.ResPath = "ui/views/mainui/item_chat_main.prefab"

function ItemChatMain.Get(go)
	return (LuaComponentContainer.Get(go, ItemChatMain))
end

function ItemChatMain.AddOnce(go)
	local component = ItemChatMain.Get(go)

	component = component or LuaComponentContainer.Add(go, ItemChatMain)

	return component
end

function ItemChatMain.Remove(go)
	LuaComponentContainer.Remove(go, ItemChatMain)
end

function ItemChatMain:ctor(target)
	self._target = target.gameObject
	self._Nego_Channel = goutil.findChildComponent(self._target, "Nego_Channel", "Image")
	self._TxtC_Channel = goutil.findChildTextComponent(self._Nego_Channel.gameObject, "TxtC_Channel")
	self._TxtC_Chat = goutil.findChildTextComponent(self._target, "TxtC_Chat")
	self._txtColorChange = self._TxtC_Channel:GetComponent("UITextColorChange")
end

function ItemChatMain:SetChatData(chatData)
	local channel = chatData:getChannel()
	local msgType = chatData:getMsgType()

	self._TxtC_Channel.text = ConstString.ChannelShortcut[channel]

	self._txtColorChange:SetState(math.min(5, channel))

	self._TxtC_Chat.text = chatData:getMainUIContent()
end

function ItemChatMain:GetSize()
	local transform = self._target.transform
	local width, height = transform.rect.width, transform.rect.height

	return width, height
end

return ItemChatMain
