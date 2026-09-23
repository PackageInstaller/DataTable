-- 莫拉鲁塔2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill337702 = oo.class(SkillBase)
function Skill337702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill337702:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337702
	self:AddSp(SkillEffect[337702], caster, self.card, data, 10)
end
-- 特殊入场时(复活，召唤，合体)
function Skill337702:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337707
	self:AddSkillAttrPct(SkillEffect[337707], caster, self.card, data, "sp",-0.16)
end
