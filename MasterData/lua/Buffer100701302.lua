-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer100701302 = oo.class(BuffBase)
function Buffer100701302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer100701302:OnCreate(caster, target)
	-- 8776
	local c776 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,41007)
	-- 8777
	local c777 = SkillApi:GetCount(self, self.caster, target or self.owner,4,100700101)
	-- 100700303
	local dmg10070 = SkillApi:GetValue(self, self.caster, target or self.owner,3,"dmg10070")
	-- 100701302
	self:AddHp(BufferEffect[100701302], self.caster, self.card, nil, -math.floor(dmg10070*1.2*(1+0.02*c776*c777)))
	-- 100700304
	self:DelValue(BufferEffect[100700304], self.caster, self.card, nil, "dmg10070")
end
