-- 天赋效果49
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8549 = oo.class(SkillBase)
function Skill8549:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill8549:OnDeath(caster, target, data)
	-- 8549
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 81015
		self:AddSp(SkillEffect[81015], caster, self.card, data, 20)
	end
end
