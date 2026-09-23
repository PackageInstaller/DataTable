-- 天赋效果45
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8545 = oo.class(SkillBase)
function Skill8545:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill8545:OnAfterHurt(caster, target, data)
	-- 8545
	if SkillJudger:CasterIsEnemy(self, caster, target, true) and SkillJudger:TargetIsSelf(self, caster, target, true) then
		-- 81011
		self:AddSp(SkillEffect[81011], caster, self.card, data, 3)
	end
end
