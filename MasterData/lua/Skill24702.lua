-- 抗压II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24702 = oo.class(SkillBase)
function Skill24702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill24702:OnAttackOver(caster, target, data)
	-- 24726
	self:tFunc_24726_24705(caster, target, data)
	self:tFunc_24726_24708(caster, target, data)
end
-- 伤害前
function Skill24702:OnBefourHurt(caster, target, data)
	-- 24711
	self:tFunc_24711_24714(caster, target, data)
	self:tFunc_24711_24717(caster, target, data)
end
-- 回合开始处理完成后
function Skill24702:OnAfterRoundBegin(caster, target, data)
	-- 24720
	self:AddBuff(SkillEffect[24720], caster, self.card, data, 24705)
	-- 8257
	if SkillJudger:HasSummoner(self, caster, self.card, true) then
	else
		return
	end
	-- 24723
	self:AddBuff(SkillEffect[24723], caster, self.card.oSummoner, data, 24705)
end
function Skill24702:tFunc_24726_24708(caster, target, data)
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
	-- 24708
	self:AddBuff(SkillEffect[24708], caster, self.card.oSummoner, data, 24705)
end
function Skill24702:tFunc_24711_24714(caster, target, data)
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
	-- 24714
	self:AddBuff(SkillEffect[24714], caster, caster, data, 24705)
end
function Skill24702:tFunc_24726_24705(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 24705
	self:AddBuff(SkillEffect[24705], caster, self.card, data, 24705)
end
function Skill24702:tFunc_24711_24717(caster, target, data)
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
	-- 24717
	self:AddBuff(SkillEffect[24717], caster, caster, data, 24705)
end
