-- 免疫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984020303 = oo.class(BuffBase)
function Buffer984020303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer984020303:OnRoundBegin(caster, target)
	-- 6103
	self:ImmuneBuffQuality(BufferEffect[6103], self.caster, target or self.owner, nil,2)
end
