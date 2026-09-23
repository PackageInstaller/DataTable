-- 阵地构造（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102401305 = oo.class(SkillBase)
function Skill102401305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102401305:DoSkill(caster, target, data)
	-- 102400305
	self.order = self.order + 1
	self:AddBuff(SkillEffect[102400305], caster, target, data, 2165,3)
end
