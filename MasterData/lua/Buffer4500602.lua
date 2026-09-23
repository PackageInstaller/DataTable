-- 防禦強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4500602 = oo.class(BuffBase)
function Buffer4500602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4500602:OnCreate(caster, target)
	-- 4500602
	self:AddAttrPercent(BufferEffect[4500602], self.caster, target or self.owner, nil,"defense",0.07)
end
