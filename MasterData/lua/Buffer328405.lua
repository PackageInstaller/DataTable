-- 背水
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer328405 = oo.class(BuffBase)
function Buffer328405:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer328405:OnCreate(caster, target)
	-- 328405
	self:AddAttrPercent(BufferEffect[328405], self.caster, self.card, nil, "defense",0.75)
end
