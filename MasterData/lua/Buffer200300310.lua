-- 躁動樂章（變調）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200300310 = oo.class(BuffBase)
function Buffer200300310:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200300310:OnCreate(caster, target)
	-- 200300310
	self:AddAttr(BufferEffect[200300310], self.caster, self.card, nil, "damage",0.30)
end
