-- 強化暴擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4602103 = oo.class(BuffBase)
function Buffer4602103:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4602103:OnCreate(caster, target)
	-- 4602103
	self:AddAttr(BufferEffect[4602103], self.caster, self.card, nil, "crit",0.06*self.nCount)
end
