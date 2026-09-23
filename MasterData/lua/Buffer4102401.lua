-- 炸盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4102401 = oo.class(BuffBase)
function Buffer4102401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4102401:OnCreate(caster, target)
	-- 8446
	local c46 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,41024)
	-- 8447
	local c47 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"defense")
	-- 8218
	if SkillJudger:IsShieldDestroy(self, self.caster, target, true) then
	else
		return
	end
	-- 4102401
	self:AddHp(BufferEffect[4102401], self.caster, self.caster, nil, math.floor(-(c46*0.5+2.5)*c47))
	-- 8218
	if SkillJudger:IsShieldDestroy(self, self.caster, target, true) then
	else
		return
	end
	-- 2003
	self:Cure(BufferEffect[2003], self.caster, self.card, nil, 8,0.15)
	-- 8472
	local c72 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3214)
	-- 8624
	if SkillJudger:Greater(self, self.caster, self.card, true,c72,0) then
	else
		return
	end
	-- 321406
	self:AddProgress(BufferEffect[321406], self.caster, self.card, nil, c72*50)
end
