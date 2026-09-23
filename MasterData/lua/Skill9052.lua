-- 冥河助战
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9052 = oo.class(SkillBase)
function Skill9052:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill9052:CanSummon()
	return self.card:CanSummon(98001001,2,{1,1},{progress=10},nil,nil)
end
-- 入场时
function Skill9052:OnBorn(caster, target, data)
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8803
	if SkillJudger:Equal(self, caster, target, true,count76,2) then
	else
		return
	end
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 9052
	self:SummonTeammate(SkillEffect[9052], caster, self.card, data, 98001001,2,{1,1},{progress=10},nil,nil)
end
