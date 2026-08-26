-- chunkname: @modules/logic/survival/view/role/item/SurvivalRoleSelectSkillItem.lua

module("modules.logic.survival.view.role.item.SurvivalRoleSelectSkillItem", package.seeall)

local SurvivalRoleSelectSkillItem = class("SurvivalRoleSelectSkillItem", SimpleListItem)

function SurvivalRoleSelectSkillItem:onInit()
	self.Image_SkillIcon = gohelper.findChildImage(self.viewGO, "skill/#Image_SkillIcon")
	self.txt_SkillDesc = gohelper.findChildTextMesh(self.viewGO, "#txt_SkillDesc")
end

function SurvivalRoleSelectSkillItem:onAddListeners()
	return
end

function SurvivalRoleSelectSkillItem:onItemShow(data)
	self.skillId = data.skillId
	self.heroId = data.heroId
	self.cfg = lua_survival_role_skill.configDict[self.skillId]
	self.txt_SkillDesc.text = SurvivalRoleConfig.instance:getSkillDesc(self.heroId)

	local res = self.cfg.resource

	UISpriteSetMgr.instance:setSurvivalSprite2(self.Image_SkillIcon, res, true)
end

return SurvivalRoleSelectSkillItem
