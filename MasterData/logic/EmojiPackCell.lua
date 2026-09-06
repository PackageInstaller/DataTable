-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/item/EmojiPackCell.lua

module("logic.extensions.material.proxy.item.EmojiPackCell", package.seeall)

local EmojiPackCell = class("EmojiPackCell", EmojiCell)

function EmojiPackCell:ctor(target)
	EmojiPackCell.super.ctor(self, target)
end

function EmojiPackCell:setData(data)
	self.data = data

	if data ~= nil then
		MaterialMgr.setIcon(self.icon, MatType.EmojiPack, data.id)
	end
end

function EmojiPackCell:setCfgData(cfg)
	EmojiPackCell.super.setCfgData(self, cfg)
	self.icon:SetActive(false)
	self.iconBg:SetState(5)

	if cfg then
		self.icon:SetActive(true)
		MaterialMgr.setIcon(self.icon, MatType.EmojiPack, cfg.id)
	end
end

return EmojiPackCell
