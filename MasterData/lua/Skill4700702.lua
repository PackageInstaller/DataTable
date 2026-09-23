-- 漫游
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4700702 = oo.class(SkillBase)
function Skill4700702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill4700702:OnDeath(caster, target, data)
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
	-- 4700702
	if self:Rand(7000) then
		self:ExtraRound(SkillEffect[4700702], caster, self.card, data, nil)
	end
end
