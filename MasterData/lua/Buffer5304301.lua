-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5304301 = oo.class(BuffBase)
function Buffer5304301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5304301:OnCreate(caster, target)
	-- 8801
	local c801 = SkillApi:GetCount(self, self.caster, target or self.owner,4,5304306)
	-- 5304301
	self:AddAttrPercent(BufferEffect[5304301], self.caster, self.card, nil, "attack",math.min(0.1+0.01*c801,0.3))
	-- 8801
	local c801 = SkillApi:GetCount(self, self.caster, target or self.owner,4,5304306)
	-- 5304302
	self:AddAttrPercent(BufferEffect[5304302], self.caster, self.creater, nil, "attack",math.min(0.1+0.01*c801,0.3))
end
