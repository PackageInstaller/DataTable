-- 后备能源
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill910600901 = oo.class(SkillBase)
function Skill910600901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill910600901:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 910600901
	self:AddBuff(SkillEffect[910600901], caster, self.card, data, 910600901)
end
