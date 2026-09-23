-- 強化暴擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4602101 = oo.class(BuffBase)
function Buffer4602101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4602101:OnCreate(caster, target)
	-- 4602101
	self:AddAttr(BufferEffect[4602101], self.caster, self.card, nil, "crit",0.02*self.nCount)
end
