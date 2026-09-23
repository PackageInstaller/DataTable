-- 突袭形态
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4922912 = oo.class(SkillBase)
function Skill4922912:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4922912:OnBornSpecial(caster, target, data)
	-- 4922911
	self:AddBuff(SkillEffect[4922911], caster, self.card, data, 4922911)
end
-- 伤害前
function Skill4922912:OnBefourHurt(caster, target, data)
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
	-- 8458
	local count58 = SkillApi:GetAttr(self, caster, target,2,"attack")
	-- 8317
	self:AddValue(SkillEffect[8317], caster, self.card, data, "gj1",count58)
	-- 4922902
	self:AddTempAttr(SkillEffect[4922902], caster, self.card, data, "damage",math.max(-count58/50000,-0.4))
end
