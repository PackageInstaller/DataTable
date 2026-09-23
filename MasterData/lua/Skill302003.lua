-- 天赋效果302003
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302003 = oo.class(SkillBase)
function Skill302003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill302003:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 302003
	self:AddSp(SkillEffect[302003], caster, self.card, data, 20)
end
