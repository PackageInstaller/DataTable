-- 天赋效果36
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8536 = oo.class(SkillBase)
function Skill8536:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill8536:OnDeath(caster, target, data)
	-- 8536
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 70019
		self:AddNp(SkillEffect[70019], caster, self.card, data, 10)
	end
end
