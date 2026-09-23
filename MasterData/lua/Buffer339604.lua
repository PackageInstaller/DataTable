-- 暴傷增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer339604 = oo.class(BuffBase)
function Buffer339604:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer339604:OnCreate(caster, target)
	-- 339604
	self:AddAttr(BufferEffect[339604], self.caster, self.card, nil, "crit",0.06*self.nCount)
end
