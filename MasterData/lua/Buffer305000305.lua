-- 納氣
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer305000305 = oo.class(BuffBase)
function Buffer305000305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer305000305:OnCreate(caster, target)
	-- 305000305
	self:AddAttr(BufferEffect[305000305], self.caster, target or self.owner, nil,"resist",1.00)
end
