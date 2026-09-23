-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10801 = oo.class(BuffBase)
function Buffer10801:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10801:OnCreate(caster, target)
	-- 4801
	self:AddAttr(BufferEffect[4801], self.caster, target or self.owner, nil,"damage",0.05)
end
