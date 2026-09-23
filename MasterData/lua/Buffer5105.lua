-- 防禦弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5105 = oo.class(BuffBase)
function Buffer5105:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5105:OnCreate(caster, target)
	-- 5105
	self:AddAttrPercent(BufferEffect[5105], self.caster, target or self.owner, nil,"defense",-0.25)
end
