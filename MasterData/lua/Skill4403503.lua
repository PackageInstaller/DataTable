-- 圣餐
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4403503 = oo.class(SkillBase)
function Skill4403503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4403503:OnAfterHurt(caster, target, data)
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
	-- 4403503
	if self:Rand(3000) then
		self:OwnerAddBuffCount(SkillEffect[4403503], caster, target, data, 4403501,1,5)
	end
end
-- 攻击结束
function Skill4403503:OnAttackOver(caster, target, data)
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
	-- 4403513
	if self:Rand(6000) then
		self:AddBuff(SkillEffect[4403513], caster, self.card, data, 4403503)
	end
end
