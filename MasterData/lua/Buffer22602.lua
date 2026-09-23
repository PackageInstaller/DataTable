-- 命中強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer22602 = oo.class(BuffBase)
function Buffer22602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer22602:OnCreate(caster, target)
	-- 22602
	self:AddAttr(BufferEffect[22602], self.caster, target or self.owner, nil,"hit",0.3)
end
