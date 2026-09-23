-- 攻擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer20805 = oo.class(BuffBase)
function Buffer20805:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer20805:OnCreate(caster, target)
	-- 20805
	self:AddAttrPercent(BufferEffect[20805], self.caster, self.card, nil, "attack",0.30)
end
