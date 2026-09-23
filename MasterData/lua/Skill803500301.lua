-- 放逐者3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill803500301 = oo.class(SkillBase)
function Skill803500301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill803500301:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
-- 伤害前
function Skill803500301:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8246
	if SkillJudger:IsTargetMech(self, caster, target, true,10) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 803500301
	self:AddTempAttr(SkillEffect[803500301], caster, self.card, data, "damage",1.5)
end
-- 死亡时
function Skill803500301:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4803505
	local targets = SkillFilter:Teammate(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:DelSkill(SkillEffect[4803505], caster, target, data, 803400401)
	end
end
