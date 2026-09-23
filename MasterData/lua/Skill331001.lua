-- 岚天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331001 = oo.class(SkillBase)
function Skill331001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill331001:OnActionOver(caster, target, data)
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
	-- 8664
	local count664 = SkillApi:SkillLevel(self, caster, target,3,4006002)
	-- 331001
	if self:Rand(1000) then
		self:BeatAgain(SkillEffect[331001], caster, target, data, 400600200+count664)
	end
end
