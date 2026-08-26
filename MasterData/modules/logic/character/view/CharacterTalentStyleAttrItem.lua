-- chunkname: @modules/logic/character/view/CharacterTalentStyleAttrItem.lua

module("modules.logic.character.view.CharacterTalentStyleAttrItem", package.seeall)

local CharacterTalentStyleAttrItem = class("CharacterTalentStyleAttrItem", LuaCompBase)

function CharacterTalentStyleAttrItem:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "#go_bg")
	self._gonew = gohelper.findChild(self.viewGO, "#go_new")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#image_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_name/#txt_num")
	self._txtchange = gohelper.findChildText(self.viewGO, "#txt_name/#txt_num/#txt_change")
	self._imagechange = gohelper.findChildImage(self.viewGO, "#txt_name/#txt_num/#image_change")
	self._godelete = gohelper.findChild(self.viewGO, "#go_delete")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterTalentStyleAttrItem:addEvents()
	return
end

function CharacterTalentStyleAttrItem:removeEvents()
	return
end

function CharacterTalentStyleAttrItem:_editableInitView()
	return
end

function CharacterTalentStyleAttrItem:init(go)
	self.viewGO = go

	self:onInitView()

	self._canvasgroup = go:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function CharacterTalentStyleAttrItem:addEventListeners()
	self:addEvents()
end

function CharacterTalentStyleAttrItem:removeEventListeners()
	self:removeEvents()
end

function CharacterTalentStyleAttrItem:onStart()
	return
end

function CharacterTalentStyleAttrItem:onDestroy()
	return
end

function CharacterTalentStyleAttrItem:onRefreshMo(index, mo)
	local config = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(mo.key))
	local valueStr
	local value = mo.isDelete and 0 or mo.value

	self._txtnum.text = config.type ~= 1 and value * 0.1 .. "%" or math.floor(value)
	self._txtname.text = config.name

	gohelper.setActive(self._gobg.gameObject, index % 2 == 0)
	UISpriteSetMgr.instance:setCommonSprite(self._imageicon, "icon_att_" .. config.id, true)
	self:_showAttrChage(mo)
end

function CharacterTalentStyleAttrItem:_showAttrChage(mo)
	local _attrChangeType = 0

	if mo.isNew then
		_attrChangeType = 3
	end

	if mo.isDelete then
		_attrChangeType = 4
	end

	local _attrChange = CharacterTalentStyleEnum.AttrChange[(mo.changeNum or nil) and (mo.changeNum > 0 and 1 or 2)]

	self._txtnum.color = GameUtil.parseColor(_attrChange.NumColor)

	local isChangeImage = not string.nilorempty(_attrChange.ChangeImage)

	if isChangeImage then
		UISpriteSetMgr.instance:setUiCharacterSprite(self._imagechange, _attrChange.ChangeImage)
	end

	gohelper.setActive(self._imagechange.gameObject, isChangeImage)

	local isChangeTxt = not string.nilorempty(_attrChange.ChangeText)

	if isChangeTxt then
		self._txtchange.text = _attrChange.ChangeText
		self._txtchange.color = GameUtil.parseColor(_attrChange.ChangeColor)
	end

	if not _attrChange.Alpha then
		self._canvasgroup.alpha = 1

		gohelper.setActive(self._txtchange.gameObject, isChangeTxt)
		gohelper.setActive(self._gonew.gameObject, mo.isNew)
		gohelper.setActive(self._godelete.gameObject, mo.isDelete)
	end
end

return CharacterTalentStyleAttrItem
