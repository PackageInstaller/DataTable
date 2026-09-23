-- 機動強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4206 = oo.class(BuffBase)
function Buffer4206:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4206:OnCreate(caster, target)
	-- 4206
	self:AddAttr(BufferEffect[4206], self.caster, target or self.owner, nil,"speed",30)
end
