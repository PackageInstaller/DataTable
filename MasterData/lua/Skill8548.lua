-- 天赋效果48
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8548 = oo.class(SkillBase)
function Skill8548:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill8548:OnDeath(caster, target, data)
	-- 8548
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 81014
		self:AddSp(SkillEffect[81014], caster, self.card, data, 18)
	end
end
