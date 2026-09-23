-- 吸收護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2129 = oo.class(BuffBase)
function Buffer2129:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2129:OnCreate(caster, target)
	-- 2129
	self:AddShield(BufferEffect[2129], self.caster, target or self.owner, nil,1,0.38)
end
