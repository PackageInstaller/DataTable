-- 肉鸽角色将角色进行攻击后，将本次伤害20%扩散到敌方全场，使用大招后有概率是怪物增加40%防御力
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100040050 = oo.class(SkillBase)
function Skill1100040050:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill1100040050:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8235
	if SkillJudger:IsCasterMech(self, caster, self.card, true,4) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100040050
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[1100040050], caster, target, data, 1032)
	end
end
-- 入场时
function Skill1100040050:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4402206
	self:AddBuff(SkillEffect[4402206], caster, self.card, data, 1031)
end
-- 行动结束
function Skill1100040050:OnActionOver(caster, target, data)
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
	-- 1100040015
	if self:Rand(6000) then
		self:AddBuff(SkillEffect[1100040015], caster, target, data, 1100040015)
	end
end
