-- 血量低于25%时，回复10%血量（蓝色）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020151 = oo.class(SkillBase)
function Skill1100020151:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1100020151:OnAttackOver(caster, target, data)
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
	-- 1100020153
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.25) then
	else
		return
	end
	-- 1100020151
	self:Cure(SkillEffect[1100020151], caster, self.card, data, 1,0.1)
end
