-- 提泽纳4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill337001 = oo.class(SkillBase)
function Skill337001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill337001:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337001
	self:AddSp(SkillEffect[337001], caster, self.card, data, 10)
end
-- 特殊入场时(复活，召唤，合体)
function Skill337001:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 337011
	self:AddSp(SkillEffect[337011], caster, caster, data, 10)
	-- 337021
	self:AddBuff(SkillEffect[337021], caster, self.card, data, 337001)
end
-- 死亡时
function Skill337001:OnDeath(caster, target, data)
	-- 8074
	if SkillJudger:TargetIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 337026
	self:DelBufferTypeForce(SkillEffect[337026], caster, self.card, data, 337001)
end
