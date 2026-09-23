-- 龙弦4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill336402 = oo.class(SkillBase)
function Skill336402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill336402:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 336407
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(SkillEffect[336407], caster, target, data, 336401)
	end
	-- 336402
	local targets = SkillFilter:Rand(self, caster, target, 1,1)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[336402], caster, target, data, 336402)
	end
end
