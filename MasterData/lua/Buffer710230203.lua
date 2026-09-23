-- 誓約者
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer710230203 = oo.class(BuffBase)
function Buffer710230203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动开始
function Buffer710230203:OnActionBegin(caster, target)
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
	-- 710230211
	self:AddBuffCount(BufferEffect[710230211], self.caster, self.creater, nil, 710230301,math.min(math.floor(c15/8000),3),3)
end
-- 伤害前
function Buffer710230203:OnBefourHurt(caster, target)
	-- 710230212
	self:tFunc_710230212_710230213(caster, target)
	self:tFunc_710230212_710230214(caster, target)
end
-- 创建时
function Buffer710230203:OnCreate(caster, target)
	-- 710230203
	self:AddAttrPercent(BufferEffect[710230203], self.caster, self.card, nil, "attack",0.15)
	-- 710230208
	self:AddAttrPercent(BufferEffect[710230208], self.caster, self.creater, nil, "attack",0.15)
end
function Buffer710230203:tFunc_710230212_710230213(caster, target)
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
	-- 8788
	local c788 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,47102)
	-- 710230213
	self:AddTempAttr(BufferEffect[710230213], self.caster, self.card, nil, "attack",math.floor(c75*(0.05+0.05*c788)))
end
function Buffer710230203:tFunc_710230212_710230214(caster, target)
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
	-- 8788
	local c788 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,47102)
	-- 710230214
	self:AddTempAttr(BufferEffect[710230214], self.caster, self.creater, nil, "attack",math.floor(c15*(0.05+0.05*c788)))
end
