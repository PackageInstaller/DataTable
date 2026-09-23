-- 复苏
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1020107 = oo.class(SkillBase)
function Skill1020107:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1020107:DoSkill(caster, target, data)
	-- 1020107
	self.order = self.order + 1
	self:Revive(SkillEffect[1020107], caster, target, data, 2,0.32,{progress=700})
end
