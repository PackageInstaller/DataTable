-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheQuickSelectCardInfoLeft.lua

module("modules.logic.sodache.view.inside.comp.SodacheQuickSelectCardInfoLeft", package.seeall)

local SodacheQuickSelectCardInfoLeft = class("SodacheQuickSelectCardInfoLeft", SodacheCardInfoLeft)

function SodacheQuickSelectCardInfoLeft:init(go)
	SodacheQuickSelectCardInfoLeft.super.init(self, go)

	self.trans = go.transform
	self.tranInfo = gohelper.findChild(go, "Info").transform
	self.imageQuality = gohelper.findChildImage(go, "Info/Tag1/image_Quality")
	self.txtQuality = gohelper.findChildText(go, "Info/Tag1/txt_Quality")
	self.txtType = gohelper.findChildText(go, "Info/Tag2/txt_Type")
	self.imageType = gohelper.findChildImage(go, "Info/Tag2/txt_Type/image_Type")
	self.cardGo = gohelper.findChild(go, "Info/sodache_carditem")
	self.type5InfoPos = gohelper.findChild(go, "Type5/posInfo").transform
	self._infoX, self._infoY = recthelper.getAnchor(self.tranInfo)
	self.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(self.cardGo, SodacheCardItem)

	self.cardItem:showInfo()
	self.cardItem:setShowStar(true)
end

function SodacheQuickSelectCardInfoLeft:setData(data)
	SodacheQuickSelectCardInfoLeft.super.setData(self, data)
	self.cardItem:updateMo(data)

	if data.serverMo.itemCo.type == SodacheEnum.CardType.Offering then
		self.tranInfo:SetParent(self.type5InfoPos, false)
		recthelper.setAnchor(self.tranInfo, 0, 0)
	else
		self.tranInfo:SetParent(self.trans, false)
		recthelper.setAnchor(self.tranInfo, self._infoX, self._infoY)
	end
end

return SodacheQuickSelectCardInfoLeft
