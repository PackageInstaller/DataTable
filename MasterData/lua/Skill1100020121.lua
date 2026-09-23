-- 生命值概率转化为真实伤害（蓝色）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020121 = oo.class(SkillBase)
function Skill1100020121:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill1100020121:OnAfterHurt(caster, target, data)
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
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 1100020121
	if self:Rand(3000) then
		self:LimitDamage(SkillEffect[1100020121], caster, target, data, 0.05,math.floor(count20*0.000012))
	end
end
