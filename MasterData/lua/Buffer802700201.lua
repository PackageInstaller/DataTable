-- 科迪護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer802700201 = oo.class(BuffBase)
function Buffer802700201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer802700201:OnCreate(caster, target)
	-- 2115
	self:AddShield(BufferEffect[2115], self.caster, target or self.owner, nil,1,0.16)
end
