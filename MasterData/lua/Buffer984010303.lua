-- 封印
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984010303 = oo.class(BuffBase)
function Buffer984010303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer984010303:OnRoundBegin(caster, target)
	-- 6102
	self:ImmuneBuffQuality(BufferEffect[6102], self.caster, target or self.owner, nil,1)
end
-- 伤害前
function Buffer984010303:OnBefourHurt(caster, target)
	-- 6102
	self:ImmuneBuffQuality(BufferEffect[6102], self.caster, target or self.owner, nil,1)
end
-- 创建时
function Buffer984010303:OnCreate(caster, target)
	-- 6102
	self:ImmuneBuffQuality(BufferEffect[6102], self.caster, target or self.owner, nil,1)
end
-- 回合结束时
function Buffer984010303:OnRoundOver(caster, target)
	-- 6102
	self:ImmuneBuffQuality(BufferEffect[6102], self.caster, target or self.owner, nil,1)
end
