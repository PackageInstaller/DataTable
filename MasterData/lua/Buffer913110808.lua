-- 免疫眩暈
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913110808 = oo.class(BuffBase)
function Buffer913110808:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer913110808:OnRoundBegin(caster, target)
	-- 6113
	self:ImmuneBuffID(BufferEffect[6113], self.caster, target or self.owner, nil,3004)
end
