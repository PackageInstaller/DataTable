-- 誓約者
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer710130204 = oo.class(BuffBase)
function Buffer710130204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动开始
function Buffer710130204:OnActionBegin(caster, target)
	-- 8160
	if SkillJudger:IsCasterBuff(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, self.caster, target, true) then
	else
		return
	end
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 710130211
	self:AddBuffCount(BufferEffect[710130211], self.caster, self.creater, nil, 710130301,math.min(math.floor(c15/8000),3),3)
end
-- 伤害前
function Buffer710130204:OnBefourHurt(caster, target)
	-- 710130212
	self:tFunc_710130212_710130213(caster, target)
	self:tFunc_710130212_710130214(caster, target)
end
-- 创建时
function Buffer710130204:OnCreate(caster, target)
	-- 710130204
	self:AddAttrPercent(BufferEffect[710130204], self.caster, self.card, nil, "attack",0.2)
	-- 710130209
	self:AddAttrPercent(BufferEffect[710130209], self.caster, self.creater, nil, "attack",0.2)
end
function Buffer710130204:tFunc_710130212_710130213(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8475
	local c75 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"attack")
	-- 8787
	local c787 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,47101)
	-- 710130213
	self:AddTempAttr(BufferEffect[710130213], self.caster, self.card, nil, "attack",math.floor(c75*(0.05+0.05*c787)))
end
function Buffer710130204:tFunc_710130212_710130214(caster, target)
	-- 8160
	if SkillJudger:IsCasterBuff(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 8787
	local c787 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,47101)
	-- 710130214
	self:AddTempAttr(BufferEffect[710130214], self.caster, self.creater, nil, "attack",math.floor(c15*(0.05+0.05*c787)))
end
