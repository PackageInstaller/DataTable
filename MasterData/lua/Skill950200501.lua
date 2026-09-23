-- 玄月被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill950200501 = oo.class(SkillBase)
function Skill950200501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill950200501:OnAttackOver(caster, target, data)
	-- 8580
	local count101 = SkillApi:BuffCount(self, caster, target,1,2,2)
	-- 950200204
	if SkillJudger:Greater(self, caster, target, true,count101,2) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 950200203
	self:CallSkill(SkillEffect[950200203], caster, target, data, 950200101)
end
