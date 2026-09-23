-- 天赋效果47
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8547 = oo.class(SkillBase)
function Skill8547:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill8547:OnAfterHurt(caster, target, data)
	-- 8547
	if SkillJudger:CasterIsEnemy(self, caster, target, true) and SkillJudger:TargetIsSelf(self, caster, target, true) then
		-- 81013
		self:AddSp(SkillEffect[81013], caster, self.card, data, 5)
	end
end
