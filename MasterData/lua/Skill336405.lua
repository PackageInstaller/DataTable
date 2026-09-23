-- 龙弦4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill336405 = oo.class(SkillBase)
function Skill336405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill336405:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 336410
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(SkillEffect[336410], caster, target, data, 336401)
	end
	-- 336405
	local targets = SkillFilter:Rand(self, caster, target, 1,1)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[336405], caster, target, data, 336405)
	end
end
