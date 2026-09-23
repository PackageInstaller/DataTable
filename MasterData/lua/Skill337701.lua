-- 莫拉鲁塔2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill337701 = oo.class(SkillBase)
function Skill337701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill337701:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337701
	self:AddSp(SkillEffect[337701], caster, self.card, data, 5)
end
-- 特殊入场时(复活，召唤，合体)
function Skill337701:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337706
	self:AddSkillAttrPct(SkillEffect[337706], caster, self.card, data, "sp",-0.08)
end
