-- 吸收護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2191 = oo.class(BuffBase)
function Buffer2191:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2191:OnCreate(caster, target)
	-- 2159
	self:AddShield(BufferEffect[2159], self.caster, target or self.owner, nil,3,30)
end
