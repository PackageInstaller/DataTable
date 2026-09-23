-- 岚天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331003 = oo.class(SkillBase)
function Skill331003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill331003:OnActionOver(caster, target, data)
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
	-- 331003
	if self:Rand(2000) then
		self:BeatAgain(SkillEffect[331003], caster, target, data, 400600200+count664)
	end
end
