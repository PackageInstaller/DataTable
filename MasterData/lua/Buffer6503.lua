-- 水能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6503 = oo.class(BuffBase)
function Buffer6503:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6503:OnCreate(caster, target)
	-- 6503
	self:AddAttrPercent(BufferEffect[6503], self.caster, target or self.owner, nil,"attack",0.16)
end
