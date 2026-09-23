-- 幽兰
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4503102 = oo.class(SkillBase)
function Skill4503102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4503102:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4503102
	self:AddBuff(SkillEffect[4503102], caster, self.card, data, 4503112)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4503106
	self:AddBuff(SkillEffect[4503106], caster, self.card, data, 6210,1)
end
-- 伤害前
function Skill4503102:OnBefourHurt(caster, target, data)
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
	-- 4503112
	self:HitAddBuff(SkillEffect[4503112], caster, target, data, 1500,4503101)
end
