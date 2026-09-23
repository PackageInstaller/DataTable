-- 力场装置
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill910600803 = oo.class(SkillBase)
function Skill910600803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill910600803:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 910600804
	self:tFunc_910600804_910600803(caster, self.card, data)
	self:tFunc_910600804_910600802(caster, self.card, data)
end
function Skill910600803:tFunc_910600804_910600803(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 910600803
	self:AddBuff(SkillEffect[910600803], caster, self.card, data, 910600805)
end
function Skill910600803:tFunc_910600804_910600802(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 910600802
	self:AddBuff(SkillEffect[910600802], caster, self.card, data, 910600803)
end
