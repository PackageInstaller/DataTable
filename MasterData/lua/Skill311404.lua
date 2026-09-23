-- 天赋效果311404
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill311404 = oo.class(SkillBase)
function Skill311404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill311404:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 311404
	self:AddBuff(SkillEffect[311404], caster, self.card, data, 2514)
end
