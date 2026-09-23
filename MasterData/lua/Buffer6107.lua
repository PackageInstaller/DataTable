-- 免疫退條
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6107 = oo.class(BuffBase)
function Buffer6107:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer6107:OnRoundBegin(caster, target)
	-- 6107
	self:ImmuneRetreat(BufferEffect[6107], self.caster, target or self.owner, nil,nil)
end
