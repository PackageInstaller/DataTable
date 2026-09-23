-- 电荷屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill801400201 = oo.class(SkillBase)
function Skill801400201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill801400201:DoSkill(caster, target, data)
	-- 801400201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[801400201], caster, target, data, 801400201)
end
