-- 電磁力場
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer400700205 = oo.class(BuffBase)
function Buffer400700205:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer400700205:OnCreate(caster, target)
	-- 400700205
	self:AddAttrPercent(BufferEffect[400700205], self.caster, target or self.owner, nil,"attack",0.40)
end
