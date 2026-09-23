-- 天赋效果25
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8525 = oo.class(SkillBase)
function Skill8525:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill8525:OnAttackOver(caster, target, data)
	-- 8525
	if SkillJudger:CasterIsSelf(self, caster, target, true) and SkillJudger:TargetIsEnemy(self, caster, target, true) then
		-- 31005
		self:Cure(SkillEffect[31005], caster, self.card, data, 5,0.8)
	end
end
