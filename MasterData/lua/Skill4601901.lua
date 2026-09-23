-- 战局感应
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4601901 = oo.class(SkillBase)
function Skill4601901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4601901:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4601901
	self:AddSp(SkillEffect[4601901], caster, self.card, data, 5)
	-- 4601911
	self:ShowTips(SkillEffect[4601911], caster, self.card, data, 2,"战局感应",true,4601911)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4601906
	self:AddBuff(SkillEffect[4601906], caster, self.card, data, 4601906)
end
