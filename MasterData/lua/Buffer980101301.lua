-- 山脈屬性buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980101301 = oo.class(BuffBase)
function Buffer980101301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980101301:OnCreate(caster, target)
	-- 8742
	local c138 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,3)
	-- 980101301
	self:AddAttrPercent(BufferEffect[980101301], self.caster, target or self.owner, nil,"attack",0.3)
	-- 8742
	local c138 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,3)
	-- 980101302
	self:AddAttr(BufferEffect[980101302], self.caster, target or self.owner, nil,"crit",0.5)
end
