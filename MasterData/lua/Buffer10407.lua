-- 暴傷強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10407 = oo.class(BuffBase)
function Buffer10407:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10407:OnCreate(caster, target)
	-- 4407
	self:AddAttr(BufferEffect[4407], self.caster, target or self.owner, nil,"crit",0.4)
end
