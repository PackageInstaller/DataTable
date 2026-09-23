-- 吸收護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2130 = oo.class(BuffBase)
function Buffer2130:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2130:OnCreate(caster, target)
	-- 2130
	self:AddShield(BufferEffect[2130], self.caster, target or self.owner, nil,1,0.40)
end
