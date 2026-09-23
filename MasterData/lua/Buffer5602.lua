-- 效果抵抗弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5602 = oo.class(BuffBase)
function Buffer5602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5602:OnCreate(caster, target)
	-- 5602
	self:AddAttr(BufferEffect[5602], self.caster, target or self.owner, nil,"resist",-0.1)
end
