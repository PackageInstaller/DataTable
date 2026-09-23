-- 即興編排
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200300202 = oo.class(BuffBase)
function Buffer200300202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200300202:OnCreate(caster, target)
	-- 200300202
	self:AddAttrPercent(BufferEffect[200300202], self.caster, self.card, nil, "attack",0.14)
end
