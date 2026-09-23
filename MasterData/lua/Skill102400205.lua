-- 全体戒备
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102400205 = oo.class(SkillBase)
function Skill102400205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102400205:DoSkill(caster, target, data)
	-- 4104
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4104], caster, target, data, 4104)
	-- 4203
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4203], caster, target, data, 4203)
end
