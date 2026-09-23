-- 防禦弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5101 = oo.class(BuffBase)
function Buffer5101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5101:OnCreate(caster, target)
	-- 5101
	self:AddAttrPercent(BufferEffect[5101], self.caster, target or self.owner, nil,"defense",-0.05)
end
