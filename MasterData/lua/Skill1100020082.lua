-- 开局时，行动提前60%（蓝色）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020082 = oo.class(SkillBase)
function Skill1100020082:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100020082:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100020082
	self:AddProgress(SkillEffect[1100020082], caster, self.card, data, 600)
end
