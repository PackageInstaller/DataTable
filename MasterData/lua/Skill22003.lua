-- 抵御III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill22003 = oo.class(SkillBase)
function Skill22003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill22003:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 22003
	self:AddBuff(SkillEffect[22003], caster, self.card, data, 22003)
	-- 220010
	self:ShowTips(SkillEffect[220010], caster, self.card, data, 2,"金刚",true,220010)
end
