-- 赤夕2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill335103 = oo.class(SkillBase)
function Skill335103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill335103:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 335103
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[335103], caster, target, data, 335103)
	end
end
-- 死亡时
function Skill335103:OnDeath(caster, target, data)
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
function Skill335103:OnBornSpecial(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 335113
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[335113], caster, target, data, 335103)
	end
end
