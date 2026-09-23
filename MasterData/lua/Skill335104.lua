-- 赤夕2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill335104 = oo.class(SkillBase)
function Skill335104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill335104:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 335104
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[335104], caster, target, data, 335104)
	end
end
-- 死亡时
function Skill335104:OnDeath(caster, target, data)
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
function Skill335104:OnBornSpecial(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 335114
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[335114], caster, target, data, 335104)
	end
end
