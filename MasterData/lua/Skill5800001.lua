-- 世界boss词条buff1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5800001 = oo.class(SkillBase)
function Skill5800001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill5800001:OnBornSpecial(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 5800017
	self:AddSkill(SkillEffect[5800017], caster, caster, data, 5800001)
end
-- 攻击结束
function Skill5800001:OnAttackOver(caster, target, data)
	-- 5800012
	self:tFunc_5800012_5800009(caster, target, data)
	self:tFunc_5800012_5800010(caster, target, data)
end
-- 入场时
function Skill5800001:OnBorn(caster, target, data)
	-- 333306
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333306], caster, target, data, "LimitDamage1003",1,0,10)
	end
	-- 333316
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333316], caster, target, data, "LimitDamage1001",1,0,10)
	end
	-- 333326
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333326], caster, target, data, "LimitDamage1002",1,0,10)
	end
	-- 333336
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333336], caster, target, data, "LimitDamage1051",1,0,10)
	end
	-- 333340
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333340], caster, target, data, "LimitDamage2",1,0,1)
	end
end
function Skill5800001:tFunc_5800012_5800010(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8112
	if SkillJudger:Greater(self, caster, self.card, true,count29,0) then
	else
		return
	end
	-- 8427
	local count27 = SkillApi:BuffCount(self, caster, target,2,3,1001)
	-- 8110
	if SkillJudger:Greater(self, caster, self.card, true,count27,0) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 5800010
	self:AlterRandBufferByID(SkillEffect[5800010], caster, target, data, 1003,1)
end
function Skill5800001:tFunc_5800012_5800009(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 5800011
	if SkillJudger:Less(self, caster, self.card, true,count29,1) then
	else
		return
	end
	-- 8427
	local count27 = SkillApi:BuffCount(self, caster, target,2,3,1001)
	-- 8110
	if SkillJudger:Greater(self, caster, self.card, true,count27,0) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 5800009
	local r = self.card:Rand(3)+1
	if 1 == r then
		-- 1001
		self:HitAddBuff(SkillEffect[1001], caster, target, data, 10000,1001)
	elseif 2 == r then
		-- 1002
		self:HitAddBuff(SkillEffect[1002], caster, target, data, 10000,1002)
	elseif 3 == r then
		-- 1003
		self:HitAddBuff(SkillEffect[1003], caster, target, data, 10000,1003)
	end
end
