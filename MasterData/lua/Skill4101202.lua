-- 硬玉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4101202 = oo.class(SkillBase)
function Skill4101202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4101202:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4101202
	self:AddBuff(SkillEffect[4101202], caster, self.card, data, 4101202)
end
