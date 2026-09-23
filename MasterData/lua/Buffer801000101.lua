-- 減防
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer801000101 = oo.class(BuffBase)
function Buffer801000101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer801000101:OnCreate(caster, target)
	-- 801000101
	self:AddAttr(BufferEffect[801000101], self.caster, target or self.owner, nil,"defense",-200)
end
