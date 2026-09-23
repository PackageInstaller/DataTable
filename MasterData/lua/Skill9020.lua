-- 命中强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9020 = oo.class(SkillBase)
function Skill9020:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9020:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9020
	self:AddBuff(SkillEffect[9020], caster, self.card, data, 9020)
end
