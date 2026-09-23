-- 強化狀態無效
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6105 = oo.class(BuffBase)
function Buffer6105:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer6105:OnRoundBegin(caster, target)
	-- 6105
	self:ImmuneBufferGroup(BufferEffect[6105], self.caster, target or self.owner, nil,2)
end
