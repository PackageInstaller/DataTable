-- chunkname: @modules/logic/survival/view/tech/item/SurvivalTechCellItem.lua

module("modules.logic.survival.view.tech.item.SurvivalTechCellItem", package.seeall)

local SurvivalTechCellItem = class("SurvivalTechCellItem", SimpleListItem)

function SurvivalTechCellItem:onInit()
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.image_talenicon = gohelper.findChildImage(self.viewGO, "#image_talenicon")
	self.State_Lock = gohelper.findChild(self.viewGO, "State_Lock")
	self.State_CanUp = gohelper.findChild(self.viewGO, "State_CanUp")
	self.State_Finish = gohelper.findChild(self.viewGO, "State_Finish")
	self.Select = gohelper.findChild(self.viewGO, "Select")
	self.State_Sp = gohelper.findChild(self.viewGO, "State_Sp")
end

function SurvivalTechCellItem:onAddListeners()
	return
end

function SurvivalTechCellItem:onItemShow(data)
	self.cfg = data.cfg
	self.survivalOutSideTechMo = SurvivalModel.instance:getOutSideInfo().survivalOutSideTechMo
	self.isFinish = self.survivalOutSideTechMo:isFinish(self.cfg.belongRole, self.cfg.id)
	self.isCanUp = self.survivalOutSideTechMo:isCanUp(self.cfg.belongRole, self.cfg.id)
	self.isLock = not self.isFinish and not self.isCanUp

	local alpha = self.isLock and 0.5 or 1

	if not string.nilorempty(self.cfg.icon) then
		UISpriteSetMgr.instance:setSurvivalSprite2(self.image_talenicon, self.cfg.icon, nil, alpha)
	end

	ZProj.UGUIHelper.SetColorAlpha(self.image_talenicon, alpha)
	gohelper.setActive(self.State_Finish, self.isFinish)
	gohelper.setActive(self.State_CanUp, self.isCanUp)
	gohelper.setActive(self.State_Lock, self.isLock)
	gohelper.setActive(self.State_Sp, self.cfg.sign == 1)
end

function SurvivalTechCellItem:onSelectChange(isSelect)
	gohelper.setActive(self.Select, isSelect)
end

function SurvivalTechCellItem:playUpAnim()
	self.animator:Play("light", 0, 0)
end

return SurvivalTechCellItem
