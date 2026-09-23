-- 溯源探查第二期ex修改技能1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5500006 = oo.class(SkillBase)
function Skill5500006:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill5500006:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5500006
	self:AddBuff(SkillEffect[5500006], caster, self.card, data, 603000306)
end
