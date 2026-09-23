-- 哑迹怪物被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4703506 = oo.class(SkillBase)
function Skill4703506:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4703506:OnAttackOver(caster, target, data)
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
	-- 4703510
	self:OwnerHitAddBuff(SkillEffect[4703510], caster, caster, data, 8000,5304,2)
end
-- 伤害前
function Skill4703506:OnBefourHurt(caster, target, data)
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
	-- 4703511
	self:OwnerHitAddBuff(SkillEffect[4703511], caster, target, data, 10000,4803,1)
end
