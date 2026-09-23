-- 抗压III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24703 = oo.class(SkillBase)
function Skill24703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill24703:OnAttackOver(caster, target, data)
	-- 24727
	self:tFunc_24727_24706(caster, target, data)
	self:tFunc_24727_24709(caster, target, data)
end
-- 伤害前
function Skill24703:OnBefourHurt(caster, target, data)
	-- 24712
	self:tFunc_24712_24715(caster, target, data)
	self:tFunc_24712_24718(caster, target, data)
end
-- 回合开始处理完成后
function Skill24703:OnAfterRoundBegin(caster, target, data)
	-- 24721
	self:AddBuff(SkillEffect[24721], caster, self.card, data, 24706)
	-- 8257
	if SkillJudger:HasSummoner(self, caster, self.card, true) then
	else
		return
	end
	-- 24724
	self:AddBuff(SkillEffect[24724], caster, self.card.oSummoner, data, 24706)
end
function Skill24703:tFunc_24712_24718(caster, target, data)
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
	-- 24718
	self:AddBuff(SkillEffect[24718], caster, caster, data, 24706)
end
function Skill24703:tFunc_24727_24709(caster, target, data)
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
	-- 24709
	self:AddBuff(SkillEffect[24709], caster, self.card.oSummoner, data, 24706)
end
function Skill24703:tFunc_24712_24715(caster, target, data)
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
	-- 24715
	self:AddBuff(SkillEffect[24715], caster, caster, data, 24706)
end
function Skill24703:tFunc_24727_24706(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 24706
	self:AddBuff(SkillEffect[24706], caster, self.card, data, 24706)
end
