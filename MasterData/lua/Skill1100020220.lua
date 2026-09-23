-- 每次伤害后，若敌方低于70%血量获得1个标记，标记>9个时，获得1个额外回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020220 = oo.class(SkillBase)
function Skill1100020220:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1100020220:OnAttackOver(caster, target, data)
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
	-- 8096
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.7) then
	else
		return
	end
	-- 1100020220
	self:OwnerAddBuffCount(SkillEffect[1100020220], caster, self.card, data, 1100020220,1,10)
end
-- 行动结束
function Skill1100020220:OnActionOver(caster, target, data)
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
	-- 1100020221
	local xlbbiaoji = SkillApi:GetCount(self, caster, target,1,1100020220)
	-- 1100020224
	if SkillJudger:Greater(self, caster, self.card, true,xlbbiaoji,9) then
	else
		return
	end
	-- 1100020225
	self:ExtraRound(SkillEffect[1100020225], caster, self.card, data, nil)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100020226
	self:DelBufferForce(SkillEffect[1100020226], caster, self.card, data, 1100020220,10)
end
