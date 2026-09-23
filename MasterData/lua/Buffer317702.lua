-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer317702 = oo.class(BuffBase)
function Buffer317702:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer317702:OnCreate(caster, target)
	-- 317702
	self:AddAttr(BufferEffect[317702], self.caster, target or self.owner, nil,"damage",0.06)
end
