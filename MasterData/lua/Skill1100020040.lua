-- 使用回复技能时，全队提高30%攻击力，持续2回合，最多叠加2层，之后消耗30np
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020040 = oo.class(SkillBase)
function Skill1100020040:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100020040:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8225
	if SkillJudger:IsCtrlType(self, caster, target, true,11) then
	else
		return
	end
	-- 1100020040
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuffCount(SkillEffect[1100020040], caster, target, data, 1100020040,1,2)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8225
	if SkillJudger:IsCtrlType(self, caster, target, true,11) then
	else
		return
	end
	-- 1100020043
	self:AddNp(SkillEffect[1100020043], caster, self.card, data, -30)
end
