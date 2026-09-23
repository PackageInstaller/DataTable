-- 肾上腺素
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill910900402 = oo.class(SkillBase)
function Skill910900402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill910900402:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill910900402:OnAttackOver(caster, target, data)
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
	-- 910900402
	self:AddBuffCount(SkillEffect[910900402], caster, target, data, 910900402,1,5)
end
