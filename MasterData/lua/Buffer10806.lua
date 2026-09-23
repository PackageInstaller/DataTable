-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10806 = oo.class(BuffBase)
function Buffer10806:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10806:OnCreate(caster, target)
	-- 4806
	self:AddAttr(BufferEffect[4806], self.caster, target or self.owner, nil,"damage",0.3)
end
