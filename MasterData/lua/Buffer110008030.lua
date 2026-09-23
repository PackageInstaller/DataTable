-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer110008030 = oo.class(BuffBase)
function Buffer110008030:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer110008030:OnCreate(caster, target)
	-- 110008030
	self:AddAttrPercent(BufferEffect[110008030], self.caster, self.card, nil, "attack",0.05*self.nCount)
end
