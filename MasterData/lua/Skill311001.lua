-- 天赋效果311001
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill311001 = oo.class(SkillBase)
function Skill311001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill311001:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 311001
	self:AddSkillAttr(SkillEffect[311001], caster, self.card, data, "percent",0.16)
end
