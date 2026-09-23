-- 即興編排
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200300205 = oo.class(BuffBase)
function Buffer200300205:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200300205:OnCreate(caster, target)
	-- 200300205
	self:AddAttrPercent(BufferEffect[200300205], self.caster, self.card, nil, "attack",0.2)
end
