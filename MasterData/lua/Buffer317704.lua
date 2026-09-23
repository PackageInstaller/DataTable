-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer317704 = oo.class(BuffBase)
function Buffer317704:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer317704:OnCreate(caster, target)
	-- 317704
	self:AddAttr(BufferEffect[317704], self.caster, target or self.owner, nil,"damage",0.12)
end
