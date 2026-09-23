-- 吸收護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer907800606 = oo.class(BuffBase)
function Buffer907800606:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer907800606:OnCreate(caster, target)
	-- 907800606
	self:AddShield(BufferEffect[907800606], self.caster, self.card, nil, 6,0.06)
end
