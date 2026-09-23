-- 天赋效果35
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8535 = oo.class(SkillBase)
function Skill8535:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill8535:OnAttackOver(caster, target, data)
	-- 8535
	if SkillJudger:CasterIsEnemy(self, caster, target, true) and SkillJudger:TargetIsSelf(self, caster, target, true) then
		-- 70018
		if self:Rand(5000) then
			self:AddNp(SkillEffect[70018], caster, self.card, data, 5)
		end
	end
end
