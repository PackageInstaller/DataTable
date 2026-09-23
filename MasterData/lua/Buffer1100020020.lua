-- 樂團陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100020020 = oo.class(BuffBase)
function Buffer1100020020:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100020020:OnCreate(caster, target)
	-- 1100020020
	self:AddAttrPercent(BufferEffect[1100020020], self.caster, target or self.owner, nil,"attack",0.1)
	-- 1100020021
	self:AddAttr(BufferEffect[1100020021], self.caster, target or self.owner, nil,"speed",5)
end
