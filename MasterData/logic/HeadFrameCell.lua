-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/head/HeadFrameCell.lua

module("logic.extensions.material.proxy.HeadFrameCell", package.seeall)

local HeadFrameCell = class("HeadFrameCell", MaterialCell)

function HeadFrameCell:ctor(target)
	HeadFrameCell.super.ctor(self, target)

	self.iconBg = goutil.findChild(self.target, "ImgBg")
	self.icon = goutil.findChild(self.target, "icon")
	self.withTag = goutil.findChild(self.target, "withTag")
	self.iconRect = self.icon:GetComponent(goutil.Type_RectTransform)
	self.isBgActive = true

	GameUtil.addClickHandler(self.target, self._OnClick, self)
end

function HeadFrameCell:_OnClick()
	print(">>>>>>>>>>>HeadFrameCell cell click")
	GameUtil.callBack(self.callback, self)

	if self.autoTips then
		CommonTipsMgr.instance:openMaterialTips(self.icon, self.type, self.id, 0)
	end
end

function HeadFrameCell:setData(data)
	HeadFrameCell.super.setData(self, data)
	Framework.TransformUtil.SetLocalScale(self.iconRect, 1, 1, 1)
end

function HeadFrameCell:setCfgData(cfg)
	HeadFrameCell.super.setCfgData(self, cfg)
	Framework.TransformUtil.SetLocalScale(self.iconRect, 1, 1, 1)
	self.icon:SetActive(false)
	GameUtil.SetActive(self.icon, false)
	GameUtil.setUIImageSpriteIdx(self.iconBg, 0)
	self:setBgActive(self.isBgActive)

	self.loader = RoleObjectPool.instance:removeHead(self.loader)

	MaterialMgr.clearIcon(self.icon)

	if cfg then
		GameUtil.setUIImageSpriteIdx(self.iconBg, 1 + (cfg.quality or 0))
		GameUtil.SetActive(self.icon, true)

		if checknumber(cfg.isSpine) == 1 then
			self.loader = RoleObjectPool.instance:addHeadToParent(self.loader, self.type, cfg.id, self.icon, function()
				self:setGray(self._isGray)
			end)
		else
			MaterialMgr.setIcon(self.icon, self.type, cfg.id, function()
				self.icon.gameObject:GetComponent("Image"):SetNativeSize()
			end)
		end
	end

	self:setWithTag(0)
end

function HeadFrameCell:setBgActive(boo)
	self.isBgActive = true

	GameUtil.SetActive(self.iconBg, boo)
end

function HeadFrameCell:setWithTag(state)
	GameUtil.SetActive(self.withTag, state == 1)
end

function HeadFrameCell:dispose()
	HeadCell.super.dispose(self)
	MaterialMgr.clearIcon(self.icon)

	self.isBgActive = true
	self.loader = RoleObjectPool.instance:removeHead(self.loader)
	self.loader = nil

	self:setWithTag(0)
end

function HeadFrameCell:setScale(scale)
	Framework.TransformUtil.SetLocalScale(self.iconRect, scale, scale, scale)
end

return HeadFrameCell
