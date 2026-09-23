-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500301310 = oo.class(SkillBase)
function Skill500301310:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500301310:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[12203], caster, target, data, 0.32,1)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[5104], caster, target, data, 5104)
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[12204], caster, target, data, 0.075,4)
	end
end
-- 伤害前
function Skill500301310:OnBefourHurt(caster, target, data)
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
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	self:AddTempAttrPercent(SkillEffect[999999992], caster, target, data, "defense",-0.70)
end
-- 行动开始
function Skill500301310:OnActionBegin(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	self:AddBuff(SkillEffect[999999990], caster, self.card, data, 999999990)
end
