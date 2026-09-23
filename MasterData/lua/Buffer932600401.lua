-- 防禦強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer932600401 = oo.class(BuffBase)
function Buffer932600401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer932600401:OnCreate(caster, target)
	-- 932600401
	self:AddAttr(BufferEffect[932600401], self.caster, self.card, nil, "defense",200*self.nCount)
end
