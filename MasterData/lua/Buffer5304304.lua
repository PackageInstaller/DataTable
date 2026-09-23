-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5304304 = oo.class(BuffBase)
function Buffer5304304:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer5304304:OnBefourHurt(caster, target)
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
function Buffer5304304:OnCreate(caster, target)
	-- 8801
	local c801 = SkillApi:GetCount(self, self.caster, target or self.owner,4,5304306)
	-- 5304301
	self:AddAttrPercent(BufferEffect[5304301], self.caster, self.card, nil, "attack",math.min(0.1+0.01*c801,0.3))
	-- 8801
	local c801 = SkillApi:GetCount(self, self.caster, target or self.owner,4,5304306)
	-- 5304302
	self:AddAttrPercent(BufferEffect[5304302], self.caster, self.creater, nil, "attack",math.min(0.1+0.01*c801,0.3))
end
