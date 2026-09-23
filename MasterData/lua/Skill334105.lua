-- 乌斯怀亚2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334105 = oo.class(SkillBase)
function Skill334105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill334105:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334105
	self:AddSp(SkillEffect[334105], caster, self.card, data, 25)
end
-- 特殊入场时(复活，召唤，合体)
function Skill334105:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334115
	self:AddBuff(SkillEffect[334115], caster, self.card, data, 334115)
end
