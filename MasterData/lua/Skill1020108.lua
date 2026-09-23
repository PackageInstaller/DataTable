-- 复苏
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1020108 = oo.class(SkillBase)
function Skill1020108:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1020108:DoSkill(caster, target, data)
	-- 1020108
	self.order = self.order + 1
	self:Revive(SkillEffect[1020108], caster, target, data, 2,0.34,{progress=700})
end
