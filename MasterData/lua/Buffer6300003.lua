-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6300003 = oo.class(BuffBase)
function Buffer6300003:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6300003:OnCreate(caster, target)
	-- 4304
	self:AddAttr(BufferEffect[4304], self.caster, target or self.owner, nil,"crit_rate",0.2)
end
