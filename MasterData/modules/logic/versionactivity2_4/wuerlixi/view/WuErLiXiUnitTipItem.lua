-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/view/WuErLiXiUnitTipItem.lua

module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiUnitTipItem", package.seeall)

local WuErLiXiUnitTipItem = class("WuErLiXiUnitTipItem", LuaCompBase)

function WuErLiXiUnitTipItem:init(go)
	self.go = go
	self._txtname = gohelper.findChildText(go, "txt_desc/image_bg/txt_namecn")
	self._txtdesc = gohelper.findChildText(go, "txt_desc")
	self._gonormalicon = gohelper.findChild(go, "Icon")
	self._imageiconbg = gohelper.findChildImage(go, "Icon/image_IconBG")
	self._imageicon = gohelper.findChildImage(go, "Icon/image_icon")
	self._golongicon = gohelper.findChild(go, "Icon_long")
end

function WuErLiXiUnitTipItem:setItem(co)
	gohelper.setActive(self.go, true)

	self._config = co
	self._txtname.text = self._config.name
	self._txtdesc.text = self._config.desc

	gohelper.setActive(self._golongicon, self._config.id == WuErLiXiEnum.UnitType.SignalMulti)
	gohelper.setActive(self._gonormalicon, self._config.id ~= WuErLiXiEnum.UnitType.SignalMulti)

	if self._config.id ~= WuErLiXiEnum.UnitType.SignalMulti then
		local spriteName = WuErLiXiHelper.getUnitSpriteName(self._config.id, false)

		UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(self._imageicon, spriteName)
		UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(self._imageiconbg, (self._config.id == WuErLiXiEnum.UnitType.SignalStart or self._config.id == WuErLiXiEnum.UnitType.SignalEnd or nil) and "v2a4_wuerlixi_node_icon4")
	end
end

function WuErLiXiUnitTipItem:hide()
	gohelper.setActive(self.go, false)
end

return WuErLiXiUnitTipItem
