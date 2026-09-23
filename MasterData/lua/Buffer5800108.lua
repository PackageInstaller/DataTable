-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5800108 = oo.class(BuffBase)
function Buffer5800108:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5800108:OnCreate(caster, target)
	-- 5800108
	self:AddAttrPercent(BufferEffect[5800108], self.caster, self.card, nil, "damage2",0.01*self.nCount)
end
