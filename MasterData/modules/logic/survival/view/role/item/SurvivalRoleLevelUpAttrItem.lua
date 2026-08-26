-- chunkname: @modules/logic/survival/view/role/item/SurvivalRoleLevelUpAttrItem.lua

module("modules.logic.survival.view.role.item.SurvivalRoleLevelUpAttrItem", package.seeall)

local SurvivalRoleLevelUpAttrItem = class("SurvivalRoleLevelUpAttrItem", SimpleListItem)

function SurvivalRoleLevelUpAttrItem:onInit()
	self.textValue = gohelper.findChildTextMesh(self.viewGO, "textValue")
	self.textAttrName = gohelper.findChildTextMesh(self.viewGO, "textAttrName")
	self.increase = gohelper.findChild(self.viewGO, "increase")
end

function SurvivalRoleLevelUpAttrItem:onAddListeners()
	return
end

function SurvivalRoleLevelUpAttrItem:onRemoveListeners()
	return
end

function SurvivalRoleLevelUpAttrItem:onItemShow(data)
	self.isIncrease = data.isIncrease
	self.old = data.old
	self.new = data.new
	self.textValue.text = data.value

	local key = "SurvivalRoleAttrName_" .. self.itemIndex

	self.textAttrName.text = luaLang(key)

	gohelper.setActive(self.increase, false)
end

function SurvivalRoleLevelUpAttrItem:getNumAnimWork()
	if self.isIncrease then
		return FunctionWork.New(function()
			self.textValue.text = string.format("<color=#873803>%s</color>", math.floor(self.new))
		end)
	end
end

return SurvivalRoleLevelUpAttrItem
