-- 战局感应
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4601905 = oo.class(SkillBase)
function Skill4601905:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4601905:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4601904
	self:AddSp(SkillEffect[4601904], caster, self.card, data, 20)
	-- 4601911
	self:ShowTips(SkillEffect[4601911], caster, self.card, data, 2,"战局感应",true,4601911)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4601910
	self:AddBuff(SkillEffect[4601910], caster, self.card, data, 4601910)
end
