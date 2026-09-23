-- 機動強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4204 = oo.class(BuffBase)
function Buffer4204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4204:OnCreate(caster, target)
	-- 4204
	self:AddAttr(BufferEffect[4204], self.caster, target or self.owner, nil,"speed",20)
end
