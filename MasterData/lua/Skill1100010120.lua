-- 击杀目标时NP+10
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010120 = oo.class(SkillBase)
function Skill1100010120:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill1100010120:OnDeath(caster, target, data)
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
	-- 1100010120
	self:AddNp(SkillEffect[1100010120], caster, self.card, data, 10)
end
