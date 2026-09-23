-- 缴获
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4801102 = oo.class(SkillBase)
function Skill4801102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill4801102:OnDeath(caster, target, data)
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
	-- 4801103
	self:AddSp(SkillEffect[4801103], caster, self.card, data, 20)
end
