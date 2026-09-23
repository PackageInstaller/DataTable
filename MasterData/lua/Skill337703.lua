-- 莫拉鲁塔2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill337703 = oo.class(SkillBase)
function Skill337703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill337703:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337703
	self:AddSp(SkillEffect[337703], caster, self.card, data, 15)
end
-- 特殊入场时(复活，召唤，合体)
function Skill337703:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337708
	self:AddSkillAttrPct(SkillEffect[337708], caster, self.card, data, "sp",-0.24)
end
