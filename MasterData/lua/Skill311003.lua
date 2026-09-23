-- 天赋效果311003
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill311003 = oo.class(SkillBase)
function Skill311003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill311003:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 311003
	self:AddSkillAttr(SkillEffect[311003], caster, self.card, data, "percent",0.32)
end
