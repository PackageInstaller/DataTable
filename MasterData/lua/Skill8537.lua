-- 天赋效果37
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8537 = oo.class(SkillBase)
function Skill8537:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill8537:OnDeath(caster, target, data)
	-- 8537
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 70020
		self:AddNp(SkillEffect[70020], caster, self.card, data, 12)
	end
end
