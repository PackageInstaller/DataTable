-- 守护之盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9047 = oo.class(SkillBase)
function Skill9047:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill9047:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9047
	self:CallSkillEx(SkillEffect[9047], caster, self.card, data, 100100203)
	-- 9043
	self:AddBuff(SkillEffect[9043], caster, self.card, data, 9037)
end
