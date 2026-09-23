-- 暴傷強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24302 = oo.class(BuffBase)
function Buffer24302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24302:OnCreate(caster, target)
	-- 24302
	self:AddAttr(BufferEffect[24302], self.caster, self.card, nil, "crit",0.04*self.nCount)
end
