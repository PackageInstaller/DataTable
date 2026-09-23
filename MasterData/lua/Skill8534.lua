-- 天赋效果34
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8534 = oo.class(SkillBase)
function Skill8534:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill8534:OnAttackOver(caster, target, data)
	-- 8534
	if SkillJudger:CasterIsEnemy(self, caster, target, true) and SkillJudger:TargetIsSelf(self, caster, target, true) then
		-- 70017
		if self:Rand(4000) then
			self:AddNp(SkillEffect[70017], caster, self.card, data, 5)
		end
	end
end
