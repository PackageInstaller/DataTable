-- 反击III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24903 = oo.class(SkillBase)
function Skill24903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill24903:OnActionOver(caster, target, data)
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 24903
	if self:Rand(3000) then
		self:BeatBack(SkillEffect[24903], caster, self.card, data, nil,6)
	end
end
-- 行动结束2
function Skill24903:OnActionOver2(caster, target, data)
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 8203
	if SkillJudger:IsSingle(self, caster, target, false) then
	else
		return
	end
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8892
	if SkillJudger:Greater(self, caster, target, true,count76,1) then
	else
		return
	end
	-- 24913
	if self:Rand(4500) then
		self:BeatBack(SkillEffect[24913], caster, self.card, data, nil,6)
	end
end
