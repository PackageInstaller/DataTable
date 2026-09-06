-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/ItemChatTime.lua

module("logic.extensions.chat.view.ItemChatTime", package.seeall)

local Format = "- %Y/%m/%d %H:%M:%S -"
local LuaComponentContainer = Framework.LuaComponentContainer
local ItemChatTime = class("ItemChatTime")

ItemChatTime.ResPath_Friend = "ui/views/friend/item_friendchat_time.prefab"
ItemChatTime.ResPath_Chat = "ui/views/chat/item_chat_time.prefab"

function ItemChatTime.Get(go)
	return (LuaComponentContainer.Get(go, ItemChatTime))
end

function ItemChatTime.AddOnce(go)
	local component = ItemChatTime.Get(go)

	component = component or LuaComponentContainer.Add(go, ItemChatTime)

	return component
end

function ItemChatTime.Remove(go)
	LuaComponentContainer.Remove(go, ItemChatTime)
end

function ItemChatTime:ctor(target)
	self._target = target.gameObject
	self._value = 0
end

function ItemChatTime:Awake()
	self._TxtC_Time = self._target:GetComponent("Text")
end

function ItemChatTime:SetValue(time)
	self._TxtC_Time.text = GameUtil.formatTimeStamp(Format, time)
end

return ItemChatTime
