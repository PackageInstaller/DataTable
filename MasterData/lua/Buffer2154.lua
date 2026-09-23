-- 吸收護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2154 = oo.class(BuffBase)
function Buffer2154:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2154:OnCreate(caster, target)
	-- 2154
	self:AddShield(BufferEffect[2154], self.caster, target or self.owner, nil,1,0.32)
end
