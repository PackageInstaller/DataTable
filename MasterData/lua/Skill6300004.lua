-- 虚数天灾简单模式buff4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6300004 = oo.class(SkillBase)
function Skill6300004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill6300004:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 6300004
	self:AddBuff(SkillEffect[6300004], caster, self.card, data, 6300004)
end
