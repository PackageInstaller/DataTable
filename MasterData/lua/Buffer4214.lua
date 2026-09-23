-- 機動強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4214 = oo.class(BuffBase)
function Buffer4214:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4214:OnCreate(caster, target)
	-- 4214
	self:AddAttrPercent(BufferEffect[4214], self.caster, target or self.owner, nil,"speed",1)
end
