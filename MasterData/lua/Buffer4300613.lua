-- 洞察先機
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4300613 = oo.class(BuffBase)
function Buffer4300613:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4300613:OnCreate(caster, target)
	-- 4300613
	self:AddAttr(BufferEffect[4300613], self.caster, self.card, nil, "damage",0.3*self.nCount)
end
