-- 天赋效果301705
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301705 = oo.class(SkillBase)
function Skill301705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill301705:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 301705
	self:AddNp(SkillEffect[301705], caster, self.card, data, 15)
end
