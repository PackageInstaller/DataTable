-- 标记
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9035 = oo.class(SkillBase)
function Skill9035:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill9035:OnAttackOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8098
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.4) then
	else
		return
	end
	-- 8499
	local count99 = SkillApi:BuffCount(self, caster, target,3,4,9037)
	-- 8199
	if SkillJudger:Equal(self, caster, target, true,count99,1) then
	else
		return
	end
	-- 9035
	self:AddBuff(SkillEffect[9035], caster, self.card, data, 9035)
	-- 9043
	self:AddBuff(SkillEffect[9043], caster, self.card, data, 9037)
	-- 9045
	self:ExtraRound(SkillEffect[9045], caster, self.card, data, nil)
end
