-- 行动提前
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9031 = oo.class(SkillBase)
function Skill9031:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill9031:OnAttackOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8094
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.5) then
	else
		return
	end
	-- 8477
	local count77 = SkillApi:LiveCount(self, caster, target,4)
	-- 8813
	if SkillJudger:Equal(self, caster, target, true,count77,1) then
	else
		return
	end
	-- 8499
	local count99 = SkillApi:BuffCount(self, caster, target,3,4,9037)
	-- 8197
	if SkillJudger:Equal(self, caster, target, true,count99,0) then
	else
		return
	end
	-- 9031
	self:ExtraRound(SkillEffect[9031], caster, self.card, data, nil)
	-- 9032
	self:AddBuff(SkillEffect[9032], caster, self.card, data, 9032)
	-- 9036
	self:AddBuff(SkillEffect[9036], caster, self.card, data, 9036)
	-- 9043
	self:AddBuff(SkillEffect[9043], caster, self.card, data, 9037)
end
