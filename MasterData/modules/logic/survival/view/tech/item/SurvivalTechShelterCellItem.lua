-- chunkname: @modules/logic/survival/view/tech/item/SurvivalTechShelterCellItem.lua

module("modules.logic.survival.view.tech.item.SurvivalTechShelterCellItem", package.seeall)

local SurvivalTechShelterCellItem = class("SurvivalTechShelterCellItem", SimpleListItem)

function SurvivalTechShelterCellItem:onInit()
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.image_talenicon = gohelper.findChildImage(self.viewGO, "#image_talenicon")
	self.State_Lock = gohelper.findChild(self.viewGO, "State_Lock")
	self.State_CanUp = gohelper.findChild(self.viewGO, "State_CanUp")
	self.State_Finish = gohelper.findChild(self.viewGO, "State_Finish")
	self.Select = gohelper.findChild(self.viewGO, "Select")
	self.State_Sp = gohelper.findChild(self.viewGO, "State_Sp")
end

function SurvivalTechShelterCellItem:onAddListeners()
	return
end

function SurvivalTechShelterCellItem:onItemShow(data)
	self.cfg = data.cfg
	self.survivalTechShelterMo = data.survivalTechShelterMo
	self.isFinish = self.survivalTechShelterMo:isFinish(self.cfg.id)
	self.isCanUp = self.survivalTechShelterMo:isCanUp(self.cfg.id)
	self.isLock = not self.isFinish and not self.isCanUp

	local alpha = self.isLock and 0.5 or 1

	if not string.nilorempty(self.cfg.icon) then
		UISpriteSetMgr.instance:setSurvivalSprite2(self.image_talenicon, self.cfg.icon)
	end

	ZProj.UGUIHelper.SetColorAlpha(self.image_talenicon, alpha)
	gohelper.setActive(self.State_Finish, self.isFinish)
	gohelper.setActive(self.State_CanUp, self.isCanUp)
	gohelper.setActive(self.State_Lock, self.isLock)
	gohelper.setActive(self.State_Sp, self.cfg.sign == 1)

	if self.isLock then
		ZProj.UGUIHelper.SetColorAlpha(self.image_talenicon, 0.5)
	else
		ZProj.UGUIHelper.SetColorAlpha(self.image_talenicon, 1)
	end
end

function SurvivalTechShelterCellItem:onSelectChange(isSelect)
	gohelper.setActive(self.Select, isSelect)
end

function SurvivalTechShelterCellItem:playUpAnim()
	self.animator:Play("light")
end

return SurvivalTechShelterCellItem
