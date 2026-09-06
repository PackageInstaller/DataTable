-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/dress/DressCell.lua

module("logic.extensions.material.proxy.dress.DressCell", package.seeall)

local DressCell = class("DressCell", MaterialCell)

function DressCell:ctor(target)
	DressCell.super.ctor(self, target)

	self.icon = goutil.findChild(self.target, "con/icon")
	self.bg = goutil.findChild(self.target, "bg")
	self.top = goutil.findChild(self.target, "top")

	GameUtil.addClickHandler(self.target, self._OnClick, self)
end

function DressCell:_OnClick()
	print(">>>>>>>>>>>DressCell cell click")
	GameUtil.callBack(self._clickBack, self)
	GameUtil.callBack(self.callback, self)

	if self.autoTips then
		CommonTipsMgr.instance:openMaterialTips(self.icon, self.type, self.id, 0)
	end
end

function DressCell:setData(data)
	DressCell.super.setData(self, data)
end

function DressCell:setCfgData(cfg)
	DressCell.super.setCfgData(self, cfg)
	self.icon:SetActive(false)
	GameUtil.SetActive(self.icon, false)

	if cfg then
		MaterialMgr.setIcon(self.icon, self.type, cfg.id)
		GameUtil.SetActive(self.icon, true)
	end
end

function DressCell:dispose()
	DressCell.super.dispose(self)
	MaterialMgr.resetAll(self.top)
	MaterialMgr.clearIcon(self.icon)
end

function DressCell:setCustomIcon(path)
	MaterialMgr.clearIcon(self.icon)
	uGuiUtil.setSpriteToImage(self.icon, uGuiUtil.SpriteType.BigBg, path)
end

return DressCell
