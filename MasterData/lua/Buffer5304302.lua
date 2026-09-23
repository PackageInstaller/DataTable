-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5304302 = oo.class(BuffBase)
function Buffer5304302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动开始
function Buffer5304302:OnActionBegin(caster, target)
	-- 5304303
	self:tFunc_5304303_5304304(caster, target)
	self:tFunc_5304303_5304305(caster, target)
end
-- 伤害前
function Buffer5304302:OnBefourHurt(caster, target)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8259
	if SkillJudger:IsCanHurt(self, self.caster, target, true) then
	else
		return
	end
	-- 8246
	if SkillJudger:IsTargetMech(self, self.caster, target, true,10) then
	else
		return
	end
	-- 8802
	local c802 = SkillApi:GetAttr(self, self.caster, target or self.owner,1,"id")
	-- 8638
	if SkillJudger:Equal(self, self.caster, self.card, true,c802,30431) then
	else
		return
	end
	-- 5304306
	self:AddTempAttr(BufferEffect[5304306], self.caster, self.caster, nil, "damage",0.3)
end
-- 创建时
function Buffer5304302:OnCreate(caster, target)
	-- 8801
	local c801 = SkillApi:GetCount(self, self.caster, target or self.owner,4,5304306)
	-- 5304301
	self:AddAttrPercent(BufferEffect[5304301], self.caster, self.card, nil, "attack",math.min(0.1+0.01*c801,0.3))
	-- 8801
	local c801 = SkillApi:GetCount(self, self.caster, target or self.owner,4,5304306)
	-- 5304302
	self:AddAttrPercent(BufferEffect[5304302], self.caster, self.creater, nil, "attack",math.min(0.1+0.01*c801,0.3))
end
function Buffer5304302:tFunc_5304303_5304305(caster, target)
	-- 8160
	if SkillJudger:IsCasterBuff(self, self.caster, target, true) then
	else
		return
	end
	-- 8264
	if SkillJudger:IsTypeOf(self, self.caster, target, true,7) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 5304305
	self:AddTempAttrPercent(BufferEffect[5304305], self.caster, self.card, nil, "attack",1)
	-- 5304307
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(BufferEffect[5304307], self.caster, target, nil, 5304305)
	end
	-- 5304308
	self:AddBuff(BufferEffect[5304308], self.caster, self.card, nil, 5304305)
	-- 5304309
	self:AddBuff(BufferEffect[5304309], self.caster, self.creater, nil, 5304305)
	-- 8801
	local c801 = SkillApi:GetCount(self, self.caster, target or self.owner,4,5304306)
	-- 5304312
	self:AddBuffCount(BufferEffect[5304312], self.caster, self.creater, nil, 5304306,math.min(c801,50),999)
end
function Buffer5304302:tFunc_5304303_5304304(caster, target)
	-- 8160
	if SkillJudger:IsCasterBuff(self, self.caster, target, true) then
	else
		return
	end
	-- 8264
	if SkillJudger:IsTypeOf(self, self.caster, target, true,7) then
	else
		return
	end
	-- 8075
	if SkillJudger:TargetIsSelf(self, self.caster, target, false) then
	else
		return
	end
	-- 5304304
	self:AddTempAttrPercent(BufferEffect[5304304], self.caster, self.creater, nil, "attack",0.3)
end
