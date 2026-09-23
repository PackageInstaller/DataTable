-- 机神充能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9034 = oo.class(SkillBase)
function Skill9034:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill9034:OnRoundBegin(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 9034
	self:AddSp(SkillEffect[9034], caster, caster, data, 100)
end
