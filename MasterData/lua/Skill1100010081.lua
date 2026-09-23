-- 耐久低于40%时，2回合内获得15%的耐久护盾和50%的攻击，每场战斗只生效一次
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010081 = oo.class(SkillBase)
function Skill1100010081:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1100010081:OnAttackOver(caster, target, data)
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
	-- 8098
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.4) then
	else
		return
	end
	-- 93002
	if SkillJudger:CheckCD(self, caster, target, false) then
	else
		return
	end
	-- 1100010081
	self:AddBuff(SkillEffect[1100010081], caster, self.card, data, 1100010081)
	-- 93005
	self:ResetCD(SkillEffect[93005], caster, target, data, 99)
end
