-- 攻擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer20806 = oo.class(BuffBase)
function Buffer20806:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer20806:OnCreate(caster, target)
	-- 20806
	self:AddAttrPercent(BufferEffect[20806], self.caster, self.card, nil, "attack",0.45)
end
