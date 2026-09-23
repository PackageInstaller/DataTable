-- 斷劍
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer328803 = oo.class(BuffBase)
function Buffer328803:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer328803:OnCreate(caster, target)
	-- 328803
	self:AddAttrPercent(BufferEffect[328803], self.caster, self.card, nil, "attack",-0.20)
end
