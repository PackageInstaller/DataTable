-- 吸收護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2604 = oo.class(BuffBase)
function Buffer2604:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2604:OnCreate(caster, target)
	-- 2604
	self:AddShield(BufferEffect[2604], self.caster, target or self.owner, nil,1,0.04)
end
