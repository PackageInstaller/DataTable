-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4810 = oo.class(BuffBase)
function Buffer4810:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4810:OnCreate(caster, target)
	-- 4810
	self:AddAttr(BufferEffect[4810], self.caster, target or self.owner, nil,"damage",0.1)
end
