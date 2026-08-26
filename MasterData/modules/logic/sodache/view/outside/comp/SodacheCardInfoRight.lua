-- chunkname: @modules/logic/sodache/view/outside/comp/SodacheCardInfoRight.lua

module("modules.logic.sodache.view.outside.comp.SodacheCardInfoRight", package.seeall)

local SodacheCardInfoRight = class("SodacheCardInfoRight", LuaCompBase)

SodacheCardInfoRight.ShowType = {
	Handbook = 1,
	Shop = 2
}

function SodacheCardInfoRight:ctor(type)
	self.type = type or SodacheCardInfoRight.ShowType.Handbook
end

function SodacheCardInfoRight:init(go)
	local goCard = gohelper.findChild(go, "CardItem")

	self.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(goCard, SodacheCardItem)

	self.cardItem:setActiveClick(false)

	self.imageRare = gohelper.findChildImage(go, "Tags/image_Rare")
	self.txtRare = gohelper.findChildText(go, "Tags/image_Rare/txt_Rare")
	self.goType = gohelper.findChild(go, "Tags/go_Type")
	self.txtType = gohelper.findChildText(go, "Tags/go_Type/txt_Type")
	self.imageType = gohelper.findChildImage(go, "Tags/go_Type/txt_Type/image_Type")
	self.goKezhi = gohelper.findChild(go, "Tags/go_Kezhi")
	self.imageKezhi = gohelper.findChildImage(go, "Tags/go_Kezhi/image_Kezhi")
	self.txtKezhi = gohelper.findChildText(go, "Tags/go_Kezhi/txt_Kezhi")
	self.goAdventureInfo = gohelper.findChild(go, "go_AdventureInfo")
	self.txtAdventureDesc = gohelper.findChildText(self.goAdventureInfo, "Scroll/Viewport/Content/txt_AdventureDesc")
	self.goDices = gohelper.findChild(self.goAdventureInfo, "Dices")
	self.goDiceItem = gohelper.findChild(self.goAdventureInfo, "Dices/go_DiceItem")

	gohelper.setActive(self.goDiceItem, false)

	self.goBulletInfo = gohelper.findChild(go, "go_BulletInfo")
	self.txtBulletDesc = gohelper.findChildText(self.goBulletInfo, "txt_BulletDesc")
end

function SodacheCardInfoRight:setData(data)
	self.data = data

	self.cardItem:updateMo(data)

	self.config = data.serverMo.itemCo

	UISpriteSetMgr.instance:setSodache2Sprite(self.imageRare, "sodache_carddetail_tag_0" .. tostring(self.config.quality))

	self.txtRare.text = luaLang("sodache_cardquality_" .. tostring(self.config.quality))

	local cardType = self.config.type

	self.txtType.text = luaLang("sodache_cardtype_" .. tostring(cardType))

	UISpriteSetMgr.instance:setSodache2Sprite(self.imageType, "sodache_handbook_icon_" .. tostring(cardType))

	if cardType == SodacheEnum.CardType.Adventure then
		self:refreshSpecial()
	else
		self:refreshNormal()
	end

	gohelper.setActive(self.goAdventureInfo, cardType == SodacheEnum.CardType.Adventure)
	gohelper.setActive(self.goBulletInfo, cardType ~= SodacheEnum.CardType.Adventure)
end

function SodacheCardInfoRight:refreshNormal()
	if self.type == SodacheCardInfoRight.ShowType.Handbook then
		self.txtBulletDesc.text = SodacheUtil.changeDescColor(self.config.desc)
	elseif self.type == SodacheCardInfoRight.ShowType.Shop then
		self.txtBulletDesc.text = SodacheUtil.changeDescColor(self.config.funcDesc)
	end
end

function SodacheCardInfoRight:refreshSpecial()
	if self.type == SodacheCardInfoRight.ShowType.Handbook then
		self.txtAdventureDesc.text = SodacheUtil.changeDescColor(self.config.desc)
	elseif self.type == SodacheCardInfoRight.ShowType.Shop then
		self.txtAdventureDesc.text = SodacheUtil.changeDescColor(self.config.funcDesc)

		local diceIds = string.splitToNumber(self.config.diceList, "#") or {}
		local scale = #diceIds <= 4 and 1 or 0.7

		transformhelper.setLocalScale(self.goDices.transform, scale, scale, 1)
		gohelper.CreateObjList(self, self._createDiceItem, diceIds, nil, self.goDiceItem, SodacheDiceItem)
	end
end

function SodacheCardInfoRight:_createDiceItem(obj, data, index)
	obj:setData(data, true)
end

return SodacheCardInfoRight
