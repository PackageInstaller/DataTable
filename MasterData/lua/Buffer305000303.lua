-- 納氣
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer305000303 = oo.class(BuffBase)
function Buffer305000303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer305000303:OnCreate(caster, target)
	-- 305000303
	self:AddAttr(BufferEffect[305000303], self.caster, target or self.owner, nil,"resist",0.80)
end
