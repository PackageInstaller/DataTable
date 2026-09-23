-- 芭贝拉·红2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill336705 = oo.class(SkillBase)
function Skill336705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill336705:OnActionOver(caster, target, data)
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
	-- 336705
	if self:Rand(3000) then
		self:BeatAgain(SkillEffect[336705], caster, target, data, nil)
	end
end
-- 行动结束2
function Skill336705:OnActionOver2(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 336715
	if self:Rand(3000) then
		self:BeatAgain(SkillEffect[336715], caster, target, data, nil)
	end
end
