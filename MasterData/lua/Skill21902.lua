-- 集中II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill21902 = oo.class(SkillBase)
function Skill21902:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill21902:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 21902
	self:AddBuff(SkillEffect[21902], caster, self.card, data, 21902)
	-- 219010
	self:ShowTips(SkillEffect[219010], caster, self.card, data, 2,"集中",true,219010)
end
