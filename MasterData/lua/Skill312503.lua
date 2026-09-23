-- 高速移动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill312503 = oo.class(SkillBase)
function Skill312503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill312503:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 312503
	self:MissSurface(SkillEffect[312503], caster, self.card, data, 2000)
end
