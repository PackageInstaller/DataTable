-- 幽兰
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4503101 = oo.class(SkillBase)
function Skill4503101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4503101:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4503101
	self:AddBuff(SkillEffect[4503101], caster, self.card, data, 4503111)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4503106
	self:AddBuff(SkillEffect[4503106], caster, self.card, data, 6210,1)
end
-- 伤害前
function Skill4503101:OnBefourHurt(caster, target, data)
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
	-- 4503111
	self:HitAddBuff(SkillEffect[4503111], caster, target, data, 1000,4503101)
end
