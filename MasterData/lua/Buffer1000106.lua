-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000106 = oo.class(BuffBase)
function Buffer1000106:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000106:OnCreate(caster, target)
	-- 1000106
	self:AddAttr(BufferEffect[1000106], self.caster, target or self.owner, nil,"damage",0.25)
end
