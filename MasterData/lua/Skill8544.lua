-- 天赋效果44
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8544 = oo.class(SkillBase)
function Skill8544:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill8544:OnAttackOver(caster, target, data)
	-- 8544
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 81010
		if self:Rand(5000) then
			self:AddSp(SkillEffect[81010], caster, self.card, data, 20)
		end
	end
end
