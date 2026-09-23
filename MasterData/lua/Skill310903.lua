-- 天赋效果310903
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310903 = oo.class(SkillBase)
function Skill310903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill310903:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 310903
	self:AddSkillAttr(SkillEffect[310903], caster, self.card, data, "np",-3)
end
