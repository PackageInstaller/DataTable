-- 溯源探查蜘蛛添加血量技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5500122 = oo.class(SkillBase)
function Skill5500122:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill5500122:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5500122
	self:OwnerAddBuff(SkillEffect[5500122], caster, self.card, data, 1100010136)
end
