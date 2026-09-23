-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill700701308 = oo.class(SkillBase)
function Skill700701308:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill700701308:DoSkill(caster, target, data)
	self.order = self.order + 1
	local targets = SkillFilter:DynamicCross(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[12301], caster, target, data, 1,1)
	end
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[12302], caster, target, data, 1,1)
	end
end
-- 行动结束
function Skill700701308:OnActionOver(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	self:AddBuff(SkillEffect[999999991], caster, self.card, data, 3003,1)
end
-- 伤害前
function Skill700701308:OnBefourHurt(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	local count11 = SkillApi:BuffCount(self, caster, target,1,1,2)
	self:AddTempAttr(SkillEffect[999999997], caster, self.card, data, "damage",count11*0.2)
end
