-- 命中強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer22603 = oo.class(BuffBase)
function Buffer22603:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer22603:OnCreate(caster, target)
	-- 22603
	self:AddAttr(BufferEffect[22603], self.caster, target or self.owner, nil,"hit",0.45)
end
