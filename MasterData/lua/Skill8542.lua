-- 天赋效果42
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8542 = oo.class(SkillBase)
function Skill8542:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill8542:OnAttackOver(caster, target, data)
	-- 8542
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 81008
		if self:Rand(3500) then
			self:AddSp(SkillEffect[81008], caster, self.card, data, 20)
		end
	end
end
