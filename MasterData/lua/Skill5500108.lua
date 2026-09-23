-- 溯源探查第三期ex修改技能8
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5500108 = oo.class(SkillBase)
function Skill5500108:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill5500108:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5500109
	self:AddBuff(SkillEffect[5500109], caster, self.card, data, 5500109)
end
