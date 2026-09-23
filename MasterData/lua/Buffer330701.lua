-- 傷害提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer330701 = oo.class(BuffBase)
function Buffer330701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer330701:OnCreate(caster, target)
	-- 330701
	self:AddAttr(BufferEffect[330701], self.caster, target or self.owner, nil,"crit",0.03)
end
