-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5500128 = oo.class(BuffBase)
function Buffer5500128:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5500128:OnCreate(caster, target)
	-- 4008
	self:AddAttrPercent(BufferEffect[4008], self.caster, target or self.owner, nil,"attack",0.4)
	-- 4104
	self:AddAttrPercent(BufferEffect[4104], self.caster, target or self.owner, nil,"defense",0.2)
end
