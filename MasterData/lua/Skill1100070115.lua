-- 能量屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070115 = oo.class(SkillBase)
function Skill1100070115:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1100070115:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 93002
	if SkillJudger:CheckCD(self, caster, target, false) then
	else
		return
	end
	-- 8146
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.6) then
	else
		return
	end
	-- 1100070115
	self:AddLightShieldCount(SkillEffect[1100070115], caster, self.card, data, 2309,3,3)
	-- 1100070114
	self:ResetCD(SkillEffect[1100070114], caster, target, data, 2)
end
