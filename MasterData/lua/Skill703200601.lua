-- 冥渊审判
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703200601 = oo.class(SkillBase)
function Skill703200601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill703200601:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 703200601
	self:CallSkillEx(SkillEffect[703200601], caster, self.card, data, 703201001)
	-- 703200703
	self:AddBuff(SkillEffect[703200703], caster, self.card, data, 6110)
end
