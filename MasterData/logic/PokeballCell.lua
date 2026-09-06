-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/pokeball/PokeballCell.lua

module("logic.extensions.material.proxy.pokeball.PokeballCell", package.seeall)

local PokeballCell = class("PokeballCell", ItemCell)

function PokeballCell:ctor(target)
	PokeballCell.super.ctor(self, target)
end

function PokeballCell:setCfgData(cfg)
	PokeballCell.super.setCfgData(self, cfg)
	self.icon:SetActive(false)
	self.iconBg:SetState(0)

	if cfg then
		uGuiUtil.setSpriteToImage(self.icon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.icon))
		self.icon:SetActive(true)
		self.icon:GetComponent("Image"):SetNativeSize()
		self.iconBg:SetState(1 + (cfg.quality or 0))
	end
end

return PokeballCell
