-- 背水
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer328401 = oo.class(BuffBase)
function Buffer328401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer328401:OnCreate(caster, target)
	-- 328401
	self:AddAttrPercent(BufferEffect[328401], self.caster, self.card, nil, "defense",0.15)
end
