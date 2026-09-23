-- 納氣
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer305000302 = oo.class(BuffBase)
function Buffer305000302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer305000302:OnCreate(caster, target)
	-- 305000302
	self:AddAttr(BufferEffect[305000302], self.caster, target or self.owner, nil,"resist",0.70)
end
