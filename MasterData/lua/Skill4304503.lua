-- 利兹
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4304503 = oo.class(SkillBase)
function Skill4304503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4304503:OnRoundBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8751
	local count751 = SkillApi:BuffCount(self, caster, target,1,4,304500301)
	-- 4304506
	if SkillJudger:Greater(self, caster, target, true,count751,0) then
	else
		return
	end
	-- 4304503
	self:AddBuffCount(SkillEffect[4304503], caster, caster, data, 304500303,1,20)
end
-- 攻击结束
function Skill4304503:OnAttackOver(caster, target, data)
	-- 4304511
	self:tFunc_4304511_4304516(caster, target, data)
	self:tFunc_4304511_4304521(caster, target, data)
end
-- 治疗时
function Skill4304503:OnCure(caster, target, data)
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 9752
	if SkillJudger:IsTargetMech(self, caster, target, true,3) then
	else
		return
	end
	-- 8754
	local count754 = SkillApi:BuffCount(self, caster, target,2,4,304500201)
	-- 4304530
	if SkillJudger:Greater(self, caster, target, true,count754,0) then
	else
		return
	end
	-- 4304533
	self:AddBuffCount(SkillEffect[4304533], caster, target, data, 4304504,1,999)
end
function Skill4304503:tFunc_4304511_4304521(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8752
	local count752 = SkillApi:BuffCount(self, caster, target,2,4,304500301)
	-- 4304507
	if SkillJudger:Greater(self, caster, target, true,count752,0) then
	else
		return
	end
	-- 8753
	local count753 = SkillApi:BuffCount(self, caster, target,1,4,304500201)
	-- 4304508
	if SkillJudger:Greater(self, caster, target, true,count753,0) then
	else
		return
	end
	-- 4304521
	if self:Rand(5000) then
		self:AddBuffCount(SkillEffect[4304521], caster, target, data, 304500303,1,20)
	end
end
function Skill4304503:tFunc_4304511_4304516(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8752
	local count752 = SkillApi:BuffCount(self, caster, target,2,4,304500301)
	-- 4304507
	if SkillJudger:Greater(self, caster, target, true,count752,0) then
	else
		return
	end
	-- 8233
	if SkillJudger:IsCasterMech(self, caster, self.card, true,3) then
	else
		return
	end
	-- 4304516
	if self:Rand(5000) then
		self:AddBuffCount(SkillEffect[4304516], caster, target, data, 304500303,1,20)
	end
end
