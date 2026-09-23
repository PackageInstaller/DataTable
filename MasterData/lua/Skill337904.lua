-- SP伊根2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill337904 = oo.class(SkillBase)
function Skill337904:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill337904:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337904
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[337904], caster, target, data, 337904)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill337904:OnBornSpecial(caster, target, data)
	-- 337944
	self:tFunc_337944_337914(caster, target, data)
	self:tFunc_337944_337934(caster, target, data)
end
-- 死亡时
function Skill337904:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337921
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(SkillEffect[337921], caster, target, data, 337901)
	end
end
function Skill337904:tFunc_337944_337914(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 337914
	self:AddBuff(SkillEffect[337914], caster, caster, data, 337904)
end
function Skill337904:tFunc_337944_337934(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337934
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[337934], caster, target, data, 337904)
	end
end
