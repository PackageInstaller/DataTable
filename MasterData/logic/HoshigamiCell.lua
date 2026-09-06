-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/hoshigami/HoshigamiCell.lua

module("logic.extensions.material.proxy.hoshigami.HoshigamiCell", package.seeall)

local HoshigamiCell = class("HoshigamiCell", MaterialCell)

function HoshigamiCell:ctor(target)
	HoshigamiCell.super.ctor(self, target)
	self:_buildUI()
end

function HoshigamiCell:getGo(goPath)
	return goutil.findChild(self.target, goPath)
end

function HoshigamiCell:getText(goPath)
	return goutil.findChildTextComponent(self.target, goPath)
end

function HoshigamiCell:getBtn(goPath)
	return GameUtil.asBtn(self:getGo(goPath))
end

function HoshigamiCell:_buildUI()
	self._lvBgGo = self:getGo("lvBg")
	self._starShowGo = self:getGo("starShow")
	self._starGo_1Go = self:getGo("starShow/starGo_1")
	self._starGo_2Go = self:getGo("starShow/starGo_2")
	self._starGo_3Go = self:getGo("starShow/starGo_3")
	self._starGo_4Go = self:getGo("starShow/starGo_4")
	self._starGo_5Go = self:getGo("starShow/starGo_5")
	self._starGo_6Go = self:getGo("starShow/starGo_6")
	self._starGo_1GoChange = self._starGo_1Go:GetComponent(ComponentType.UIImageSpriteChange)
	self._starGo_2GoChange = self._starGo_2Go:GetComponent(ComponentType.UIImageSpriteChange)
	self._starGo_3GoChange = self._starGo_3Go:GetComponent(ComponentType.UIImageSpriteChange)
	self._starGo_4GoChange = self._starGo_4Go:GetComponent(ComponentType.UIImageSpriteChange)
	self._starGo_5GoChange = self._starGo_5Go:GetComponent(ComponentType.UIImageSpriteChange)
	self._starGo_6GoChange = self._starGo_6Go:GetComponent(ComponentType.UIImageSpriteChange)
	self._iconBg = goutil.findChild(self.target, "bg"):GetComponent("UIImageSpriteChange")
	self._topGoGo = self:getGo("topGo")
	self._selectGo = self:getGo("select")
	self._lvText = self:getText("lvBg/TxtNum")
	self._iconGo = self:getGo("icon")
	self._raycast = self:getBtn("raycast")

	self._raycast:AddClickListener(self._onClickraycast, self)
end

function HoshigamiCell:_onClickraycast()
	GameUtil.callBack(self.callback, self)
end

function HoshigamiCell:setLv(lv)
	lv = checknumber(lv)

	local isEmpty = lv <= 0

	goutil.setActive(self._lvBgGo, not isEmpty)

	if not isEmpty then
		self._lvText.text = "+" .. lv
	end
end

function HoshigamiCell:setData(mo)
	HoshigamiCell.super.setData(self, mo)
	self:setLv(mo:getStrenLv())
end

function HoshigamiCell:setCfgData(cfg)
	HoshigamiCell.super.setCfgData(self, cfg)
	MaterialMgr.setIcon(self._iconGo, self.type, self.id)
	self._iconBg:SetState(1 + (cfg.quality or 0))
end

function HoshigamiCell:OnDestroy()
	HoshigamiCell.super.OnDestroy(self)
	self._raycast:RemoveClickListener()
end

function HoshigamiCell:dispose()
	MaterialMgr.resetAll(self._iconGo)
end

return HoshigamiCell
