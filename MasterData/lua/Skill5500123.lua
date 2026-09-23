-- 溯源探查蜘蛛添加血量技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5500123 = oo.class(SkillBase)
function Skill5500123:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill5500123:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5500123
	self:OwnerAddBuff(SkillEffect[5500123], caster, self.card, data, 1100010137)
end
