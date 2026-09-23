-- 共鳴：積蓄
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050171 = oo.class(BuffBase)
function Buffer1000050171:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000050171:OnCreate(caster, target)
	-- 1000050171
	self:AddAttrPercent(BufferEffect[1000050171], self.caster, self.card, nil, "damage",0.66)
end
