-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer318603 = oo.class(BuffBase)
function Buffer318603:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer318603:OnCreate(caster, target)
	-- 318603
	self:AddAttr(BufferEffect[318603], self.caster, target or self.owner, nil,"damage",0.15)
end
