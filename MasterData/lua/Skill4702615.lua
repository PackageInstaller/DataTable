-- 永恒之枪
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4702615 = oo.class(SkillBase)
function Skill4702615:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4702615:OnAfterHurt(caster, target, data)
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
	-- 4702603
	self:HitAddBuff(SkillEffect[4702603], caster, target, data, 3000,5206,2)
end
-- 攻击结束
function Skill4702615:OnAttackOver(caster, target, data)
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
	-- 4702605
	self:OwnerAddBuffCount(SkillEffect[4702605], caster, self.card, data, 702600204,1,10)
end
