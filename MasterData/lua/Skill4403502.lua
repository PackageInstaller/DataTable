-- 圣餐
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4403502 = oo.class(SkillBase)
function Skill4403502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4403502:OnAfterHurt(caster, target, data)
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
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 4403502
	if self:Rand(2500) then
		self:OwnerAddBuffCount(SkillEffect[4403502], caster, target, data, 4403501,1,5)
	end
end
-- 攻击结束
function Skill4403502:OnAttackOver(caster, target, data)
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
	-- 4403512
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[4403512], caster, self.card, data, 4403503)
	end
end
