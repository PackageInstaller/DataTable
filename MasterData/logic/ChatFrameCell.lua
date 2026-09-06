-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/head/ChatFrameCell.lua

module("logic.extensions.material.proxy.head.ChatFrameCell", package.seeall)

local ChatFrameCell = class("ChatFrameCell", MaterialCell)

function ChatFrameCell:ctor(target)
	ChatFrameCell.super.ctor(self, target)

	self.iconBg = goutil.findChild(self.target, "ImgBg")
	self._ImgC_ContentBg = goutil.findChild(self.target, "ImgC_ContentBg")
	self._image00 = goutil.findChild(self.target, "ImgC_ContentBg/image00")
	self._image01 = goutil.findChild(self.target, "ImgC_ContentBg/image01")
	self._image10 = goutil.findChild(self.target, "ImgC_ContentBg/image10")
	self._image11 = goutil.findChild(self.target, "ImgC_ContentBg/image11")
	self.isBgActive = true

	GameUtil.addClickHandler(self.target, self._OnClick, self)
end

function ChatFrameCell:_OnClick()
	GameUtil.callBack(self._clickBack, self)
	GameUtil.callBack(self.callback, self)

	if self.autoTips then
		CommonTipsMgr.instance:openMaterialTips(self._ImgC_ContentBg, self.type, self.id)
	end
end

function ChatFrameCell:setCfgData(cfg)
	ChatFrameCell.super.setCfgData(self, cfg)
	GameUtil.SetActive(self._ImgC_ContentBg, false)
	GameUtil.setUIImageSpriteIdx(self.iconBg, 0)
	self:setBgActive(self.isBgActive)
	self:_clearConner()

	if cfg then
		GameUtil.setUIImageSpriteIdx(self.iconBg, 1 + (cfg.quality or 0))
		GameUtil.SetActive(self._ImgC_ContentBg, true)
		GameUtil.setUIImageSpriteIdx(self._ImgC_ContentBg, cfg.bubbleId - 1)
		GameUtil.SetActive(self._image00, true)
		GameUtil.SetActive(self._image01, true)
		GameUtil.SetActive(self._image10, true)
		GameUtil.SetActive(self._image11, true)
		self:_setIcon(self._image00, cfg.img_00)
		self:_setIcon(self._image01, cfg.img_01)
		self:_setIcon(self._image10, cfg.img_10)
		self:_setIcon(self._image11, cfg.img_11)
	end
end

function ChatFrameCell:setBgActive(boo)
	self.isBgActive = true

	GameUtil.SetActive(self.iconBg, boo)
end

function ChatFrameCell:dispose()
	ChatFrameCell.super.dispose(self)

	self.isBgActive = true

	self:_clearConner()
end

function ChatFrameCell:_clearConner()
	GameUtil.SetActive(self._image00, false)
	GameUtil.SetActive(self._image01, false)
	GameUtil.SetActive(self._image10, false)
	GameUtil.SetActive(self._image11, false)
	MaterialMgr.clearIcon(self._image00)
	MaterialMgr.clearIcon(self._image01)
	MaterialMgr.clearIcon(self._image10)
	MaterialMgr.clearIcon(self._image11)
end

function ChatFrameCell:_setIcon(icon, url)
	if not string.nilorempty(url) then
		GameUtil.SetActive(icon, true)
		uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("chat", url), function(w, h)
			icon.gameObject:GetComponent("Image"):SetNativeSize()

			icon.gameObject:GetComponent("Image").raycastTarget = false
		end)
	end
end

return ChatFrameCell
