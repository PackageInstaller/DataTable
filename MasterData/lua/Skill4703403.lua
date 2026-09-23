-- 杰德柱
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4703403 = oo.class(SkillBase)
function Skill4703403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill4703403:OnActionBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 4703412
	self:HpProtect(SkillEffect[4703412], caster, self.card, data, 0.4)
end
-- 入场时
function Skill4703403:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703402
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[4703402], caster, target, data, 4703402)
	end
end
-- 死亡时
function Skill4703403:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703404
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(SkillEffect[4703404], caster, target, data, 4703401)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill4703403:OnBornSpecial(caster, target, data)
	-- 4703442
	self:tFunc_4703442_4703422(caster, target, data)
	self:tFunc_4703442_4703432(caster, target, data)
end
function Skill4703403:tFunc_4703442_4703432(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703432
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[4703432], caster, target, data, 4703402)
	end
end
function Skill4703403:tFunc_4703442_4703422(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4703422
	self:OwnerAddBuff(SkillEffect[4703422], caster, caster, data, 4703402)
end
