-- 天赋效果310904
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310904 = oo.class(SkillBase)
function Skill310904:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill310904:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 310904
	self:AddSkillAttr(SkillEffect[310904], caster, self.card, data, "np",-4)
end
