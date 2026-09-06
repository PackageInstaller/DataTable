-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/item/DropCell.lua

module("logic.extensions.material.proxy.item.DropCell", package.seeall)

local DropCell = class("DropCell", ItemCell)

function DropCell:ctor(target)
	DropCell.super.ctor(self, target)
end

function DropCell:setCfgData(cfg)
	ItemCell.super.setCfgData(self, cfg)
	GameUtil.addClickHandler(self.target, self._OnClick, self)
	GameUtil.SetActive(self.tag, false)
	self.icon:SetActive(false)
	self.iconBg:SetState(0)

	if cfg then
		MaterialMgr.setIcon(self.icon, self.type, cfg.dropId)
		self.icon:SetActive(true)
		self.iconBg:SetState(1 + (cfg.quality or 0))

		if checknumber(cfg.subType) == MatType.Item_Piece then
			GameUtil.SetActive(self.tag, true)
		end
	end
end

return DropCell
