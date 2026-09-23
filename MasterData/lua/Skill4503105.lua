-- 幽兰
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4503105 = oo.class(SkillBase)
function Skill4503105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4503105:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4503105
	self:AddBuff(SkillEffect[4503105], caster, self.card, data, 4503115)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4503107
	self:AddBuff(SkillEffect[4503107], caster, self.card, data, 6210,2)
end
-- 伤害前
function Skill4503105:OnBefourHurt(caster, target, data)
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
	-- 4503115
	self:HitAddBuff(SkillEffect[4503115], caster, target, data, 3000,4503101)
end
