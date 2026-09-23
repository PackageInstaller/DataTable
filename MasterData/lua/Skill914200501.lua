-- 蜘蛛大人被动技能1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914200501 = oo.class(SkillBase)
function Skill914200501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill914200501:OnActionOver(caster, target, data)
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
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 914200501
	self:AddBuffCount(SkillEffect[914200501], caster, self.card, data, 914200501,1,99)
end
-- 行动结束2
function Skill914200501:OnActionOver2(caster, target, data)
	-- 914200507
	self:tFunc_914200507_914200505(caster, target, data)
	self:tFunc_914200507_914200506(caster, target, data)
end
-- 入场时
function Skill914200501:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5700001
	self:OwnerAddBuff(SkillEffect[5700001], caster, self.card, data, 5700001)
end
function Skill914200501:tFunc_914200507_914200506(caster, target, data)
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
	self:AddBuff(SkillEffect[914200506], caster, self.card, data, 914200506)
end
function Skill914200501:tFunc_914200507_914200505(caster, target, data)
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
	-- 914200503
	if SkillJudger:Equal(self, caster, target, true,count914200501%2,1) then
	else
		return
	end
	-- 914200505
	self:AddBuff(SkillEffect[914200505], caster, self.card, data, 914200505)
end
