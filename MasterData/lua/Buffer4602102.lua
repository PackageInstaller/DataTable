-- 強化暴擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4602102 = oo.class(BuffBase)
function Buffer4602102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4602102:OnCreate(caster, target)
	-- 4602102
	self:AddAttr(BufferEffect[4602102], self.caster, self.card, nil, "crit",0.04*self.nCount)
end
