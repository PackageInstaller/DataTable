-- 纳格陵天赋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill328604 = oo.class(SkillBase)
function Skill328604:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 切换周目
function Skill328604:OnChangeStage(caster, target, data)
	-- 328604
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[328604], caster, target, data, 328604)
	end
end
-- 死亡时
function Skill328604:OnDeath(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 328606
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(SkillEffect[328606], caster, target, data, 328601)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill328604:OnBornSpecial(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 328614
	self:OwnerAddBuff(SkillEffect[328614], caster, caster, data, 328604)
end
