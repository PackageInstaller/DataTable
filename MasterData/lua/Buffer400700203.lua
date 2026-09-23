-- 電磁力場
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer400700203 = oo.class(BuffBase)
function Buffer400700203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer400700203:OnCreate(caster, target)
	-- 400700203
	self:AddAttrPercent(BufferEffect[400700203], self.caster, target or self.owner, nil,"attack",0.30)
end
