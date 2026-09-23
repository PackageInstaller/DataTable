-- 持續傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5500107 = oo.class(BuffBase)
function Buffer5500107:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5500107:OnCreate(caster, target)
	-- 5102
	self:AddAttrPercent(BufferEffect[5102], self.caster, target or self.owner, nil,"defense",-0.1)
end
