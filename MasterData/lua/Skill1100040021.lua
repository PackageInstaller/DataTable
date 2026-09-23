-- 肉鸽角色角色od不过热，od伤害增加60%，使用大招后有概率是怪物增加40%攻击力
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100040021 = oo.class(SkillBase)
function Skill1100040021:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100040021:OnBefourHurt(caster, target, data)
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
	-- 9731
	if SkillJudger:IsTypeOf(self, caster, target, true,4) then
	else
		return
	end
	-- 1100040021
	self:AddTempAttr(SkillEffect[1100040021], caster, self.card, data, "damage",0.6)
end
-- 行动结束
function Skill1100040021:OnActionOver(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 1100040014
	if self:Rand(6000) then
		self:AddBuff(SkillEffect[1100040014], caster, target, data, 1100040014)
	end
end
-- 入场时
function Skill1100040021:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100040024
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[1100040024], caster, target, data, 980101403)
	end
end
