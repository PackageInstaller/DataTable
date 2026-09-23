-- 免疫控制狀態
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6110 = oo.class(BuffBase)
function Buffer6110:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer6110:OnRoundBegin(caster, target)
	-- 6104
	self:ImmuneBufferGroup(BufferEffect[6104], self.caster, target or self.owner, nil,1)
	-- 6208
	self:ImmuneBuffID(BufferEffect[6208], self.caster, target or self.owner, nil,600500304)
end
