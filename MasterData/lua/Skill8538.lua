-- 天赋效果38
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8538 = oo.class(SkillBase)
function Skill8538:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill8538:OnDeath(caster, target, data)
	-- 8538
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 70021
		self:AddNp(SkillEffect[70021], caster, self.card, data, 15)
	end
end
