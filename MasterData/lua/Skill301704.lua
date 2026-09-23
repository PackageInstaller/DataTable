-- 天赋效果301704
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301704 = oo.class(SkillBase)
function Skill301704:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill301704:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 301704
	self:AddNp(SkillEffect[301704], caster, self.card, data, 12)
end
