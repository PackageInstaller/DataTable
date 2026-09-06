-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emoji/view/ItemEmoji.lua

module("logic.extensions.emoji.view.ItemEmoji", package.seeall)

local format = "<quad name=%s size=30 width=1 des=%s />"
local LuaComponentContainer = Framework.LuaComponentContainer
local ItemEmoji = class("ItemEmoji")

ItemEmoji.ResPath = "ui/views/emoji/item_emoji.prefab"

function ItemEmoji.AddOnce(go)
	local component = ItemEmoji.Get(go)

	component = component or LuaComponentContainer.Add(go, ItemEmoji)

	return component
end

function ItemEmoji.Remove(go)
	LuaComponentContainer.Remove(go, ItemEmoji)
end

function ItemEmoji.Get(go)
	return (LuaComponentContainer.Get(go, ItemEmoji))
end

function ItemEmoji:ctor(target)
	self._target = target.gameObject
	self._TxtC_Self = self._target:GetComponent("UIGraphicText")

	self._TxtC_Self:AddClickListener(self._OnClickSelf, self)
end

function ItemEmoji:SetContent(nickname, sprites)
	self._nickname = nickname
	self._TxtC_Self.text = string.format(format, sprites, nickname)
end

function ItemEmoji:_OnClickSelf(name)
	GlobalDispatcher:dispatch(GlobalNotify.EmojiSelected, self._nickname)
end

function ItemEmoji:OnDestroy()
	self._TxtC_Self:RemoveClickListener()
end

return ItemEmoji
