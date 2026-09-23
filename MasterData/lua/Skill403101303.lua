-- 星辰勘测（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill403101303 = oo.class(SkillBase)
function Skill403101303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill403101303:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
-- 行动开始
function Skill403101303:OnActionBegin(caster, target, data)
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
	-- 403101301
	self:AddBuff(SkillEffect[403101301], caster, self.card, data, 403101301)
end
-- 伤害后
function Skill403101303:OnAfterHurt(caster, target, data)
	-- 403100310
	self:tFunc_403100310_403100311(caster, target, data)
	self:tFunc_403100310_403100312(caster, target, data)
end
-- 伤害前
function Skill403101303:OnBefourHurt(caster, target, data)
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
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 403101303
	self:AddTempAttr(SkillEffect[403101303], caster, self.card, data, "damage",count7*0.005)
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
	-- 8635
	local count635 = SkillApi:BuffCount(self, caster, target,3,4,403100201)
	-- 8835
	if SkillJudger:Greater(self, caster, target, true,count635,0) then
	else
		return
	end
	-- 8832
	if SkillJudger:IsProgressLess(self, caster, target, true,10) then
	else
		return
	end
	-- 403100314
	self:AddTempAttr(SkillEffect[403100314], caster, self.card, data, "damage",1.5)
end
function Skill403101303:tFunc_403100310_403100312(caster, target, data)
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
	-- 8635
	local count635 = SkillApi:BuffCount(self, caster, target,3,4,403100201)
	-- 8835
	if SkillJudger:Greater(self, caster, target, true,count635,0) then
	else
		return
	end
	-- 403100312
	if self:Rand(6000) then
		self:AddProgress(SkillEffect[403100312], caster, target, data, -200)
	end
end
function Skill403101303:tFunc_403100310_403100311(caster, target, data)
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
	-- 8635
	local count635 = SkillApi:BuffCount(self, caster, target,3,4,403100201)
	-- 8836
	if SkillJudger:Equal(self, caster, target, true,count635,0) then
	else
		return
	end
	-- 403100311
	if self:Rand(2500) then
		self:AddProgress(SkillEffect[403100311], caster, target, data, -200)
	end
end
