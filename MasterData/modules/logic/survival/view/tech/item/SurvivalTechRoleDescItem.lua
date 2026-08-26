-- chunkname: @modules/logic/survival/view/tech/item/SurvivalTechRoleDescItem.lua

module("modules.logic.survival.view.tech.item.SurvivalTechRoleDescItem", package.seeall)

local SurvivalTechRoleDescItem = class("SurvivalTechRoleDescItem", SimpleListItem)

function SurvivalTechRoleDescItem:onInit()
	self.txt_desc = self.viewGO:GetComponent(gohelper.Type_TextMesh)
	self.line = gohelper.findChild(self.viewGO, "line")
	self.select = gohelper.findChild(self.viewGO, "select")

	gohelper.setActive(self.select, false)
end

function SurvivalTechRoleDescItem:onAddListeners()
	return
end

function SurvivalTechRoleDescItem:onItemShow(data)
	self.cfg = data.cfg
	self.isFinish = data.isFinish

	if self.isFinish then
		local str = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalTechRoleDescItem_1"), {
			self.cfg.name,
			self.cfg.desc
		})

		self.txt_desc.text = string.format("<color=#27682E>%s</color>", str)
	else
		local str = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalTechRoleDescItem_1"), {
			self.cfg.name,
			self.cfg.desc
		})

		self.txt_desc.text = string.format("<color=#746F67>%s</color>", str)
	end

	gohelper.setActive(self.line, not self.isLastItem)
end

function SurvivalTechRoleDescItem:onSelectChange(isSelect)
	gohelper.setActive(self.select, isSelect)
end

function SurvivalTechRoleDescItem:playUpAnim()
	self:getItemAnimators()[1]:Play("light")
end

return SurvivalTechRoleDescItem
