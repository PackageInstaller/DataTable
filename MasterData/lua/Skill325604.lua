-- 雷暴之力
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill325604 = oo.class(SkillBase)
function Skill325604:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill325604:OnAfterHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 325604
	self:AddBuff(SkillEffect[325604], caster, self.card, data, 400700205,2)
end
