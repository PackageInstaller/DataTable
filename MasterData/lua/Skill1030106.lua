-- 紧急同步
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1030106 = oo.class(SkillBase)
function Skill1030106:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1030106:DoSkill(caster, target, data)
	-- 1030106
	self.order = self.order + 1
	self:AddSp(SkillEffect[1030106], caster, target, data, 25)
end
