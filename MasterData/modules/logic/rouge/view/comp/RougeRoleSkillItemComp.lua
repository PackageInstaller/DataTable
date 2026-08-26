-- chunkname: @modules/logic/rouge/view/comp/RougeRoleSkillItemComp.lua

module("modules.logic.rouge.view.comp.RougeRoleSkillItemComp", package.seeall)

local RougeRoleSkillItemComp = class("RougeRoleSkillItemComp", LuaCompBase)

function RougeRoleSkillItemComp:init(go)
	self._go = go
	self._assitSkillIcon = gohelper.findChildSingleImage(self._go, "imgIcon")
	self._assitSkillTagIcon = gohelper.findChildSingleImage(self._go, "tag/tagIcon")
	self._click = gohelper.findChildButtonWithAudio(self._go, "bg")

	self._click:AddClickListener(self._onClick, self)
end

function RougeRoleSkillItemComp:setClickCallback(callback, target)
	self._callback = callback
	self._target = target
end

function RougeRoleSkillItemComp:setHeroId(heroId)
	self._heroId = heroId
end

function RougeRoleSkillItemComp:_onClick()
	if self._callback then
		self._callback(self._target)
	end
end

function RougeRoleSkillItemComp:setSelected(value)
	self._frameGo = self._frameGo or gohelper.findChild(self._go, "selectframe")

	self._frameGo:SetActive(value)
end

function RougeRoleSkillItemComp:getSkillCO()
	return self._skillCO
end

function RougeRoleSkillItemComp:refresh(skillCO)
	self._skillCO = skillCO

	self._assitSkillIcon:LoadImage(ResUrl.getSkillIcon(skillCO.icon))
	self._assitSkillTagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillCO.showTag))

	if self._heroId then
		RougeModel.instance:getTeamInfo():setSupportSkill(self._heroId, skillCO.id)
	end
end

function RougeRoleSkillItemComp:onDestroy()
	self._click:RemoveClickListener()
end

return RougeRoleSkillItemComp
