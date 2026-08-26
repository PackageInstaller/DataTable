-- chunkname: @modules/logic/rouge2/start/view/Rouge2_CareerActiveSkillItem.lua

module("modules.logic.rouge2.start.view.Rouge2_CareerActiveSkillItem", package.seeall)

local Rouge2_CareerActiveSkillItem = class("Rouge2_CareerActiveSkillItem", LuaCompBase)

Rouge2_CareerActiveSkillItem.PercentColor = "#F3A055"
Rouge2_CareerActiveSkillItem.BracketColor = "#5E7DD9"
Rouge2_CareerActiveSkillItem.DescIncludeTypeList = {
	Rouge2_Enum.RelicsDescType.Desc
}

function Rouge2_CareerActiveSkillItem:init(go)
	self.go = go
	self._simageSkillIcon = gohelper.findChildSingleImage(self.go, "#image_SkillIcon")
	self._txtDescr = gohelper.findChildText(self.go, "#txt_Descr")
	self._txtName = gohelper.findChildText(self.go, "#txt_Name")
end

function Rouge2_CareerActiveSkillItem:onUpdateMO(careerId, skillId)
	self._careerId = careerId
	self._skillId = skillId
	self._careerCo = Rouge2_CareerConfig.instance:getCareerConfig(careerId)
	self._skillCo = Rouge2_CollectionConfig.instance:getActiveSkillConfig(skillId)

	self:refreshUI()
end

function Rouge2_CareerActiveSkillItem:refreshUI()
	self._txtName.text = self._skillCo and self._skillCo.name

	Rouge2_ItemDescHelper.setItemDescStr(Rouge2_Enum.ItemDataType.Config, self._skillId, self._txtDescr, Rouge2_Enum.ItemDescMode.Simply, Rouge2_CareerActiveSkillItem.DescIncludeTypeList, Rouge2_CareerActiveSkillItem.PercentColor, Rouge2_CareerActiveSkillItem.BracketColor)
	Rouge2_IconHelper.setActiveSkillIcon(self._skillId, self._simageSkillIcon)
end

function Rouge2_CareerActiveSkillItem:onDestory()
	self._simageSkillIcon:UnLoadImage()
end

return Rouge2_CareerActiveSkillItem
