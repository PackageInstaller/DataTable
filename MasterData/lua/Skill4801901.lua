-- 花语
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4801901 = oo.class(SkillBase)
function Skill4801901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4801901:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8633
	local count633 = SkillApi:GetDamage(self, caster, target,1)
	-- 4801901
	self:AddHp(SkillEffect[4801901], caster, self.card, data, math.floor(count633*0.15))
end
