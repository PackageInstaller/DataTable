-- 攻擊增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4305004 = oo.class(BuffBase)
function Buffer4305004:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4305004:OnCreate(caster, target)
	-- 4305004
	self:AddAttrPercent(BufferEffect[4305004], self.caster, self.card, nil, "attack",0.12)
end
