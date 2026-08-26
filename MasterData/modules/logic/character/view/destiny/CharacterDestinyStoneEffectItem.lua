-- chunkname: @modules/logic/character/view/destiny/CharacterDestinyStoneEffectItem.lua

module("modules.logic.character.view.destiny.CharacterDestinyStoneEffectItem", package.seeall)

local CharacterDestinyStoneEffectItem = class("CharacterDestinyStoneEffectItem", LuaCompBase)

function CharacterDestinyStoneEffectItem:onInitView()
	self._gounlock = gohelper.findChild(self.viewGO, "#go_unlock")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_unlock/#txt_desc")
	self._gounlocktip = gohelper.findChild(self.viewGO, "#go_unlocktip")
	self._txtunlocktips = gohelper.findChildText(self.viewGO, "#go_unlocktip/#txt_unlocktips")
	self._goreshapeItem = gohelper.findChild(self.viewGO, "#go_reshapeItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDestinyStoneEffectItem:addEvents()
	return
end

function CharacterDestinyStoneEffectItem:removeEvents()
	return
end

function CharacterDestinyStoneEffectItem:_editableInitView()
	return
end

function CharacterDestinyStoneEffectItem:init(go)
	self.viewGO = go

	self:onInitView()

	self._unlockInfoItems = self:getUserDataTb_()
	self._lockInfoItems = self:getUserDataTb_()
	self._reshapeItems = self:getUserDataTb_()

	gohelper.setActive(self.viewGO, true)
	gohelper.setActive(self._gounlock, false)
	gohelper.setActive(self._gounlocktip, false)
	gohelper.setActive(self._goreshapeItem, false)
end

function CharacterDestinyStoneEffectItem:addEventListeners()
	self:addEvents()
end

function CharacterDestinyStoneEffectItem:removeEventListeners()
	self:removeEvents()
end

function CharacterDestinyStoneEffectItem:onUpdateMo(mo)
	local descList = mo:getReshapeDesc()

	if descList then
		for i, desc in ipairs(descList) do
			local item = self:_getReshapeItem(i)
			local lang = luaLang("character_destinystone_reshape_lv")

			item.titleTxt.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, i)
			item.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(item.descTxt.gameObject, SkillDescComp)

			item.skillDesc:updateInfo(item.descTxt, desc, mo.heroId)
			item.skillDesc:setTipParam(0, Vector2(380, 100))
			gohelper.setSibling(item.go, i)
		end
	end

	if mo.curUseStoneId == 0 then
		return
	end

	self._rank = mo.rank
	self._mo = mo
	self._cos = CharacterDestinyConfig.instance:getDestinyFacetCo(mo.curUseStoneId)

	if self._cos then
		for i, co in ipairs(self._cos) do
			local item = co.level <= self._rank and self:_getUnlockItem(i) or self:_getLockItem(i)

			item.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(item.txt.gameObject, SkillDescComp)

			item.skillDesc:updateInfo(item.txt, co.desc, mo.heroId)
			item.skillDesc:setTipParam(0, Vector2(380, 100))
			gohelper.setSibling(item.go, i)
		end

		self:_showNormalItem(false)
	end
end

function CharacterDestinyStoneEffectItem:_getUnlockItem(index)
	local item = self._unlockInfoItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gounlock, "unlock" .. index)

		item.go = go
		item.txt = gohelper.findChildText(go, "#txt_desc")
		self._unlockInfoItems[index] = item
	end

	return item
end

function CharacterDestinyStoneEffectItem:_getLockItem(index)
	local item = self._lockInfoItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gounlocktip, "lock" .. index)

		item.go = go
		item.txt = gohelper.findChildText(go, "#txt_unlocktips")
		self._lockInfoItems[index] = item
	end

	return item
end

function CharacterDestinyStoneEffectItem:_getReshapeItem(index)
	local item = self._reshapeItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._goreshapeItem, "reshape" .. index)

		item.go = go
		item.descTxt = gohelper.findChildText(go, "desc")
		item.titleTxt = gohelper.findChildText(go, "title")
		self._reshapeItems[index] = item
	end

	return item
end

function CharacterDestinyStoneEffectItem:showReshape(show)
	if show then
		self:_showNormalItem(true)
		self:_showReshapeItem(true)
	else
		self:_showNormalItem(false)
		self:_showReshapeItem(false)
	end
end

function CharacterDestinyStoneEffectItem:_showNormalItem(forceHide)
	for i, item in pairs(self._unlockInfoItems) do
		gohelper.setActive(item.go, not forceHide and i <= self._rank)
	end

	for i, item in pairs(self._lockInfoItems) do
		gohelper.setActive(item.go, not forceHide and i > self._rank and i <= #self._cos)
	end
end

function CharacterDestinyStoneEffectItem:_showReshapeItem(show)
	for i = 1, #self._reshapeItems do
		gohelper.setActive(self._reshapeItems[i].go, show)
	end
end

return CharacterDestinyStoneEffectItem
