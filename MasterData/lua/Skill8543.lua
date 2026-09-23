-- 天赋效果43
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8543 = oo.class(SkillBase)
function Skill8543:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill8543:OnAttackOver(caster, target, data)
	-- 8543
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 81009
		if self:Rand(4000) then
			self:AddSp(SkillEffect[81009], caster, self.card, data, 20)
		end
	end
end
