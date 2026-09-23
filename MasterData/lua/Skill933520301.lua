-- 蝎子部位2特性
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill933520301 = oo.class(SkillBase)
function Skill933520301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill933520301:OnAttackOver(caster, target, data)
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
	-- 933520301
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[933520301], caster, target, data, 5106)
	end
end
-- 攻击结束2
function Skill933520301:OnAttackOver2(caster, target, data)
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
	-- 933520302
	self:AddBuff(SkillEffect[933520302], caster, target, data, 5705)
end
