-- 机神守护
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9707 = oo.class(SkillBase)
function Skill9707:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9707:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 6207
	self:AddBuff(SkillEffect[6207], caster, self.card, data, 6207)
end
