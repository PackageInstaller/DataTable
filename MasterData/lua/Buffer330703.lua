-- 傷害提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer330703 = oo.class(BuffBase)
function Buffer330703:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer330703:OnCreate(caster, target)
	-- 330703
	self:AddAttr(BufferEffect[330703], self.caster, target or self.owner, nil,"crit",0.09)
end
