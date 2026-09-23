-- 天赋效果39
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8539 = oo.class(SkillBase)
function Skill8539:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill8539:OnBorn(caster, target, data)
	-- 8539
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 81005
		self:AddSp(SkillEffect[81005], caster, self.card, data, 18)
	end
end
