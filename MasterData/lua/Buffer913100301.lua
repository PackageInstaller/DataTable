-- 白絨祝福
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913100301 = oo.class(BuffBase)
function Buffer913100301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer913100301:OnCreate(caster, target)
	-- 913100301
	self:AddShield(BufferEffect[913100301], self.caster, target or self.owner, nil,1,0.05)
end
