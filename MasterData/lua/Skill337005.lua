-- 提泽纳4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill337005 = oo.class(SkillBase)
function Skill337005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill337005:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337005
	self:AddSp(SkillEffect[337005], caster, self.card, data, 30)
end
-- 特殊入场时(复活，召唤，合体)
function Skill337005:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 337015
	self:AddSp(SkillEffect[337015], caster, caster, data, 30)
	-- 337025
	self:AddBuff(SkillEffect[337025], caster, self.card, data, 337005)
end
-- 死亡时
function Skill337005:OnDeath(caster, target, data)
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
