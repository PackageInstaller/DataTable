-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackTalentPetSkillItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackTalentPetSkillItem", package.seeall)

local Rouge2_BackpackTalentPetSkillItem = class("Rouge2_BackpackTalentPetSkillItem", Rouge2_BackpackSkillShowItemBase)

function Rouge2_BackpackTalentPetSkillItem:init(go)
	Rouge2_BackpackTalentPetSkillItem.super.init(self, go)

	self._simageSkillIcon = gohelper.findChildSingleImage(self.go, "#go_UnEmpty/simage_SkillIcon")
end

function Rouge2_BackpackTalentPetSkillItem:refreshLockUI()
	return
end

function Rouge2_BackpackTalentPetSkillItem:refreshEmptyUI()
	return
end

function Rouge2_BackpackTalentPetSkillItem:refreshEquipUI()
	Rouge2_IconHelper.setGameItemIcon(self._skillId, self._simageSkillIcon)
end

function Rouge2_BackpackTalentPetSkillItem:refreshCommonUI()
	return
end

function Rouge2_BackpackTalentPetSkillItem:onBtnClickCallback()
	local dataType, dataId = self:getSkillDataTypeAndId()

	Rouge2_ViewHelper.openActiveSkillAttrUpdateTipsView(dataType, dataId)
end

function Rouge2_BackpackTalentPetSkillItem:onDestroy()
	Rouge2_BackpackTalentPetSkillItem.super.onDestroy(self)
	self._simageSkillIcon:UnLoadImage()
end

return Rouge2_BackpackTalentPetSkillItem
