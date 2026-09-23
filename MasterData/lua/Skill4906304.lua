-- 毒清算特性
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4906304 = oo.class(SkillBase)
function Skill4906304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4906304:OnAfterHurt(caster, target, data)
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
	-- 4906304
	if self:Rand(8000) then
		self:ClosingBuffByID(SkillEffect[4906304], caster, target, data, 1,1001)
	end
end
