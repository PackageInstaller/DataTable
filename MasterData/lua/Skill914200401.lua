-- 召喚
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914200401 = oo.class(SkillBase)
function Skill914200401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill914200401:CanSummon()
	return self.card:CanSummon(10000305,3,{1,3},{progress=25},nil,nil)
end
function Skill914200401:CanSummon()
	return self.card:CanSummon(10000304,3,{1,1},{progress=20},nil,nil)
end
-- 执行技能
function Skill914200401:DoSkill(caster, target, data)
	-- 914200401
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[914200401], caster, self.card, data, 10000304,3,{1,1},{progress=20},nil,nil)
	-- 914200402
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[914200402], caster, self.card, data, 10000305,3,{1,3},{progress=25},nil,nil)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 914200502
	local count914200501 = SkillApi:GetCount(self, caster, target,3,914200501)
	-- 914200504
	if SkillJudger:Equal(self, caster, target, true,count914200501%2,0) then
	else
		return
	end
	-- 914200506
	self.order = self.order + 1
	self:AddBuff(SkillEffect[914200506], caster, self.card, data, 914200506)
end
