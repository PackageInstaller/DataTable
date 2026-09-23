-- 坚不可摧
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill101100304 = oo.class(SkillBase)
function Skill101100304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill101100304:DoSkill(caster, target, data)
	-- 101100304
	self.order = self.order + 1
	self:AddBuff(SkillEffect[101100304], caster, target, data, 101100304)
end
