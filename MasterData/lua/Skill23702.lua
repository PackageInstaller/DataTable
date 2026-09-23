-- 振奋II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23702 = oo.class(SkillBase)
function Skill23702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill23702:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 23702
	self:AddBuff(SkillEffect[23702], caster, self.card, data, 23702)
	-- 237010
	self:ShowTips(SkillEffect[237010], caster, self.card, data, 2,"振奋",true,237010)
end
