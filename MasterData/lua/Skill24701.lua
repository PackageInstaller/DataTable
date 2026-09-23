-- 抗压I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24701 = oo.class(SkillBase)
function Skill24701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill24701:OnAttackOver(caster, target, data)
	-- 24725
	self:tFunc_24725_24704(caster, target, data)
	self:tFunc_24725_24707(caster, target, data)
end
-- 伤害前
function Skill24701:OnBefourHurt(caster, target, data)
	-- 24710
	self:tFunc_24710_24713(caster, target, data)
	self:tFunc_24710_24716(caster, target, data)
end
-- 回合开始处理完成后
function Skill24701:OnAfterRoundBegin(caster, target, data)
	-- 24719
	self:AddBuff(SkillEffect[24719], caster, self.card, data, 24704)
	-- 8257
	if SkillJudger:HasSummoner(self, caster, self.card, true) then
	else
		return
	end
	-- 24722
	self:AddBuff(SkillEffect[24722], caster, self.card.oSummoner, data, 24704)
end
function Skill24701:tFunc_24725_24707(caster, target, data)
	-- 8074
	if SkillJudger:TargetIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8257
	if SkillJudger:HasSummoner(self, caster, self.card, true) then
	else
		return
	end
	-- 24707
	self:AddBuff(SkillEffect[24707], caster, self.card.oSummoner, data, 24704)
end
function Skill24701:tFunc_24710_24716(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 24716
	self:AddBuff(SkillEffect[24716], caster, caster, data, 24704)
end
function Skill24701:tFunc_24725_24704(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 24704
	self:AddBuff(SkillEffect[24704], caster, self.card, data, 24704)
end
function Skill24701:tFunc_24710_24713(caster, target, data)
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
	-- 24713
	self:AddBuff(SkillEffect[24713], caster, caster, data, 24704)
end
