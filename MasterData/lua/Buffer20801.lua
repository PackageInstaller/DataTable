-- 吸收護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer20801 = oo.class(BuffBase)
function Buffer20801:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer20801:OnCreate(caster, target)
	-- 20801
	self:AddShield(BufferEffect[20801], self.caster, self.card, nil, 6,0.15)
	-- 20804
	self:AddAttrPercent(BufferEffect[20804], self.caster, self.card, nil, "attack",0.15)
end
