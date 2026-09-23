-- 天赋效果41
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8541 = oo.class(SkillBase)
function Skill8541:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill8541:OnBorn(caster, target, data)
	-- 8541
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 81007
		self:AddSp(SkillEffect[81007], caster, self.card, data, 25)
	end
end
