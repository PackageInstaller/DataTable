-- 吞噬者
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4802201 = oo.class(SkillBase)
function Skill4802201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4802201:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4802203
	self:CallOwnerSkill(SkillEffect[4802203], caster, self.card.oSummonOwner, data, 802200401)
end
-- 攻击结束
function Skill4802201:OnAttackOver(caster, target, data)
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
	-- 4802202
	self:DelBufferGroup(SkillEffect[4802202], caster, target, data, 2,2)
end
-- 伤害前
function Skill4802201:OnBefourHurt(caster, target, data)
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
	-- 4802305
	self:AddTempAttr(SkillEffect[4802305], caster, self.card, data, "damage",0.4)
end
