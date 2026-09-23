-- 同步II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill21002 = oo.class(SkillBase)
function Skill21002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill21002:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 21002
	self:AddSp(SkillEffect[21002], caster, self.card, data, 20)
end
