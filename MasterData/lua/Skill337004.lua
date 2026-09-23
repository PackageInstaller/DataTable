-- 提泽纳4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill337004 = oo.class(SkillBase)
function Skill337004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill337004:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337004
	self:AddSp(SkillEffect[337004], caster, self.card, data, 25)
end
-- 特殊入场时(复活，召唤，合体)
function Skill337004:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 337014
	self:AddSp(SkillEffect[337014], caster, caster, data, 25)
	-- 337024
	self:AddBuff(SkillEffect[337024], caster, self.card, data, 337004)
end
-- 死亡时
function Skill337004:OnDeath(caster, target, data)
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
