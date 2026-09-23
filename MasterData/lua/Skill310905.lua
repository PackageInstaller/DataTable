-- 天赋效果310905
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310905 = oo.class(SkillBase)
function Skill310905:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill310905:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 310905
	self:AddSkillAttr(SkillEffect[310905], caster, self.card, data, "np",-5)
end
