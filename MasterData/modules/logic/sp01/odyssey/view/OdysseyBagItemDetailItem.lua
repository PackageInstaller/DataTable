-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyBagItemDetailItem.lua

module("modules.logic.sp01.odyssey.view.OdysseyBagItemDetailItem", package.seeall)

local OdysseyBagItemDetailItem = class("OdysseyBagItemDetailItem", LuaCompBase)

function OdysseyBagItemDetailItem:init(go)
	self.viewGO = go
	self._txtitemName = gohelper.findChildText(self.viewGO, "#txt_itemName")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#scroll_desc/Viewport/Content/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyBagItemDetailItem:setInfo(mo)
	self.mo = mo

	self:refreshUI()
end

function OdysseyBagItemDetailItem:refreshUI()
	local mo = self.mo
	local itemConfig = mo.config

	self._simageicon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(itemConfig.icon))

	self._txtdesc.text = itemConfig.desc
	self._txtitemName.text = itemConfig.name
end

function OdysseyBagItemDetailItem:onDestroy()
	return
end

return OdysseyBagItemDetailItem
