-- 羽盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer300600302 = oo.class(BuffBase)
function Buffer300600302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer300600302:OnCreate(caster, target)
	-- 8720
	local c116 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"hp")
	-- 932800204
	local cmaxhp = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"maxhp")
	-- 300600302
	self:AddShieldValue(BufferEffect[300600302], self.caster, self.card, nil, math.floor((cmaxhp-c116*0.8)*0.5))
	-- 8720
	local c116 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"hp")
	-- 300600303
	self:AddHp(BufferEffect[300600303], self.caster, self.card, nil, -math.floor(c116*0.2))
	-- 8782
	local c782 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3393)
	-- 300600304
	self:AddAttr(BufferEffect[300600304], self.caster, self.card, nil, "crit",0.1*c782)
	-- 8782
	local c782 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3393)
	-- 300600305
	self:AddAttr(BufferEffect[300600305], self.caster, self.card, nil, "bedamage",-0.03*c782)
end
