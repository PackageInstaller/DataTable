-- 外殼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer932800801 = oo.class(BuffBase)
function Buffer932800801:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer932800801:OnCreate(caster, target)
	-- 932800801
	self:AddAttr(BufferEffect[932800801], self.caster, self.card, nil, "damage",0.1*self.nCount)
end
