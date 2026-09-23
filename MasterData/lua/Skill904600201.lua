-- 牵引力场
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill904600201 = oo.class(SkillBase)
function Skill904600201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill904600201:DoSkill(caster, target, data)
	-- 904600201
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[904600201], caster, target, data, 10000,3007)
end
