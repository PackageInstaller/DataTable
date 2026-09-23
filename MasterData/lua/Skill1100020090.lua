-- 开局时，速度提高20%（蓝色）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020090 = oo.class(SkillBase)
function Skill1100020090:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100020090:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100020090
	self:OwnerAddBuff(SkillEffect[1100020090], caster, self.card, data, 1100020090)
end
