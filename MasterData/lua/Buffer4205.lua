-- 機動強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4205 = oo.class(BuffBase)
function Buffer4205:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4205:OnCreate(caster, target)
	-- 4205
	self:AddAttr(BufferEffect[4205], self.caster, target or self.owner, nil,"speed",25)
end
