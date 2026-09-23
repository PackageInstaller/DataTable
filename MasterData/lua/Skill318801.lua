-- 装甲加固
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill318801 = oo.class(SkillBase)
function Skill318801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill318801:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 318801
	self:AddBuff(SkillEffect[318801], caster, self.card, data, 318801)
end
