-- 牢笼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill902400301 = oo.class(SkillBase)
function Skill902400301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill902400301:DoSkill(caster, target, data)
	-- 902400101
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[902400101], caster, target, data, 10000,3008)
end
