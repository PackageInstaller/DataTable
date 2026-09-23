-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337001 = oo.class(BuffBase)
function Buffer337001:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337001:OnCreate(caster, target)
	-- 4201
	self:AddAttr(BufferEffect[4201], self.caster, target or self.owner, nil,"speed",5)
end
