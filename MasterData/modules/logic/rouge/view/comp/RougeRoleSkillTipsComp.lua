-- chunkname: @modules/logic/rouge/view/comp/RougeRoleSkillTipsComp.lua

module("modules.logic.rouge.view.comp.RougeRoleSkillTipsComp", package.seeall)

local RougeRoleSkillTipsComp = class("RougeRoleSkillTipsComp", LuaCompBase)

function RougeRoleSkillTipsComp:init(go)
	self._go = go
	self._skillicon1 = self._addSkillItem(self, gohelper.findChild(self._go, "skillicon1"), self._onSkill1Click, self)
	self._skillicon2 = self._addSkillItem(self, gohelper.findChild(self._go, "skillicon2"), self._onSkill2Click, self)
	self._click = gohelper.findChildButtonWithAudio(self._go, "block")

	self._click:AddClickListener(self._onClick, self)
end

function RougeRoleSkillTipsComp:setClickCallback(callback, target)
	self._callback = callback
	self._target = target
end

function RougeRoleSkillTipsComp:_onClick()
	if self._callback then
		self._callback(self._target)
	end
end

function RougeRoleSkillTipsComp:_onSkill1Click()
	self._displaySkillItemComp:refresh(self._skillicon1:getSkillCO())
	self:_setSkillIconSelected(true)
	RougeHeroGroupModel.instance:rougeSaveCurGroup()
end

function RougeRoleSkillTipsComp:_onSkill2Click()
	self._displaySkillItemComp:refresh(self._skillicon2:getSkillCO())
	self:_setSkillIconSelected(false)
	RougeHeroGroupModel.instance:rougeSaveCurGroup()
end

function RougeRoleSkillTipsComp:_setSkillIconSelected(value)
	self._skillicon1:setSelected(value)
	self._skillicon2:setSelected(not value)
end

function RougeRoleSkillTipsComp:_addSkillItem(go, callback, target)
	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, RougeRoleSkillItemComp)

	comp:setClickCallback(callback, target)

	return comp
end

function RougeRoleSkillTipsComp:refresh(skillList, displaySkillItemComp)
	self._displaySkillItemComp = displaySkillItemComp

	local selectedSkillCO = displaySkillItemComp:getSkillCO()

	for i, skillId in pairs(skillList) do
		local skillCO = lua_skill.configDict[skillId]

		if skillCO then
			local comp = self["_skillicon" .. i]

			if comp then
				comp:refresh(skillCO)
				comp:setSelected(selectedSkillCO == skillCO)
			else
				break
			end
		end
	end
end

function RougeRoleSkillTipsComp:onDestroy()
	self._click:RemoveClickListener()
end

return RougeRoleSkillTipsComp
