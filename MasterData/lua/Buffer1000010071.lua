-- 傷害增加buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010071 = oo.class(BuffBase)
function Buffer1000010071:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010071:OnCreate(caster, target)
	-- 1000010071
	self:AddAttrPercent(BufferEffect[1000010071], self.caster, self.card, nil, "damage",0.5)
end
