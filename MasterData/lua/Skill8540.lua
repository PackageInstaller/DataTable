-- 天赋效果40
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8540 = oo.class(SkillBase)
function Skill8540:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill8540:OnBorn(caster, target, data)
	-- 8540
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 81006
		self:AddSp(SkillEffect[81006], caster, self.card, data, 20)
	end
end
