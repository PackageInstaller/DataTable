-- 獅王之心
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984210401 = oo.class(BuffBase)
function Buffer984210401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer984210401:OnCreate(caster, target)
	-- 984210401
	self:AddAttr(BufferEffect[984210401], self.caster, target or self.owner, nil,"speed",50)
	-- 984210402
	self:AddAttr(BufferEffect[984210402], self.caster, target or self.owner, nil,"hit",0.5)
	-- 984210403
	self:AddAttrPercent(BufferEffect[984210403], self.caster, target or self.owner, nil,"attack",-0.3)
	-- 984210404
	self:AddAttrPercent(BufferEffect[984210404], self.caster, target or self.owner, nil,"bedamage",0.2)
end
