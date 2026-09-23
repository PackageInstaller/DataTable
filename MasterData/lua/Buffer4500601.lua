-- 防禦強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4500601 = oo.class(BuffBase)
function Buffer4500601:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4500601:OnCreate(caster, target)
	-- 4500601
	self:AddAttrPercent(BufferEffect[4500601], self.caster, target or self.owner, nil,"defense",0.06)
end
