-- 岁稔2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill335503 = oo.class(SkillBase)
function Skill335503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill335503:OnActionOver(caster, target, data)
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
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 335503
	local targets = SkillFilter:MinPercentHp(self, caster, target, 1,"hp",1)
	for i,target in ipairs(targets) do
		self:Cure(SkillEffect[335503], caster, target, data, 1,0.06)
	end
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
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 335508
	local targets = SkillFilter:MaxAttr(self, caster, target, 1,"attack",1)
	for i,target in ipairs(targets) do
		self:Cure(SkillEffect[335508], caster, target, data, 1,0.06)
	end
end
