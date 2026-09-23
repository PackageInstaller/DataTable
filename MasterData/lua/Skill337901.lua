-- SP伊根2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill337901 = oo.class(SkillBase)
function Skill337901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill337901:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337901
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[337901], caster, target, data, 337901)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill337901:OnBornSpecial(caster, target, data)
	-- 337941
	self:tFunc_337941_337911(caster, target, data)
	self:tFunc_337941_337931(caster, target, data)
end
-- 死亡时
function Skill337901:OnDeath(caster, target, data)
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
function Skill337901:tFunc_337941_337911(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 337911
	self:AddBuff(SkillEffect[337911], caster, caster, data, 337901)
end
function Skill337901:tFunc_337941_337931(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337931
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[337931], caster, target, data, 337901)
	end
end
