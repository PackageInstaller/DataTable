-- 刃齿助战
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9051 = oo.class(SkillBase)
function Skill9051:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill9051:CanSummon()
	return self.card:CanSummon(98002002,2,{1,3},{progress=800},nil,nil)
end
-- 入场时
function Skill9051:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9051
	self:SummonTeammate(SkillEffect[9051], caster, self.card, data, 98002002,2,{1,3},{progress=800},nil,nil)
	-- 9043
	self:AddBuff(SkillEffect[9043], caster, self.card, data, 9037)
end
