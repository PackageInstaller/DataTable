-- 维修III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill20703 = oo.class(SkillBase)
function Skill20703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill20703:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 20703
	self:AddBuff(SkillEffect[20703], caster, self.card, data, 20703)
end
