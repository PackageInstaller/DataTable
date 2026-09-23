-- 防禦強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984020202 = oo.class(BuffBase)
function Buffer984020202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer984020202:OnCreate(caster, target)
	-- 984020202
	self:AddAttrPercent(BufferEffect[984020202], self.caster, self.card, nil, "defense",0.1*self.nCount)
end
