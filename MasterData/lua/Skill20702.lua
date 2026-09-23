-- 维修II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill20702 = oo.class(SkillBase)
function Skill20702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill20702:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 20702
	self:AddBuff(SkillEffect[20702], caster, self.card, data, 20702)
end
