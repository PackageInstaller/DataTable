-- 失能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer780200201 = oo.class(BuffBase)
function Buffer780200201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer780200201:OnCreate(caster, target)
	-- 780200201
	self:AddAttrPercent(BufferEffect[780200201], self.caster, self.card, nil, "attack",-0.1)
end
