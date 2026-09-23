-- 刪除物理屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer9406 = oo.class(BuffBase)
function Buffer9406:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer9406:OnCreate(caster, target)
	-- 9408
	self:DelBufferForce(BufferEffect[9408], self.caster, self.card, nil, 2209)
end
