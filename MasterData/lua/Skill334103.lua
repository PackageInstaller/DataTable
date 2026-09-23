-- 乌斯怀亚2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334103 = oo.class(SkillBase)
function Skill334103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill334103:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334103
	self:AddSp(SkillEffect[334103], caster, self.card, data, 15)
end
-- 特殊入场时(复活，召唤，合体)
function Skill334103:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334113
	self:AddBuff(SkillEffect[334113], caster, self.card, data, 334113)
end
