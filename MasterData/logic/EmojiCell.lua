-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/item/EmojiCell.lua

module("logic.extensions.material.proxy.item.EmojiCell", package.seeall)

local EmojiCell = class("EmojiCell", MaterialCell)

function EmojiCell:ctor(target)
	EmojiCell.super.ctor(self, target)

	self.icon = goutil.findChild(self.target, "ImgIcon")
	self.iconBg = goutil.findChild(self.target, "ImgBg"):GetComponent("UIImageSpriteChange")
	self.imgBg = goutil.findChildComponent(self.target, "ImgBg", "Image")

	self:dispose()
	GameUtil.addClickHandler(self.target, self._OnClick, self)
end

function EmojiCell:setBgActive(isActive)
	self.imgBg.enabled = isActive
end

function EmojiCell:setData(data)
	self.data = data

	if data ~= nil then
		MaterialMgr.setIcon(self.icon, MatType.Emoji, data.id)
	end
end

function EmojiCell:setCfgData(cfg)
	EmojiCell.super.setCfgData(self, cfg)
	self.icon:SetActive(false)
	self.iconBg:SetState(5)

	if cfg then
		self.icon:SetActive(true)
		MaterialMgr.setIcon(self.icon, MatType.Emoji, cfg.id)
	end
end

function EmojiCell:_OnClick()
	GameUtil.callBack(self._clickBack, self)
	GameUtil.callBack(self.callback, self)

	if self.autoTips then
		CommonTipsMgr.instance:openMaterialTips(self.icon, self.type, self.id, 0)
	end
end

function EmojiCell:OnDestroy()
	EmojiCell.super.OnDestroy(self)

	self.target = nil
	self.data = nil
	self._clickBack = nil
end

function EmojiCell:setGray(isGray)
	uGuiUtil.setImageGrayStateRecursive(self.target, isGray)
end

function EmojiCell:dispose()
	EmojiCell.super.dispose(self)

	self._clickBack = nil

	self:setSelected(false)
	self.icon:SetActive(false)
	self.iconBg:SetState(0)
	self:setBgActive(true)
	MaterialMgr.clearIcon(self.icon)
	UIEffectManager.instance:stopEffect(self._effSSR)

	self._effSSR = nil

	uGuiUtil.clearImage(self.icon)
end

return EmojiCell
