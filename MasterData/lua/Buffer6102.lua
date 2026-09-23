-- 封印
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6102 = oo.class(BuffBase)
function Buffer6102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer6102:OnRoundBegin(caster, target)
	-- 6102
	self:ImmuneBuffQuality(BufferEffect[6102], self.caster, target or self.owner, nil,1)
end
-- 创建时
function Buffer6102:OnCreate(caster, target)
	-- 6102
	self:ImmuneBuffQuality(BufferEffect[6102], self.caster, target or self.owner, nil,1)
end
