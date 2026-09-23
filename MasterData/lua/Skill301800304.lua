-- 碎裂强袭
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301800304 = oo.class(SkillBase)
function Skill301800304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill301800304:DoSkill(caster, target, data)
	-- 11081
	self.order = self.order + 1
	local targets = SkillFilter:Different(self, caster, target, 4,8)
	for i,target in ipairs(targets) do
		-- 11082
		self:DamagePhysics(SkillEffect[11082], caster, target, data, 1,1)
		-- 11083
		self:AddOrder(SkillEffect[11083], caster, target, data, nil)
		-- 8331
		self:AddValue(SkillEffect[8331], caster, target, data, "suaijian",1)
	end
	-- 8332
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DelValue(SkillEffect[8332], caster, target, data, "suaijian")
	end
end
-- 伤害前
function Skill301800304:OnBefourHurt(caster, target, data)
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
	-- 8333
	local suaijian = SkillApi:GetValue(self, caster, target,2,"suaijian")
	-- 8334
	if SkillJudger:Greater(self, caster, self.card, true,suaijian,0) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 301800301
	self:AddTempAttr(SkillEffect[301800301], caster, self.card, data, "damage",-0.4)
end
