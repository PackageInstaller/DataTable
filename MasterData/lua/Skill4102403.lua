-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4102403 = oo.class(SkillBase)
function Skill4102403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4102403:OnAfterHurt(caster, target, data)
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	local count23 = SkillApi:GetAttr(self, caster, target,3,"defense")
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsShieldDestroy(self, caster, target, true) then
	else
		return
	end
	self:AddHp(SkillEffect[4102403], caster, caster, data, count23*4)
end
