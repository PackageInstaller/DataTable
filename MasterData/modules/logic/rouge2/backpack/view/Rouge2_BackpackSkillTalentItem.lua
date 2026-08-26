-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillTalentItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillTalentItem", package.seeall)

local Rouge2_BackpackSkillTalentItem = class("Rouge2_BackpackSkillTalentItem", Rouge2_BackpackTalentItemBase)

function Rouge2_BackpackSkillTalentItem:init(go)
	Rouge2_BackpackSkillTalentItem.super.init(self, go)

	self._goSkill = gohelper.findChild(self.go, "go_Skill")
	self._goSkillItem = self._parentView:getResInst(Rouge2_Enum.ResPath.BackpackSkillShowItem, self._goSkill, "skillItem")
	self._goParentScoll = gohelper.findChild(self._parentView.viewGO, "SkillTalent/#go_TalentContainer")
end

function Rouge2_BackpackSkillTalentItem:_btnClickOnClick()
	if self._status ~= Rouge2_Enum.ActiveSkillHoleStatus.Equip then
		self:tryOpenDetailView()

		return
	end

	if not self._skillItem then
		return
	end

	local dataType, dataId = self._skillItem:getSkillDataTypeAndId()

	Rouge2_ViewHelper.openActiveSkillAttrUpdateTipsView(dataType, dataId)
end

function Rouge2_BackpackSkillTalentItem:refreshInfo(talentCo)
	Rouge2_BackpackSkillTalentItem.super.refreshInfo(self, talentCo)

	self._holeIndex = talentCo and talentCo.ordinal
end

function Rouge2_BackpackSkillTalentItem:refreshUI()
	if not self._skillItem then
		self._skillItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goSkillItem, Rouge2_BackpackSkillShowItem, self._holeIndex)

		self._skillItem:setScrollParentGO(self._goParentScoll)
	end

	self._skillItem:onUpdateMO()
end

return Rouge2_BackpackSkillTalentItem
