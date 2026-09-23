-- 集中I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill21901 = oo.class(SkillBase)
function Skill21901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill21901:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 21901
	self:AddBuff(SkillEffect[21901], caster, self.card, data, 21901)
	-- 219010
	self:ShowTips(SkillEffect[219010], caster, self.card, data, 2,"集中",true,219010)
end
