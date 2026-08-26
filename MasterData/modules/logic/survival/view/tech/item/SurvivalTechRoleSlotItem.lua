-- chunkname: @modules/logic/survival/view/tech/item/SurvivalTechRoleSlotItem.lua

module("modules.logic.survival.view.tech.item.SurvivalTechRoleSlotItem", package.seeall)

local SurvivalTechRoleSlotItem = class("SurvivalTechRoleSlotItem", SimpleListItem)

function SurvivalTechRoleSlotItem:onInit()
	self.anim = self:getItemAnimators()[1]
	self.image_Shape = gohelper.findChildSingleImage(self.viewGO, "#image_Shape")
	self.image_Shape_Lighted = gohelper.findChildSingleImage(self.viewGO, "#image_Shape_Lighted")
	self._btnClickItem = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self.go_select = gohelper.findChild(self.viewGO, "#go_select")
	self.go_empty = gohelper.findChild(self.viewGO, "#go_empty")

	gohelper.setActive(self.go_empty, false)
end

function SurvivalTechRoleSlotItem:onAddListeners()
	return
end

function SurvivalTechRoleSlotItem:onItemShow(data)
	self.cfg = data.cfg
	self.isFinish = data.isFinish
	self.isCanUp = data.isCanUp
	self.slotIndex = data.slotIndex

	self:refreshIcon()
end

function SurvivalTechRoleSlotItem:onDestroy()
	self.image_Shape:UnLoadImage()
	self.image_Shape_Lighted:UnLoadImage()
end

function SurvivalTechRoleSlotItem:onSelectChange(isSelect)
	gohelper.setActive(self.go_select, isSelect)
end

function SurvivalTechRoleSlotItem:refreshIcon()
	if self.isFinish then
		self.icon = ResUrl.getSurvivalTalentIcon(string.format("suit_0%s" .. "/fuwen_jin_%s", self.slotIndex, self.itemIndex))

		self.image_Shape:LoadImage(self.icon)

		if self.isFinish then
			self.image_Shape_Lighted:LoadImage(self.icon)
		end
	else
		self.icon = ResUrl.getSurvivalTalentIcon(string.format("suit_0%s" .. "/fuwen_%s", self.slotIndex, self.itemIndex))

		self.image_Shape:LoadImage(self.icon)

		if self.isFinish then
			self.image_Shape_Lighted:LoadImage(self.icon)
		end
	end

	gohelper.setActive(self.image_Shape_Lighted.gameObject, self.isFinish)
end

function SurvivalTechRoleSlotItem:tryPlayCanUpAnim()
	if self.isCanUp then
		self.anim:Play("canup", 0, 0)
	end
end

function SurvivalTechRoleSlotItem:playUpAnim()
	self.anim:Play("light", 0, 0)
end

return SurvivalTechRoleSlotItem
