-- 溯源探查第三期ex修改技能10
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5500110 = oo.class(SkillBase)
function Skill5500110:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill5500110:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5500111
	self:OwnerAddBuff(SkillEffect[5500111], caster, self.card, data, 1100010131)
end
