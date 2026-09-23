-- 天赋效果28
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8528 = oo.class(SkillBase)
function Skill8528:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill8528:OnBorn(caster, target, data)
	-- 8528
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 70011
		self:AddNp(SkillEffect[70011], caster, self.card, data, 12)
	end
end
