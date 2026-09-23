-- 钓鱼佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill912100831 = oo.class(SkillBase)
function Skill912100831:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill912100831:CanSummon()
	return self.card:CanSummon(50601417,3,{3,1},{progress=500},nil,nil)
end
-- 执行技能
function Skill912100831:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 912100802
	if SkillJudger:Equal(self, caster, target, true,count76,1) then
	else
		return
	end
	-- 912102411
	if SkillJudger:HasBuff(self, caster, target, true,3,912102410) then
	else
		return
	end
	-- 912104001
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[912104001], caster, target, data, 50601417,3,{3,1},{progress=500},nil,nil)
end
