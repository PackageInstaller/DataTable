-- 追猎
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4301802 = oo.class(SkillBase)
function Skill4301802:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4301802:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4301802
	self:AddBuff(SkillEffect[4301802], caster, self.card, data, 4301802)
end
-- 伤害前
function Skill4301802:OnBefourHurt(caster, target, data)
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
	-- 4301812
	self:AddTempAttr(SkillEffect[4301812], caster, self.card, data, "damage",0.15)
	-- 4301816
	self:ShowTips(SkillEffect[4301816], caster, self.card, data, 2,"追猎",true,4301816)
end
