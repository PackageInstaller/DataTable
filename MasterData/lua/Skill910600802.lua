-- 力场装置
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill910600802 = oo.class(SkillBase)
function Skill910600802:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill910600802:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 910600802
	self:AddBuff(SkillEffect[910600802], caster, self.card, data, 910600803)
end
