-- 電磁力場
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer400700206 = oo.class(BuffBase)
function Buffer400700206:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer400700206:OnCreate(caster, target)
	-- 400700206
	self:AddAttrPercent(BufferEffect[400700206], self.caster, target or self.owner, nil,"attack",0.45)
end
