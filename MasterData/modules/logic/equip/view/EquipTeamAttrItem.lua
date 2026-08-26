-- chunkname: @modules/logic/equip/view/EquipTeamAttrItem.lua

module("modules.logic.equip.view.EquipTeamAttrItem", package.seeall)

local EquipTeamAttrItem = class("EquipTeamAttrItem", ListScrollCellExtend)

function EquipTeamAttrItem:onInitView()
	self._txtvalue1 = gohelper.findChildText(self.viewGO, "#txt_value1")
	self._txtname1 = gohelper.findChildText(self.viewGO, "#txt_name1")
	self._simageicon1 = gohelper.findChildImage(self.viewGO, "#simage_icon1")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipTeamAttrItem:addEvents()
	return
end

function EquipTeamAttrItem:removeEvents()
	return
end

function EquipTeamAttrItem:_editableInitView()
	return
end

function EquipTeamAttrItem:_editableAddEvents()
	return
end

function EquipTeamAttrItem:_editableRemoveEvents()
	return
end

function EquipTeamAttrItem:onUpdateMO(mo)
	self._mo = mo

	local attrId = self._mo.attrId
	local _attrCo = HeroConfig.instance:getHeroAttributeCO(attrId)

	CharacterController.instance:SetAttriIcon(self._simageicon1, attrId)

	self._txtvalue1.text = EquipConfig.instance:getEquipValueStr(self._mo)
	self._txtname1.text = _attrCo.name
end

function EquipTeamAttrItem:onSelect(isSelect)
	return
end

function EquipTeamAttrItem:onDestroyView()
	return
end

return EquipTeamAttrItem
