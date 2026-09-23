-- 凝冰坠落（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill401201301 = oo.class(SkillBase)
function Skill401201301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill401201301:DoSkill(caster, target, data)
	-- 12205
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[12205], caster, target, data, 0.4,1)
	-- 12206
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[12206], caster, target, data, 0.15,2)
	end
end
-- 伤害前
function Skill401201301:OnBefourHurt(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 999999996
	self:AddTempAttr(SkillEffect[999999996], caster, self.card, data, "damage",0.5)
end
-- 行动开始
function Skill401201301:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 999999984
	self:AddBuff(SkillEffect[999999984], caster, self.card, data, 4507,1)
end
