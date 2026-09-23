-- 天赋效果311403
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill311403 = oo.class(SkillBase)
function Skill311403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill311403:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 311403
	self:AddBuff(SkillEffect[311403], caster, self.card, data, 2513)
end
