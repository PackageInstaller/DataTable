-- 暴擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer331302 = oo.class(BuffBase)
function Buffer331302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer331302:OnCreate(caster, target)
	-- 331302
	self:AddAttr(BufferEffect[331302], self.caster, self.card, nil, "crit_rate",0.04)
end
