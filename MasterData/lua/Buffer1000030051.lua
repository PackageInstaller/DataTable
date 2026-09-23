-- 暴擊傷害+20%，持續2回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000030051 = oo.class(BuffBase)
function Buffer1000030051:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000030051:OnCreate(caster, target)
	-- 1000030051
	self:AddAttr(BufferEffect[1000030051], self.caster, self.card, nil, "crit",0.2)
end
