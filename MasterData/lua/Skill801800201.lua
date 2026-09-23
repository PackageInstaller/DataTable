-- 纯白2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill801800201 = oo.class(SkillBase)
function Skill801800201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill801800201:DoSkill(caster, target, data)
	-- 801800201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[801800201], caster, target, data, 801800201)
end
