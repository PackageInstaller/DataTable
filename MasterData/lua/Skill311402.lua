-- 天赋效果311402
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill311402 = oo.class(SkillBase)
function Skill311402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill311402:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 311402
	self:AddBuff(SkillEffect[311402], caster, self.card, data, 2512)
end
