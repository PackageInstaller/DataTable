-- 乌斯怀亚2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334101 = oo.class(SkillBase)
function Skill334101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill334101:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334101
	self:AddSp(SkillEffect[334101], caster, self.card, data, 5)
end
-- 特殊入场时(复活，召唤，合体)
function Skill334101:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334111
	self:AddBuff(SkillEffect[334111], caster, self.card, data, 334111)
end
