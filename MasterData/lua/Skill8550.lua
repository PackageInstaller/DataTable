-- 天赋效果50
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8550 = oo.class(SkillBase)
function Skill8550:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill8550:OnDeath(caster, target, data)
	-- 8550
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 81016
		self:AddSp(SkillEffect[81016], caster, self.card, data, 25)
	end
end
