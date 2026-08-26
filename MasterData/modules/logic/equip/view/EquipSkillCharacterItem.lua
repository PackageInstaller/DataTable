-- chunkname: @modules/logic/equip/view/EquipSkillCharacterItem.lua

module("modules.logic.equip.view.EquipSkillCharacterItem", package.seeall)

local EquipSkillCharacterItem = class("EquipSkillCharacterItem", ListScrollCellExtend)

function EquipSkillCharacterItem:onInitView()
	self._gocharacter = gohelper.findChild(self.viewGO, "#go_character")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_character/#simage_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_character/#txt_name")
	self._goclick = gohelper.findChild(self.viewGO, "#go_character/#go_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipSkillCharacterItem:addEvents()
	return
end

function EquipSkillCharacterItem:removeEvents()
	return
end

function EquipSkillCharacterItem:_editableInitView()
	self._click = gohelper.getClickWithAudio(self._goclick)

	self._click:AddClickListener(self._onClick, self)
end

function EquipSkillCharacterItem:_onClick()
	if self._hero then
		CharacterController.instance:openCharacterView(self._hero)
		EquipController.instance:closeEquipSkillTipView()
	else
		GameFacade.showToast(ToastEnum.EquipSkillCharacter)
	end
end

function EquipSkillCharacterItem:_editableAddEvents()
	return
end

function EquipSkillCharacterItem:_editableRemoveEvents()
	return
end

function EquipSkillCharacterItem:onUpdateMO(mo)
	local heroCo = HeroConfig.instance:getHeroCO(mo.id)
	local skinConfig = SkinConfig.instance:getSkinCo(heroCo.skinId)

	self._simageicon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.retangleIcon))

	self._txtname.text = heroCo.name
	self._hero = HeroModel.instance:getByHeroId(mo.id)

	SLFramework.UGUI.GuiHelper.SetColor(self._simageicon:GetComponent(gohelper.Type_Image), self._hero and "#FFFFFF" or "#5E6161")
end

function EquipSkillCharacterItem:onSelect(isSelect)
	return
end

function EquipSkillCharacterItem:onDestroyView()
	self._click:RemoveClickListener()
end

return EquipSkillCharacterItem
