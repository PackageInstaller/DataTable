-- 洞察先機
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4300612 = oo.class(BuffBase)
function Buffer4300612:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4300612:OnCreate(caster, target)
	-- 4300612
	self:AddAttr(BufferEffect[4300612], self.caster, self.card, nil, "damage",0.2*self.nCount)
end
