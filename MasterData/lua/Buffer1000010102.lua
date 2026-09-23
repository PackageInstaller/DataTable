-- 暴擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010102 = oo.class(BuffBase)
function Buffer1000010102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010102:OnCreate(caster, target)
	-- 1000010102
	self:AddAttr(BufferEffect[1000010102], self.caster, self.card, nil, "crit_rate",1)
end
