-- 天丛云SP2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill340904 = oo.class(SkillBase)
function Skill340904:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill340904:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 340904
	self:AddSp(SkillEffect[340904], caster, self.card, data, 20)
end
