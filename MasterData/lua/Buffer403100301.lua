-- 暴傷提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer403100301 = oo.class(BuffBase)
function Buffer403100301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer403100301:OnCreate(caster, target)
	-- 403100301
	self:AddAttr(BufferEffect[403100301], self.caster, self.card, nil, "crit",0.3)
end
