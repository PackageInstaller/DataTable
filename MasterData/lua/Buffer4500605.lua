-- 防禦強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4500605 = oo.class(BuffBase)
function Buffer4500605:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4500605:OnCreate(caster, target)
	-- 4500605
	self:AddAttrPercent(BufferEffect[4500605], self.caster, target or self.owner, nil,"defense",0.10)
end
