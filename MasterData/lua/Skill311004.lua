-- 天赋效果311004
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill311004 = oo.class(SkillBase)
function Skill311004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill311004:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 311004
	self:AddSkillAttr(SkillEffect[311004], caster, self.card, data, "percent",0.40)
end
