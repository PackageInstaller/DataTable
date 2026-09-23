-- 剧情-绮境笺宴
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9708 = oo.class(SkillBase)
function Skill9708:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9708:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 600500309
	self:Custom(SkillEffect[600500309], caster, self.card, data, "play_plot",{id=20427})
end
