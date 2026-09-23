-- 审判治愈
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703200701 = oo.class(SkillBase)
function Skill703200701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill703200701:OnBorn(caster, target, data)
	-- 703200701
	self:AddBuff(SkillEffect[703200701], caster, self.card, data, 6114)
end
-- 死亡时
function Skill703200701:OnDeath(caster, target, data)
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
	-- 703200702
	self:Cure(SkillEffect[703200702], caster, self.card, data, 2,0.1)
end
