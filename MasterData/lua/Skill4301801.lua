-- 追猎
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4301801 = oo.class(SkillBase)
function Skill4301801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4301801:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4301801
	self:AddBuff(SkillEffect[4301801], caster, self.card, data, 4301801)
end
-- 伤害前
function Skill4301801:OnBefourHurt(caster, target, data)
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
	-- 4301811
	self:AddTempAttr(SkillEffect[4301811], caster, self.card, data, "damage",0.1)
	-- 4301816
	self:ShowTips(SkillEffect[4301816], caster, self.card, data, 2,"追猎",true,4301816)
end
