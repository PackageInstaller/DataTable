-- 天赋效果46
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8546 = oo.class(SkillBase)
function Skill8546:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill8546:OnAfterHurt(caster, target, data)
	-- 8546
	if SkillJudger:CasterIsEnemy(self, caster, target, true) and SkillJudger:TargetIsSelf(self, caster, target, true) then
		-- 81012
		self:AddSp(SkillEffect[81012], caster, self.card, data, 4)
	end
end
