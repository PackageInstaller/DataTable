-- 迅捷：加機動Ⅱ
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010151 = oo.class(BuffBase)
function Buffer1000010151:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010151:OnCreate(caster, target)
	-- 1000010151
	self:AddTempAttrPercent(BufferEffect[1000010151], self.caster, self.card, nil, "speed",0.16)
end
