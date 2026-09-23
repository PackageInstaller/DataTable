-- 追猎
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4301804 = oo.class(SkillBase)
function Skill4301804:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4301804:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4301804
	self:AddBuff(SkillEffect[4301804], caster, self.card, data, 4301804)
end
-- 伤害前
function Skill4301804:OnBefourHurt(caster, target, data)
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
	-- 8095
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.6) then
	else
		return
	end
	-- 4301814
	self:AddTempAttr(SkillEffect[4301814], caster, self.card, data, "damage",0.25)
	-- 4301816
	self:ShowTips(SkillEffect[4301816], caster, self.card, data, 2,"追猎",true,4301816)
end
