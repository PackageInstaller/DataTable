-- 剧情
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9056 = oo.class(SkillBase)
function Skill9056:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9056:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 600500308
	self:Custom(SkillEffect[600500308], caster, self.card, data, "play_plot",{id=20031})
end
