-- 同步III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill21003 = oo.class(SkillBase)
function Skill21003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill21003:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 21003
	self:AddSp(SkillEffect[21003], caster, self.card, data, 30)
end
