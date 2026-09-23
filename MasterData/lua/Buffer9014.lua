-- 弱化免疫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer9014 = oo.class(BuffBase)
function Buffer9014:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer9014:OnRoundBegin(caster, target)
	-- 6106
	self:ImmuneBufferGroup(BufferEffect[6106], self.caster, target or self.owner, nil,3)
end
