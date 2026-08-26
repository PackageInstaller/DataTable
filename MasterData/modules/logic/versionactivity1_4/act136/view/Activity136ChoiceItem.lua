-- chunkname: @modules/logic/versionactivity1_4/act136/view/Activity136ChoiceItem.lua

module("modules.logic.versionactivity1_4.act136.view.Activity136ChoiceItem", package.seeall)

local Activity136ChoiceItem = class("Activity136ChoiceItem", ListScrollCell)

function Activity136ChoiceItem:init(go)
	self._go = go
	self._txtnum = gohelper.findChildText(self._go, "num/#txt_num")

	local goClick = gohelper.findChild(self._go, "go_click")

	self._btnClick = gohelper.getClickWithAudio(goClick, AudioEnum.UI.UI_vertical_first_tabs_click)
	self._goSelected = gohelper.findChild(self._go, "select")
	self._imagerare = gohelper.findChildImage(self._go, "role/rare")
	self._simageicon = gohelper.findChildSingleImage(self._go, "role/heroicon")
	self._imagecareer = gohelper.findChildImage(self._go, "role/career")
	self._txtname = gohelper.findChildText(self._go, "role/name")
	self._txtnameen = gohelper.findChildText(self._go, "role/name/nameEn")
	self._isSelected = false

	self:addEvents()
end

function Activity136ChoiceItem:addEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function Activity136ChoiceItem:removeEvents()
	self._btnClick:RemoveClickListener()
end

function Activity136ChoiceItem:_onClick()
	local isInOpen = Activity136Model.instance:isActivity136InOpen(true)

	if not isInOpen then
		return
	end

	local hasReceive = Activity136Model.instance:hasReceivedCharacter()

	if hasReceive then
		GameFacade.showToast(ToastEnum.Activity136AlreadyReceive)

		return
	end

	local isSelected = not self._isSelected
	local selectId

	if isSelected then
		selectId = self._mo and self._mo.id
	end

	self._view:selectCell(self._index, isSelected)
	Activity136Controller.instance:dispatchEvent(Activity136Event.SelectCharacter, selectId)
end

function Activity136ChoiceItem:onUpdateMO(mo)
	self._mo = mo

	local characterCfg = HeroConfig.instance:getHeroCO(self._mo.id)

	if not characterCfg then
		logError("Activity136CharacterItem.onUpdateMO error, characterCfg is nil, id:" .. tostring(self._mo.id))

		return
	end

	local skinConfig = SkinConfig.instance:getSkinCo(characterCfg.skinId)

	if not skinConfig then
		logError("Activity136CharacterItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(characterCfg.skinId))

		return
	end

	self._simageicon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. characterCfg.career)
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. CharacterEnum.Color[characterCfg.rare])

	self._txtname.text = characterCfg.name
	self._txtnameen.text = characterCfg.nameEng

	local duplicateItemCount = 0
	local duplicateItem = characterCfg.duplicateItem

	if not string.nilorempty(duplicateItem) then
		local items = string.split(duplicateItem, "|")
		local item = items[1]

		if item then
			local itemParams = string.splitToNumber(item, "#")

			duplicateItemCount = ItemModel.instance:getItemQuantity(itemParams[1], itemParams[2])
		end
	end

	local str
	local heroMo = HeroModel.instance:getByHeroId(self._mo.id)

	if heroMo then
		local exSkillLevel = heroMo.exSkillLevel

		str = formatLuaLang("has_num", exSkillLevel + 1 + duplicateItemCount)
	else
		str = luaLang("not_has")
	end

	self._txtnum.text = str
end

function Activity136ChoiceItem:onSelect(isSelect)
	self._isSelected = isSelect

	gohelper.setActive(self._goSelected, self._isSelected)
end

function Activity136ChoiceItem:onDestroy()
	self._isSelected = false

	self._simageicon:UnLoadImage()
	self:removeEvents()
end

return Activity136ChoiceItem
