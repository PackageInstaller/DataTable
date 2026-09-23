-- 眾星環繞（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer780201301 = oo.class(BuffBase)
function Buffer780201301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer780201301:OnCreate(caster, target)
	-- 780201301
	self:AddAttrPercent(BufferEffect[780201301], self.caster, self.card, nil, "attack",0.3)
end
