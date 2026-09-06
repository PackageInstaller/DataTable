-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/rune/RuneBaseCell.lua

module("logic.extensions.material.proxy.rune.RuneBaseCell", package.seeall)

local RuneBaseCell = class("RuneBaseCell")

function RuneBaseCell:ctor(go)
	self._imgQua = goutil.findChildComponent(go, "imgQua", "UIImageSpriteChange")
	self._imgIcon = goutil.findChild(go, "imgIcon")
	self._txtName = goutil.findChildComponent(go, "txtName", "Text")
	self._txtLevel = goutil.findChildComponent(go, "txtLevel", "Text")
end

function RuneBaseCell:onSetMo(runeDefineId, level)
	print("set rune cell id = " .. runeDefineId)

	local cfg = RuneConfig.instance:getRuneCfg(runeDefineId)

	if self._txtName ~= nil then
		self._txtName.text = cfg.name
	end

	goutil.setActive(self._imgIcon, true)
	uGuiUtil.setSpriteToImage(self._imgIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getStargodIconUrl(cfg.icon))
	self._imgQua:SetState(cfg.quality)

	self._txtLevel.text = string.format("Lv.%s", level)
end

function RuneBaseCell:onSetRuneSuitMo(suitId, level)
	local cfg = RuneConfig.instance:getSuitById(suitId)

	self._txtName.text = cfg.name

	goutil.setActive(self._imgIcon, true)
	uGuiUtil.setSpriteToImage(self._imgIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getStargodIconUrl(cfg.icon))
	self._imgQua:SetState(cfg.quality)

	self._txtLevel.text = string.format("当前符文等级:%s", level)
end

function RuneBaseCell:reset()
	if self._txtName ~= nil then
		self._txtName.text = ""
	end

	goutil.setActive(self._imgIcon, false)
	self._imgQua:SetState(0)

	self._txtLevel.text = ""
end

return RuneBaseCell
