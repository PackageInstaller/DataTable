-- chunkname: @modules/logic/survival/view/role/item/SurvivalRoleSelectAttrItem.lua

module("modules.logic.survival.view.role.item.SurvivalRoleSelectAttrItem", package.seeall)

local SurvivalRoleSelectAttrItem = class("SurvivalRoleSelectAttrItem", SimpleListItem)

function SurvivalRoleSelectAttrItem:onInit()
	self.textName = gohelper.findChildTextMesh(self.viewGO, "textName")
	self.textValue = gohelper.findChildTextMesh(self.viewGO, "txt_Value")
end

function SurvivalRoleSelectAttrItem:onItemShow(data)
	local key = "SurvivalRoleAttrName_" .. self.itemIndex

	self.textName.text = luaLang(key)
	self.textValue.text = data.value
	self.onClickFunc = data.onClickFunc
	self.context = data.context
end

return SurvivalRoleSelectAttrItem
