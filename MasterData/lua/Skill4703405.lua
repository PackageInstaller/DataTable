-- 杰德柱
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4703405 = oo.class(SkillBase)
function Skill4703405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill4703405:OnActionBegin(caster, target, data)
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
	-- 4703413
	self:HpProtect(SkillEffect[4703413], caster, self.card, data, 0.3)
end
-- 入场时
function Skill4703405:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703403
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[4703403], caster, target, data, 4703403)
	end
end
-- 死亡时
function Skill4703405:OnDeath(caster, target, data)
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
function Skill4703405:OnBornSpecial(caster, target, data)
	-- 4703443
	self:tFunc_4703443_4703423(caster, target, data)
	self:tFunc_4703443_4703433(caster, target, data)
end
function Skill4703405:tFunc_4703443_4703423(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4703423
	self:OwnerAddBuff(SkillEffect[4703423], caster, caster, data, 4703403)
end
function Skill4703405:tFunc_4703443_4703433(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703433
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[4703433], caster, target, data, 4703403)
	end
end
