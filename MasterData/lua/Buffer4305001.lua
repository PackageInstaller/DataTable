-- 攻擊增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4305001 = oo.class(BuffBase)
function Buffer4305001:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4305001:OnCreate(caster, target)
	-- 4305001
	self:AddAttrPercent(BufferEffect[4305001], self.caster, self.card, nil, "attack",0.03)
end
