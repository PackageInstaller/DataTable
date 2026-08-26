-- chunkname: @modules/logic/season/view/SeasonFightCardItem.lua

module("modules.logic.season.view.SeasonFightCardItem", package.seeall)

local SeasonFightCardItem = class("SeasonFightCardItem", UserDataDispose)

function SeasonFightCardItem:ctor(go)
	self:__onInit()

	self.go = go
	self.goTop = gohelper.findChild(go, "go_top")
	self.imageHead = gohelper.findChildImage(go, "go_top/headiconbg/image_headicon")
	self.txtName = gohelper.findChildTextMesh(go, "go_top/headiconbg/txt_owner")
	self.goSpecialCardBg = gohelper.findChild(go, "bottom/left/go_specialcardbg")
	self.goCardPos = gohelper.findChild(go, "bottom/left/go_cardpos")
	self.goSpecialCardName = gohelper.findChild(go, "bottom/right/righttop/go_special")
	self.txtSpecialCardName = gohelper.findChildTextMesh(self.goSpecialCardName, "txt_specialcardname")
	self.goNormalName = gohelper.findChild(go, "bottom/right/righttop/go_normal")
	self.txtNormalCardName = gohelper.findChildTextMesh(self.goNormalName, "txt_normalcardname")
	self._goDesc = gohelper.findChild(go, "bottom/right/desclist/txt_descitem")
	self.layoutElement = gohelper.findChild(go, "bottom"):GetComponent(typeof(UnityEngine.UI.LayoutElement))
end

SeasonFightCardItem.MainRoleItemMinHeight = 390
SeasonFightCardItem.NormalRoleItemMinHeight = 315
SeasonFightCardItem.RoleCardPos = {
	Vector2(-16.5, 0.5),
	Vector2(-16.5, 0.5),
	Vector2(-16.5, -6.5),
	Vector2(-16.5, -17),
	Vector2(-16.5, -1)
}

function SeasonFightCardItem:setData(data)
	if not data then
		gohelper.setActive(self.go, false)

		return
	end

	gohelper.setActive(self.go, true)

	self.equipId = data.equipId
	self.heroUid = data.heroUid
	self.isMainRole = not self.heroUid

	gohelper.setActive(self.goSpecialCardBg, self.isMainRole)

	if self.isMainRole then
		self.layoutElement.minHeight = SeasonFightCardItem.MainRoleItemMinHeight or SeasonFightCardItem.NormalRoleItemMinHeight
	end

	gohelper.setActive(self.goTop, data.count == 1)
	self:_setName()
	self:_setHead()
	self:_setCard(self.equipId)
	self:_setDesc(self.equipId)
end

function SeasonFightCardItem:_setName()
	if self.isMainRole then
		self.txtName.text = luaLang("seasonmainrolecardname")
	else
		local mo = HeroModel.instance:getById(self.heroUid)

		if mo and mo.config then
			if not mo.config.name then
				local name = ""

				self.txtName.text = formatLuaLang("seasoncardnames", name)
			end
		end
	end
end

function SeasonFightCardItem:_setHead()
	local headIcon = Activity104Enum.MainRoleHeadIconID

	if not self.isMainRole then
		local mo = HeroModel.instance:getById(self.heroUid)

		if mo and mo.skin then
			local skinConfig = SkinConfig.instance:getSkinCo(mo.skin)

			headIcon = skinConfig and skinConfig.headIcon
		end
	end

	gohelper.getSingleImage(self.imageHead.gameObject):LoadImage(ResUrl.roomHeadIcon(headIcon))
end

function SeasonFightCardItem:_setCard(equipId)
	if not self.cardItem then
		self.cardItem = SeasonCelebrityCardItem.New()

		self.cardItem:init(self.goCardPos, equipId, {
			noClick = true
		})
	else
		self.cardItem:reset(equipId)
	end

	local rare = SeasonConfig.instance:getSeasonEquipCo(equipId).rare
	local targetCardPos = SeasonFightCardItem.RoleCardPos[tonumber(rare)] or Vector2(0, 0)

	recthelper.setAnchor(self.goCardPos.transform, targetCardPos.x, targetCardPos.y)
end

function SeasonFightCardItem:_setDesc(equipId)
	local config = SeasonConfig.instance:getSeasonEquipCo(equipId)

	if self.isMainRole then
		gohelper.setActive(self.goSpecialCardName, true)
		gohelper.setActive(self.goNormalName, false)

		self.txtSpecialCardName.text = config.name
	else
		gohelper.setActive(self.goNormalName, true)
		gohelper.setActive(self.goSpecialCardName, false)

		self.txtNormalCardName.text = config.name
	end

	local dataList = SeasonEquipMetaUtils.getSkillEffectStrList(config)
	local propsList = SeasonEquipMetaUtils.getEquipPropsStrList(config.attrId)
	local list = {}

	for i, v in ipairs(propsList) do
		table.insert(list, v)
	end

	for i, v in ipairs(dataList) do
		table.insert(list, v)
	end

	self.itemList = self.itemList or self:getUserDataTb_()

	for i = 1, math.max(#self.itemList, #list) do
		local data = list[i]

		if not self.itemList[i] then
			local item = self:createDescItem(i)

			self:updateDescItem(self.itemList[i], data)
		end
	end
end

function SeasonFightCardItem:createDescItem(index)
	local item = {}
	local go = gohelper.cloneInPlace(self._goDesc, string.format("desc%s", index))

	item.go = go
	item.txtDesc = go:GetComponent(typeof(TMPro.TMP_Text))
	self.itemList[index] = item

	return item
end

function SeasonFightCardItem:updateDescItem(item, skillStr)
	if not skillStr then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	item.txtDesc.text = skillStr or ""
end

function SeasonFightCardItem:destroyDescItem(item)
	return
end

function SeasonFightCardItem:destroy()
	if self.itemList then
		for i, v in ipairs(self.itemList) do
			self:destroyDescItem(v)
		end

		self.itemList = nil
	end

	if self.cardItem then
		self.cardItem:destroy()

		self.cardItem = nil
	end

	self:__onDispose()
end

return SeasonFightCardItem
