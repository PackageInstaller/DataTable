-- 天赋效果33
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8533 = oo.class(SkillBase)
function Skill8533:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill8533:OnAttackOver(caster, target, data)
	-- 8533
	if SkillJudger:CasterIsEnemy(self, caster, target, true) and SkillJudger:TargetIsSelf(self, caster, target, true) then
		-- 70016
		if self:Rand(3500) then
			self:AddNp(SkillEffect[70016], caster, self.card, data, 5)
		end
	end
end
