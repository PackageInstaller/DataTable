-- 非常规拟态海生物·Ⅲ型_Mimic sea creature type Ⅲ
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913000401 = oo.class(SkillBase)
function Skill913000401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill913000401:OnAttackOver(caster, target, data)
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
	-- 913000401
	self:CallSkill(SkillEffect[913000401], caster, target, data, 913000201)
end
