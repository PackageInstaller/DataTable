-- 勇猛之心
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984200401 = oo.class(BuffBase)
function Buffer984200401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer984200401:OnCreate(caster, target)
	-- 984200401
	self:AddAttrPercent(BufferEffect[984200401], self.caster, target or self.owner, nil,"attack",0.15)
	-- 984200402
	self:AddAttr(BufferEffect[984200402], self.caster, target or self.owner, nil,"bedamage",-0.3)
	-- 984200403
	self:AddAttr(BufferEffect[984200403], self.caster, target or self.owner, nil,"resist",-0.3)
	-- 984200404
	self:AddAttr(BufferEffect[984200404], self.caster, target or self.owner, nil,"speed",-40)
end
