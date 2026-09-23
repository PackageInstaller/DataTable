-- 溯源探查第三期ex修改技能7
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5500107 = oo.class(SkillBase)
function Skill5500107:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill5500107:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5500108
	self:AddBuff(SkillEffect[5500108], caster, self.card, data, 5500108)
end
