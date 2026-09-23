-- 刪除能量屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer9405 = oo.class(BuffBase)
function Buffer9405:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer9405:OnCreate(caster, target)
	-- 9407
	self:DelBufferForce(BufferEffect[9407], self.caster, self.card, nil, 2309)
end
