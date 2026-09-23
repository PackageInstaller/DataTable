-- 防禦弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer316104 = oo.class(BuffBase)
function Buffer316104:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer316104:OnCreate(caster, target)
	-- 316104
	self:AddAttr(BufferEffect[316104], self.caster, target or self.owner, nil,"defense",-24)
end
