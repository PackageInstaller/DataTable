-- 免疫負面狀態
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6103 = oo.class(BuffBase)
function Buffer6103:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer6103:OnRoundBegin(caster, target)
	-- 6103
	self:ImmuneBuffQuality(BufferEffect[6103], self.caster, target or self.owner, nil,2)
end
