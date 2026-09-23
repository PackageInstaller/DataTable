-- 吸收護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer923600502 = oo.class(BuffBase)
function Buffer923600502:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer923600502:OnCreate(caster, target)
	-- 20807
	self:AddShield(BufferEffect[20807], self.caster, self.card, nil, 7,50)
end
