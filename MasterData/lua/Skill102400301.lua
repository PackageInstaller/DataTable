-- 阵地构造
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102400301 = oo.class(SkillBase)
function Skill102400301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102400301:DoSkill(caster, target, data)
	-- 102400301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[102400301], caster, target, data, 2161,3)
end
