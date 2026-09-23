-- 洞察先機
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4300614 = oo.class(BuffBase)
function Buffer4300614:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4300614:OnCreate(caster, target)
	-- 4300614
	self:AddAttr(BufferEffect[4300614], self.caster, self.card, nil, "damage",0.3*self.nCount)
end
