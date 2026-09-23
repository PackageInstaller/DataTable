-- 暴傷增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer339602 = oo.class(BuffBase)
function Buffer339602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer339602:OnCreate(caster, target)
	-- 339602
	self:AddAttr(BufferEffect[339602], self.caster, self.card, nil, "crit",0.02*self.nCount)
end
