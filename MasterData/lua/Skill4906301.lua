-- 毒清算特性
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4906301 = oo.class(SkillBase)
function Skill4906301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4906301:OnAfterHurt(caster, target, data)
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
	-- 4906301
	if self:Rand(2000) then
		self:ClosingBuffByID(SkillEffect[4906301], caster, target, data, 1,1001)
	end
end
