-- 全体戒备
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102400204 = oo.class(SkillBase)
function Skill102400204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102400204:DoSkill(caster, target, data)
	-- 4103
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4103], caster, target, data, 4103)
	-- 4203
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4203], caster, target, data, 4203)
end
