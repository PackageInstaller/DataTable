-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emoji/view/ItemEmojiLayout.lua

module("logic.extensions.emoji.view.ItemEmojiLayout", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local ItemEmojiLayout = class("ItemEmojiLayout")

ItemEmojiLayout.ResPath = "ui/views/emoji/item_emojilayout.prefab"

local EmojiObjectCache = ResObjectCache.New()

function ItemEmojiLayout.AddOnce(go)
	local component = ItemEmojiLayout.Get(go)

	component = component or LuaComponentContainer.Add(go, ItemEmojiLayout)

	return component
end

function ItemEmojiLayout.Remove(go)
	LuaComponentContainer.Remove(go, ItemEmojiLayout)
end

function ItemEmojiLayout.Get(go)
	return (LuaComponentContainer.Get(go, ItemEmojiLayout))
end

function ItemEmojiLayout:ctor(target)
	self._target = target.gameObject
	self._emojis = {}
	self._item_emojis = {}
end

function ItemEmojiLayout:SetContent(emojis)
	self._emojis = emojis

	for id, v in pairs(emojis) do
		local nickname, sprites = id, v

		if not self._item_emojis[id] then
			EmojiObjectCache:newObject(ItemEmoji.ResPath, self._OnEmojiLoaded, self, {
				handleId = id
			})
		else
			self:_OnEmojiLoaded(id, self._item_emojis[id])
		end
	end
end

function ItemEmojiLayout:OnDestroy()
	for i, v in pairs(self._item_emojis) do
		EmojiObjectCache.recycleObject(ItemEmoji.ResPath, v, {
			handlerId = i
		})
	end

	self._item_emojis = {}
	self._emojis = {}
end

function ItemEmojiLayout:_OnEmojiLoaded(handlerId, go)
	goutil.addChildToParent(go, self._target)
	go.transform:SetSiblingIndex(handlerId)

	local nickname, sprites = handlerId, self._emojis[handlerId]
	local component = ItemEmoji.AddOnce(go)

	component:SetContent(nickname, sprites)

	self._item_emojis[handlerId] = go
end

return ItemEmojiLayout
