-- 免疫-麻痹
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9009 = oo.class(SkillBase)
function Skill9009:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9009:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9009
	self:AddBuff(SkillEffect[9009], caster, self.card, data, 9009)
end
