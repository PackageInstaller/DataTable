-- 入场曲，谢幕曲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9115 = oo.class(SkillBase)
function Skill9115:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill9115:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 323801
	self:CallSkill(SkillEffect[323801], caster, self.card, data, 500110205)
end
-- 解体时
function Skill9115:OnResolve(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 323802
	self:CallSkill(SkillEffect[323802], caster, self.card, data, 500110205)
end
