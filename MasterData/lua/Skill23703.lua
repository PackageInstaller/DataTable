-- 振奋III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23703 = oo.class(SkillBase)
function Skill23703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill23703:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 23703
	self:AddBuff(SkillEffect[23703], caster, self.card, data, 23703)
	-- 237010
	self:ShowTips(SkillEffect[237010], caster, self.card, data, 2,"振奋",true,237010)
end
