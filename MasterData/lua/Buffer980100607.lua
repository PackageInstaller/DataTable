-- 免疫控制
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980100607 = oo.class(BuffBase)
function Buffer980100607:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer980100607:OnRoundBegin(caster, target)
	-- 6104
	self:ImmuneBufferGroup(BufferEffect[6104], self.caster, target or self.owner, nil,1)
end
-- 创建时
function Buffer980100607:OnCreate(caster, target)
	-- 6104
	self:ImmuneBufferGroup(BufferEffect[6104], self.caster, target or self.owner, nil,1)
end
