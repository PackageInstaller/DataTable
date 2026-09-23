-- 迅捷：提速Ⅰ
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010011 = oo.class(BuffBase)
function Buffer1000010011:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010011:OnCreate(caster, target)
	-- 1000010011
	self:AddAttrPercent(BufferEffect[1000010011], self.caster, self.card, nil, "speed",0.25)
end
