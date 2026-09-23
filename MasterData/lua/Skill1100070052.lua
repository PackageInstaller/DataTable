-- 怪物攻击结束后，使友方行动提前20%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070052 = oo.class(SkillBase)
function Skill1100070052:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1100070052:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100070052
	local targets = SkillFilter:Teammate(self, caster, target, nil)
	for i,target in ipairs(targets) do
		self:AddProgress(SkillEffect[1100070052], caster, target, data, 200)
	end
end
