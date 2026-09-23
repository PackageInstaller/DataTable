-- 機動強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4213 = oo.class(BuffBase)
function Buffer4213:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4213:OnCreate(caster, target)
	-- 4213
	self:AddAttrPercent(BufferEffect[4213], self.caster, target or self.owner, nil,"speed",0.2)
end
