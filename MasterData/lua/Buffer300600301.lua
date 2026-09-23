-- 羽盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer300600301 = oo.class(BuffBase)
function Buffer300600301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer300600301:OnCreate(caster, target)
	-- 8720
	local c116 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"hp")
	-- 932800204
	local cmaxhp = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"maxhp")
	-- 300600301
	self:AddShieldValue(BufferEffect[300600301], self.caster, self.card, nil, math.floor((math.max((0.8*c116/cmaxhp-0.4)*10,0)*0.1*cmaxhp+0.2*c116+cmaxhp-c116)*0.5))
	-- 8782
	local c782 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3393)
	-- 300600304
	self:AddAttr(BufferEffect[300600304], self.caster, self.card, nil, "crit",0.1*c782)
	-- 8782
	local c782 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3393)
	-- 300600305
	self:AddAttr(BufferEffect[300600305], self.caster, self.card, nil, "bedamage",-0.03*c782)
end
