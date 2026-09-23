-- 樂團陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100020024 = oo.class(BuffBase)
function Buffer1100020024:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100020024:OnCreate(caster, target)
	-- 1100020024
	self:AddAttrPercent(BufferEffect[1100020024], self.caster, target or self.owner, nil,"attack",0.3)
	-- 1100020025
	self:AddAttr(BufferEffect[1100020025], self.caster, target or self.owner, nil,"speed",15)
end
