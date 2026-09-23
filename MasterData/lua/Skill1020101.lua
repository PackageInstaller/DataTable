-- 武装重塑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1020101 = oo.class(SkillBase)
function Skill1020101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1020101:DoSkill(caster, target, data)
	-- 1020101
	self.order = self.order + 1
	self:Revive(SkillEffect[1020101], caster, target, data, 2,0.20,{progress=700})
end
