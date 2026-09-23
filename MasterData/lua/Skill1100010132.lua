-- 战斗开始时，全体增加30%耐久上限
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010132 = oo.class(SkillBase)
function Skill1100010132:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100010132:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100010132
	self:OwnerAddBuff(SkillEffect[1100010132], caster, self.card, data, 1100010132)
end
