-- 阵地构造
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102400303 = oo.class(SkillBase)
function Skill102400303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102400303:DoSkill(caster, target, data)
	-- 102400303
	self.order = self.order + 1
	self:AddBuff(SkillEffect[102400303], caster, target, data, 2163,3)
end
