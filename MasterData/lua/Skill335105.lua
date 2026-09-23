-- 赤夕2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill335105 = oo.class(SkillBase)
function Skill335105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill335105:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 335105
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[335105], caster, target, data, 335105)
	end
end
-- 死亡时
function Skill335105:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 335106
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(SkillEffect[335106], caster, target, data, 335101)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill335105:OnBornSpecial(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 335115
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[335115], caster, target, data, 335105)
	end
end
