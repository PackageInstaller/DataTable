-- 天赋效果301702
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301702 = oo.class(SkillBase)
function Skill301702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill301702:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 301702
	self:AddNp(SkillEffect[301702], caster, self.card, data, 7)
end
