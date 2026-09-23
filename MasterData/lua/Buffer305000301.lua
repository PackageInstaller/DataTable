-- 納氣
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer305000301 = oo.class(BuffBase)
function Buffer305000301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer305000301:OnCreate(caster, target)
	-- 305000301
	self:AddAttr(BufferEffect[305000301], self.caster, target or self.owner, nil,"resist",0.60)
end
