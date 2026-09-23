-- 黑白帽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4500114 = oo.class(SkillBase)
function Skill4500114:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 解体时
function Skill4500114:OnResolve(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4500114
	self:CallSkill(SkillEffect[4500114], caster, self.card, data, 500110404)
end
