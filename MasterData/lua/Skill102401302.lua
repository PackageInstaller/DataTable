-- 阵地构造（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102401302 = oo.class(SkillBase)
function Skill102401302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102401302:DoSkill(caster, target, data)
	-- 102400302
	self.order = self.order + 1
	self:AddBuff(SkillEffect[102400302], caster, target, data, 2162,3)
end
